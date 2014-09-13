IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialWorkflowPage_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialWorkflowPage_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialWorkflowPage_SELECT] 
	@MaterialID UNIQUEIDENTIFIER
AS

SELECT mwp.*
	,mtp.MaterialTemplatePageDesc
	,mtp.MaterialTemplatePageName
	,mtp.MaterialTemplatePageURL
	,ws.WorkflowStatusImage AS StatusImage
	,ws.WorkflowStatus
	,'<img src="../System/Icons/' + ws.WorkflowStatusImage + '" alt="" />' AS StatusIcon
FROM pMaterialWorkflowPage mwp
INNER JOIN pMaterialTemplatePage mtp ON mwp.MaterialTemplatePageID = mtp.MaterialTemplatePageID
LEFT JOIN pWorkflowStatus ws ON mwp.WorkStatus = ws.WorkflowStatusID
LEFT JOIN pMaterialTemplateItem mti ON mwp.MaterialTemplateItemID = mti.MaterialTemplateItemID
WHERE mwp.MaterialID = @MaterialID
ORDER BY mti.Sort
	,mwp.Sort
	

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08419', GetDate())
GO
