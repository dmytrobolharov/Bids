IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialWorkflow_Logic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialWorkflow_Logic_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_MaterialWorkflow_Logic_UPDATE]
	@MaterialID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS

-- insert missing workflow pages
INSERT INTO pMaterialWorkflowPage(
	MaterialID, MaterialTemplateItemID, MaterialTemplatePageID,
	WorkStart, WorkDue, WorkAssignedTo, WorkStatus,
	Sort, CUser, CDate, MUser, MDate)
SELECT m.MaterialID, mti.MaterialTemplateItemID, mti.MaterialTemplatePageID,
	NULL, NULL, NULL, 1,
	mti.Sort, @CUser, @CDate, @CDate, @CDate
FROM pMaterial m
INNER JOIN pMaterialTemplateItem mti ON m.MaterialTemplateID = mti.MaterialTemplateID
LEFT JOIN pMaterialWorkflowPage mwp ON mti.MaterialTemplateItemID = mwp.MaterialTemplateItemID
	AND m.MaterialID = mwp.MaterialID
WHERE m.MaterialID = @MaterialID AND mwp.MaterialWorkflowPageID IS NULL


DECLARE @CalReferences TABLE(
	ROW INT IDENTITY(1, 1),
	TACalReferenceId UNIQUEIDENTIFIER,
	TACalTemplateId UNIQUEIDENTIFIER)
	
INSERT INTO @CalReferences(TACalReferenceId, TACalTemplateId)
SELECT TACalReferenceId, TACalTemplateId 
FROM pTACalReference WHERE ReferenceId = @MaterialID

DECLARE @ROW INT = 1,
		@TOTAL INT = (SELECT COUNT(*) FROM @CalReferences)
		
WHILE @ROW <= @TOTAL
BEGIN
	DECLARE @TACalReferenceId UNIQUEIDENTIFIER,
			@TACalTemplateId UNIQUEIDENTIFIER
	SELECT @TACalReferenceId = TACalReferenceId,
		@TACalTemplateId = TACalTemplateId
	FROM @CalReferences WHERE ROW = @ROW

	DELETE FROM pTACalReferenceTask WHERE TACalReferenceId = @TACalReferenceId

	INSERT INTO pTACalReferenceTask ( TACalReferenceId , TACalTemplateTaskId, TaskActualEnd, TaskActualStart, TaskRevisedEnd, TaskRevisedlStart, TaskAssignedToId, TaskStatusId, Active, MUser, MDate, CUser, CDate)
	select @TACalReferenceId, tt.TACalTemplateTaskId, tt.TaskPlanEnd, tt.TaskPlanStart, tt.TaskPlanEnd, tt.TaskPlanStart, tt.TaskAssignedToId, 100, 1, @CUser, @CDate, @CUser, @CDate from pTACalTemplateTask  tt
	INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = tt.TaskWorkflowId
	where tw.WorkflowFolder='MATERIAL' and tt.TACalTemplateId=@TACalTemplateId  and tt.New=1 
	AND tw.WorkflowId in (SELECT  ti.MaterialTemplatePageID 
				FROM pMaterialTemplateItem ti 
				 INNER JOIN pMaterialTemplatePage tp ON ti.MaterialTemplatePageID = tp.MaterialTemplatePageID 
				 INNER JOIN pMaterial  pm on ti.MaterialTemplateID = pm.MaterialTemplateID
				 Where pm.MaterialID=@MaterialID) 
	             
	-- update assigned to? if there is none
	UPDATE mwp SET WorkAssignedTo = ug.UserID
	FROM pMaterialWorkflowPage mwp
	INNER JOIN pTACalReferenceTask rt 
		INNER JOIN pTACalTemplateTask tt ON rt.TACalTemplateTaskId = tt.TACalTemplateTaskId
		INNER JOIN pTATaskWorkflow tw ON tt.TaskWorkflowId = tw.TATaskWorkflowId 
		ON mwp.MaterialTemplatePageID = tw.WorkflowId AND rt.TACalReferenceId = @TACalReferenceId
	INNER JOIN vwx_UserGroupDropDown_SEL ug ON tt.TaskAssignedToId = ug.TeamID
	WHERE mwp.MaterialID = @MaterialID 
		AND (mwp.WorkAssignedTo IS NULL OR mwp.WorkAssignedTo = 0)

	SET @ROW = @ROW + 1
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08657', GetDate())
GO
