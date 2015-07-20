IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalReferenceFromMaterialRequest_Logic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalReferenceFromMaterialRequest_Logic_UPDATE]
GO


CREATE PROCEDURE [dbo].[spx_TACalReferenceFromMaterialRequest_Logic_UPDATE](
	@MaterialTradePartnerID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
)
AS

DECLARE @CalReferences TABLE(
	ROW INT IDENTITY(1, 1),
	TACalReferenceId UNIQUEIDENTIFIER,
	TACalTemplateId UNIQUEIDENTIFIER)
	
INSERT INTO @CalReferences(TACalReferenceId, TACalTemplateId)
SELECT TACalReferenceId, TACalTemplateId 
FROM pTACalReference WHERE ReferenceId = @MaterialTradePartnerID

DECLARE @ROW INT = 1,
		@TOTAL INT = (SELECT COUNT(*) FROM @CalReferences)
		
WHILE @ROW <= @TOTAL
BEGIN
	DECLARE @TACalReferenceId UNIQUEIDENTIFIER,
			@TACalTemplateId UNIQUEIDENTIFIER
	SELECT @TACalReferenceId = TACalReferenceId,
		@TACalTemplateId = TACalTemplateId
	FROM @CalReferences WHERE ROW = @ROW

	-- add references if workflows were added to material request
	INSERT INTO pTACalReferenceTask ( TACalReferenceId , TACalTemplateTaskId, TaskActualEnd, TaskActualStart, 
		TaskRevisedEnd, TaskRevisedlStart, TaskAssignedToId, TaskStatusId, Active, MUser, MDate, CUser, CDate)
	SELECT @TACalReferenceId, tt.TACalTemplateTaskId, tt.TaskPlanEnd, tt.TaskPlanStart, 
		NULL, NULL, tt.TaskAssignedToId, 100, 1, @CUser, @CDate, @CUser, @CDate 
	FROM pTACalTemplateTask tt
		INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = tt.TaskWorkflowId
		LEFT JOIN pTACalReferenceTask rt ON tt.TACalTemplateTaskId = rt.TACalTemplateTaskId AND rt.TACalReferenceId = @TACalReferenceId
	WHERE tw.WorkflowFolder = 'MATERIAL REQUEST' and tt.TACalTemplateId = @TACalTemplateId AND tt.New = 1 
	AND rt.TACalReferenceId IS NULL
	AND tw.WorkflowId IN (
		SELECT DISTINCT pMaterialRequestWorkflow.MaterialRequestWorkflowGUIDID 
		FROM pMaterialRequestSubmitWorkflow WITH (NOLOCK) INNER JOIN
			pMaterialRequestWorkflow WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = pMaterialRequestWorkflow.MaterialRequestWorkflowID
		WHERE MaterialTradePartnerID = @MaterialTradePartnerID
	) 

	-- update AssignedTo from calendar if it is empty
	UPDATE mrw SET AssignedTo = ug.UserID
	FROM pMaterialRequestSubmitWorkflow mrw
	INNER JOIN pMaterialRequestWorkflow ON mrw.MaterialRequestWorkflowID = pMaterialRequestWorkflow.MaterialRequestWorkflowID
	INNER JOIN pTACalReferenceTask rt 
		INNER JOIN pTACalTemplateTask tt ON rt.TACalTemplateTaskId = tt.TACalTemplateTaskId
		INNER JOIN pTATaskWorkflow tw ON tt.TaskWorkflowId = tw.TATaskWorkflowId 
		ON pMaterialRequestWorkflow.MaterialRequestWorkflowGUIDID = tw.WorkflowId AND rt.TACalReferenceId = @TACalReferenceId
	INNER JOIN vwx_UserGroupDropDown_SEL ug ON tt.TaskAssignedToId = ug.TeamID
	WHERE mrw.MaterialTradePartnerID = @MaterialTradePartnerID 
		AND (mrw.AssignedTo IS NULL OR mrw.AssignedTo = 0)

		
	-- delete references if workflows were removed from material request
	DELETE rt 
	FROM pTACalReferenceTask rt
		INNER JOIN pTACalTemplateTask tt ON rt.TACalTemplateTaskId = tt.TACalTemplateTaskId
		INNER JOIN pTATaskWorkflow tw ON tt.TaskWorkflowId = tw.TATaskWorkflowId
	WHERE TACalReferenceId = @TACalReferenceId
	AND tw.WorkflowId NOT IN (
		SELECT DISTINCT pMaterialRequestWorkflow.MaterialRequestWorkflowGUIDID 
		FROM pMaterialRequestSubmitWorkflow WITH (NOLOCK) INNER JOIN
			pMaterialRequestWorkflow WITH (NOLOCK) ON pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = pMaterialRequestWorkflow.MaterialRequestWorkflowID
		WHERE MaterialTradePartnerID = @MaterialTradePartnerID
	)

	SET @ROW = @ROW + 1
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08760', GetDate())
GO
