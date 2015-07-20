IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialWorkflowStatus_MailHeader_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialWorkflowStatus_MailHeader_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialWorkflowStatus_MailHeader_SELECT]
	@MaterialWorkflowPageID UNIQUEIDENTIFIER
AS

SELECT 'Material ' + m.MaterialNo + ' (' + ISNULL(mtp.MaterialTemplatePageName, '') + ' Status) Notification'
FROM pMaterialWorkflowPage mwp
INNER JOIN pMaterialTemplatePage mtp ON mwp.MaterialTemplatePageID = mtp.MaterialTemplatePageID
INNER JOIN pMaterial m ON mwp.MaterialID = m.MaterialID
LEFT JOIN pWorkflowStatus ws ON mwp.WorkStatus = ws.WorkflowStatusID
WHERE mwp.MaterialWorkflowPageID = @MaterialWorkflowPageID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08432', GetDate())
GO
