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

/*
INSERT INTO pTACalReferenceTask (
	TACalReferenceId , TACalTemplateTaskId, TaskActualEnd, TaskActualStart, TaskRevisedEnd, TaskRevisedlStart, TaskAssignedToId, TaskStatusId, Active, 
	MUser, MDate, CUser, CDate)
SELECT cr.TACalReferenceId, tt.TACalTemplateTaskId, tt.TaskPlanEnd, tt.TaskPlanStart, tt.TaskPlanEnd, tt.TaskPlanStart, tt.TaskAssignedToId, 100, 1, 
	@CUser, @CDate, @CUser, @CDate  
FROM pMaterialWorkflowPage mwp
INNER JOIN pTACalReference cr ON mwp.MaterialID = cr.ReferenceId
INNER JOIN pTACalTemplateTask tt
	INNER JOIN pTATaskWorkflow tw ON tt.TaskWorkflowId = tw.TATaskWorkflowId
	ON mwp.MaterialTemplatePageID = tw.WorkflowId 
		AND tw.WorkflowFolder='MATERIAL'
		AND mwp.MaterialID = cr.ReferenceId
LEFT JOIN pTACalReferenceTask rt ON cr.TACalReferenceId = rt.TACalReferenceId 
	AND tt.TACalTemplateTaskId = rt.TACalTemplateTaskId
WHERE mwp.MaterialID = @MaterialID
	AND rt.TACalTemplateTaskId IS NULL
*/



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08629', GetDate())
GO
