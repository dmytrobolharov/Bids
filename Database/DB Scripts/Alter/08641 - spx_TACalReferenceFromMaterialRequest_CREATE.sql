IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalReferenceFromMaterialRequest_CREATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalReferenceFromMaterialRequest_CREATE]
GO


CREATE PROCEDURE [dbo].[spx_TACalReferenceFromMaterialRequest_CREATE](
	@TACalTemplateID UNIQUEIDENTIFIER,
	@MaterialTradePartnerID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(100),
	@CDate DATETIME,
	@ExistingRequest INT = 0
)

AS 

DECLARE @FolderID INT
DECLARE @TACalReferenceId UNIQUEIDENTIFIER = newid()

SELECT @FolderID = PermissionFolderTypeId FROM sPermissionFolderType WHERE LOWER(PermissionFolderTypeName) = LOWER('Material Request')

--add TACAlReference to material request
INSERT INTO pTACalReference ( TACalReferenceId, TACalTemplateId, TACalReferenceTypeId , ReferenceId, MUser, MDate, CUser, CDate, Active)
VALUES (@TACalReferenceId, @TACalTemplateId, @FolderID, @MaterialTradePartnerID, @CUser, @CDate, @CUser, @CDate, 1)

INSERT INTO pTACalReferenceTask (TACalReferenceId, TACalTemplateTaskId, TaskActualEnd, TaskActualStart, 
	TaskRevisedEnd, TaskRevisedlStart, TaskAssignedToId, TaskStatusId, Active, MUser, MDate, CUser, CDate)
SELECT @TACalReferenceId, tt.TACalTemplateTaskId, tt.TaskPlanEnd, tt.TaskPlanStart, 
	NULL, NULL, tt.TaskAssignedToId, 100, 1, @CUser, @CDate, @CUser, @CDate 
FROM pTACalTemplateTask tt
	INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = tt.TaskWorkflowId
WHERE tw.WorkflowFolder = 'MATERIAL REQUEST' AND tt.TACalTemplateId = @TACalTemplateId AND tt.New = 1 
AND tw.WorkflowId IN (
	SELECT DISTINCT pMaterialRequestWorkflow.MaterialRequestWorkflowGUIDID 
	FROM pMaterialRequestSubmitWorkflow WITH (NOLOCK) INNER JOIN
		pMaterialRequestWorkflow WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = pMaterialRequestWorkflow.MaterialRequestWorkflowID
	WHERE MaterialTradePartnerID = @MaterialTradePartnerID
) 

IF @ExistingRequest = 1
BEGIN
	-- update AssignedTo from calendar if it is empty
	UPDATE mrw 
	SET AssignedTo = u.UserID
	FROM pMaterialRequestSubmitWorkflow mrw
		INNER JOIN pMaterialRequestWorkflow ON mrw.MaterialRequestWorkflowID = pMaterialRequestWorkflow.MaterialRequestWorkflowID
		INNER JOIN pTACalReference r
				INNER JOIN pTACalReferenceTask rt ON r.TACalReferenceId = rt.TACalReferenceId
				INNER JOIN pTACalTemplateTask tt ON rt.TACalTemplateTaskId = tt.TACalTemplateTaskId
				INNER JOIN pTATaskWorkflow tw ON tt.TaskWorkflowId = tw.TATaskWorkflowId
			ON r.ReferenceId = @MaterialTradePartnerID AND pMaterialRequestWorkflow.MaterialRequestWorkflowGUIDID = tw.WorkflowId
		LEFT JOIN vwx_UserGroupDropDown_SEL u ON rt.TaskAssignedToId = u.TeamID
	WHERE mrw.MaterialTradePartnerID = @MaterialTradePartnerID AND (mrw.AssignedTo = 0 OR mrw.AssignedTo IS NULL)

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08641', GetDate())
GO
