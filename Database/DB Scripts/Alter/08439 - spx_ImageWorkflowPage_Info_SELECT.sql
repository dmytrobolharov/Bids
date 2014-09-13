IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ImageWorkflowPage_Info_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ImageWorkflowPage_Info_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_ImageWorkflowPage_Info_SELECT]
	@ImageID UNIQUEIDENTIFIER,
	@ImageWorkflowTemplateItemID UNIQUEIDENTIFIER
AS

SELECT *
	, '~/System/Icons/' + ISNULL(ws.WorkflowStatusImage, 'icon_ball_gray.gif') AS StatusIconUrl 
FROM pImageWorkflowPage iwp
INNER JOIN pImageWorkflowTemplateItem iwti 
	ON iwp.ImageWorkflowTemplateItemID = iwti.ImageWorkflowTemplateItemID
INNER JOIN pImage i ON iwp.ImageID = i.ImageID
LEFT JOIN pImageType it ON  i.ImageSubFolder1 = it.ImageType
LEFT JOIN pWorkflowStatus ws ON iwp.WorkStatus = ws.WorkflowStatusID
LEFT JOIN vwx_UserGroupDropDown_SEL ug ON iwp.WorkAssignedTo = ug.UserID
WHERE iwp.ImageID = @ImageID AND iwp.ImageWorkflowTemplateItemID = @ImageWorkflowTemplateItemID



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08439', GetDate())
GO
