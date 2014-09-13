IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ImageWorkflowStatus_MailHeader_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ImageWorkflowStatus_MailHeader_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_ImageWorkflowStatus_MailHeader_SELECT]
	@ImageWorkflowPageID UNIQUEIDENTIFIER
AS

SELECT 'Image ' + i.ImageNo + ' (' + ISNULL(iwti.ImageWorkflowTemplateItemName, '') + ' Status) Notification'
FROM pImageWorkflowPage iwp
INNER JOIN pImageWorkflowTemplateItem iwti ON iwp.ImageWorkflowTemplateItemID = iwti.ImageWorkflowTemplateItemID
INNER JOIN pImage i ON iwp.ImageID = i.ImageID
LEFT JOIN pWorkflowStatus ws ON iwp.WorkStatus = ws.WorkflowStatusID
WHERE iwp.ImageWorkflowPageID = @ImageWorkflowPageID


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08444', GetDate())
GO
