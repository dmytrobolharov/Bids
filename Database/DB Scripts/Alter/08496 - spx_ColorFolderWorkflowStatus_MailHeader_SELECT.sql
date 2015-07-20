IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorFolderWorkflowStatus_MailHeader_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorFolderWorkflowStatus_MailHeader_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_ColorFolderWorkflowStatus_MailHeader_SELECT]
	@ColorFolderWorkflowPageID UNIQUEIDENTIFIER
AS

SELECT 'Color Palette ' + cf.ColorFolderDescription + ' (Color Palette Status) Notification'
FROM pColorFolderWorkflowPage cfwp
INNER JOIN pColorFolder cf ON cfwp.ColorFolderID = cf.ColorFolderID
LEFT JOIN pWorkflowStatus ws ON cfwp.WorkStatus = ws.WorkflowStatusID
WHERE cfwp.ColorFolderWorkflowPageID = @ColorFolderWorkflowPageID



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08496', GetDate())
GO
