IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ImageWorkflowPage_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ImageWorkflowPage_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_ImageWorkflowPage_SELECT]
	@ImageID UNIQUEIDENTIFIER
AS

SELECT *
	, '<img src="../System/Icons/' + ws.WorkflowStatusImage + '" alt="" />' AS StatusIcon
FROM pImageWorkflowPage iwp
INNER JOIN pImageWorkflowTemplateItem iwti ON iwp.ImageWorkflowTemplateItemID = iwti.ImageWorkflowTemplateItemID
LEFT JOIN vwx_UserGroupDropDown_SEL ug ON iwp.WorkAssignedTo = ug.UserID
LEFT JOIN pWorkflowStatus ws ON iwp.WorkStatus = ws.WorkflowStatusID
WHERE iwp.ImageID = @ImageID


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08440', GetDate())
GO
