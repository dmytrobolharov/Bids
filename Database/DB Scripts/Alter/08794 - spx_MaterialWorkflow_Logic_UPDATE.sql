/****** Object:  StoredProcedure [dbo].[spx_MaterialWorkflow_Logic_UPDATE]    Script Date: 08/13/2014 14:47:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialWorkflow_Logic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialWorkflow_Logic_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialWorkflow_Logic_UPDATE]    Script Date: 08/13/2014 14:47:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
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
LEFT JOIN pMaterialWorkflowPage mwp ON mti.MaterialTemplatePageID = mwp.MaterialTemplatePageID
	AND m.MaterialID = mwp.MaterialID
WHERE m.MaterialID = @MaterialID AND mwp.MaterialWorkflowPageID IS NULL




INSERT INTO pTACalReferenceTask ( TACalReferenceId , TACalTemplateTaskId, TaskActualEnd, TaskActualStart, TaskRevisedEnd, TaskRevisedlStart, TaskAssignedToId, TaskStatusId, Active, MUser, MDate, CUser, CDate)
select cr.TACalReferenceId, tt.TACalTemplateTaskId, tt.TaskPlanEnd, tt.TaskPlanStart, NULL, NULL, tt.TaskAssignedToId, 100, 1, @CUser, @CDate, @CUser, @CDate from pTACalTemplateTask  tt
INNER JOIN pTACalReference cr ON cr.TACalTemplateId = tt.TACalTemplateId
INNER JOIN pTACalTemplate ct ON ct.TACalTemplateId = cr.TACalTemplateId
INNER JOIN pTATaskWorkflow tw ON tw.TATaskWorkflowId = tt.TaskWorkflowId
INNER JOIN pMaterial mt ON mt.MaterialID = cr.ReferenceId
where tw.WorkflowFolder='MATERIAL' AND mt.MaterialID = @MaterialID 
AND ((tt.New=1 AND ct.SeasonYearId = mt.IntroSeasonYearID) OR (tt.CarryOver = 1 AND ct.SeasonYearId <> mt.IntroSeasonYearID))  
AND tw.WorkflowId in (SELECT  ti.MaterialTemplatePageID 
            FROM pMaterialTemplateItem ti 
             INNER JOIN pMaterialTemplatePage tp ON ti.MaterialTemplatePageID = tp.MaterialTemplatePageID 
             INNER JOIN pMaterial  pm on ti.MaterialTemplateID = pm.MaterialTemplateID
             Where pm.MaterialID=cr.ReferenceId) 
 AND tt.TACalTemplateTaskId not in (select tempref.TACalTemplateTaskId from pTACalReferenceTask tempref where tempref.TACalReferenceId = cr.TACalReferenceId)

delete rt from pTACalReferenceTask rt
INNER JOIN pTACalReference cr ON rt.TACalReferenceId = cr.TACalReferenceId
INNER JOIN pTACalTemplateTask tt ON tt.TACalTemplateTaskId = rt.TACalTemplateTaskId
iNNER JOIN pTATaskWorkflow tw ON tt.TaskWorkflowId = tw.TATaskWorkflowId
where cr.ReferenceId=@MaterialID AND tw.WorkflowFolder='MATERIAL' and tw.WorkflowId not in (select mw.MaterialTemplatePageID from vwx_MaterialPageWorkflows_SEL mw WHERE mw.MaterialID = @MaterialID )

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08794', GetDate())
GO
