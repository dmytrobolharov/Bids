IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialWorkflowPage_Info_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialWorkflowPage_Info_SELECT]
GO

-- you should provide either @MaterialWorkflowPageID OR (@MaterialID AND @MaterialTemplatePageID)
CREATE PROCEDURE [dbo].[spx_MaterialWorkflowPage_Info_SELECT]
	@MaterialWorkflowPageID UNIQUEIDENTIFIER = NULL,
	@MaterialID UNIQUEIDENTIFIER = NULL,
	@MaterialTemplatePageID UNIQUEIDENTIFIER = NULL
AS

IF @MaterialWorkflowPageID IS NULL
	SELECT @MaterialWorkflowPageID = MaterialWorkflowPageID 
	FROM pMaterialWorkflowPage WHERE MaterialID = @MaterialID 
		AND MaterialTemplatePageID = @MaterialTemplatePageID

SELECT *
	, CAST(ISNULL(tt.TaskPlanEnd, mwp.WorkDue) AS DATETIME) AS WorkflowDueDate
	, '~/System/Icons/' + ISNULL(ws.WorkflowStatusImage, 'icon_ball_gray.gif') AS StatusIconUrl 
FROM pMaterialWorkflowPage mwp
INNER JOIN pMaterialTemplatePage mtp ON mwp.MaterialTemplatePageID = mtp.MaterialTemplatePageID
INNER JOIN pMaterial m ON mwp.MaterialID = m.MaterialID
LEFT JOIN pWorkflowStatus ws ON mwp.WorkStatus = ws.WorkflowStatusID
LEFT JOIN vwx_UserGroupDropDown_SEL ug ON mwp.WorkAssignedTo = ug.UserID
LEFT JOIN pTACalReference cr 
	INNER JOIN pTACalReferenceTask rt ON cr.TACalReferenceId = rt.TACalReferenceId
	INNER JOIN pTACalTemplateTask tt ON rt.TACalTemplateTaskId = tt.TACalTemplateTaskId
	INNER JOIN pTATaskWorkflow tw ON tt.TaskWorkflowId = tw.TATaskWorkflowId
	ON mwp.MaterialID = cr.ReferenceId AND mwp.MaterialTemplatePageID = tw.WorkflowId
WHERE MaterialWorkflowPageID = @MaterialWorkflowPageID



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08687', GetDate())
GO
