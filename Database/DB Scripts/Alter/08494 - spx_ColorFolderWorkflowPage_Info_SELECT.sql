IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorFolderWorkflowPage_Info_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorFolderWorkflowPage_Info_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_ColorFolderWorkflowPage_Info_SELECT]
	@ColorFolderID UNIQUEIDENTIFIER,
	@ColorFolderWorkflowID UNIQUEIDENTIFIER
AS

SELECT *
	, '~/System/Icons/' + ISNULL(ws.WorkflowStatusImage, 'icon_ball_gray.gif') AS StatusIconUrl 
	, 'Color_PaletteList.aspx' AS WorkflowPageUrl
FROM pColorFolderWorkflowPage cfwp
INNER JOIN pColorFolder cf ON cfwp.ColorFolderID = cf.ColorFolderID
LEFT JOIN pWorkflowStatus ws ON cfwp.WorkStatus = ws.WorkflowStatusID
LEFT JOIN vwx_UserGroupDropDown_SEL ug ON cfwp.WorkAssignedTo = ug.UserID
WHERE cfwp.ColorFolderID = @ColorFolderID AND cfwp.ColorFolderWorkflowID = @ColorFolderWorkflowID



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08494', GetDate())
GO
