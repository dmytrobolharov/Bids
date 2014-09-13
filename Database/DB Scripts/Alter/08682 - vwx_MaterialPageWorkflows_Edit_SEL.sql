IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_MaterialPageWorkflows_Edit_SEL]'))
DROP VIEW [dbo].[vwx_MaterialPageWorkflows_Edit_SEL]
GO

CREATE VIEW [dbo].[vwx_MaterialPageWorkflows_Edit_SEL]
AS
SELECT mwp.MaterialWorkflowPageID
	,mwp.MaterialID
	,mwp.MaterialTemplateItemID
	,mwp.MaterialTemplatePageID
	,ISNULL(tt.TaskPlanStart, mwp.WorkStart) AS WorkStart
	,ISNULL(tt.TaskPlanEnd, mwp.WorkDue) AS WorkDue
	,mwp.WorkAssignedTo
	,mwp.WorkStatus
	,mwp.WorkStatusDate
	,mwp.ActualStart
	,mwp.ActualEnd
	,mwp.CUser
	,mwp.CDate
	,mwp.MUser
	,mwp.MDate
	,mtp.MaterialTemplatePageDesc
	,mtp.MaterialTemplatePageName
	,mtp.MaterialTemplatePageURL
	,ws.WorkflowStatusImage AS StatusImage
	,ws.WorkflowStatus
	,ISNULL(mti.Sort, mwp.Sort) AS Sort
	,CASE WHEN rt.TACalRefTaskId IS NULL THEN 0 ELSE 1 END AS HasCalendar
FROM pMaterialWorkflowPage mwp
INNER JOIN pMaterial m ON mwp.MaterialID = m.MaterialID
INNER JOIN pMaterialTemplateItem mti ON m.MaterialTemplateID = mti.MaterialTemplateID
	AND mwp.MaterialTemplatePageID = mti.MaterialTemplatePageID
INNER JOIN pMaterialTemplatePage mtp ON mwp.MaterialTemplatePageID = mtp.MaterialTemplatePageID
LEFT JOIN pWorkflowStatus ws ON mwp.WorkStatus = ws.WorkflowStatusID
LEFT JOIN pTACalReference cr 
	INNER JOIN pTACalReferenceTask rt ON cr.TACalReferenceId = rt.TACalReferenceId
	INNER JOIN pTACalTemplateTask tt ON rt.TACalTemplateTaskId = tt.TACalTemplateTaskId
	INNER JOIN pTATaskWorkflow tw ON tt.TaskWorkflowId = tw.TATaskWorkflowId
	ON mwp.MaterialID = cr.ReferenceId AND mwp.MaterialTemplatePageID = tw.WorkflowId




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08682', GetDate())
GO
