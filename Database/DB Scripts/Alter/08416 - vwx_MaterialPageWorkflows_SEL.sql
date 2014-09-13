IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_MaterialPageWorkflows_SEL]'))
DROP VIEW [dbo].[vwx_MaterialPageWorkflows_SEL]
GO

CREATE VIEW [dbo].[vwx_MaterialPageWorkflows_SEL]
AS
SELECT mwp.MaterialWorkflowPageID
	,mwp.MaterialID
	,mwp.MaterialTemplateItemID
	,mwp.MaterialTemplatePageID
	,mwp.WorkStart
	,mwp.WorkDue
	,mwp.WorkAssignedTo
	,mwp.WorkStatus
	,mwp.WorkStatusDate
	,mwp.CUser
	,mwp.CDate
	,mwp.MUser
	,mwp.MDate
	,mtp.MaterialTemplatePageDesc
	,mtp.MaterialTemplatePageName
	,mtp.MaterialTemplatePageURL
	,ws.WorkflowStatusImage AS StatusImage
	,ISNULL(mti.Sort, mwp.Sort) AS Sort
FROM pMaterialWorkflowPage mwp
INNER JOIN pMaterialTemplatePage mtp ON mwp.MaterialTemplatePageID = mtp.MaterialTemplatePageID
LEFT JOIN pWorkflowStatus ws ON mwp.WorkStatus = ws.WorkflowStatusID
LEFT JOIN pMaterialTemplateItem mti ON mwp.MaterialTemplateItemID = mti.MaterialTemplateItemID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08416', GetDate())
GO
