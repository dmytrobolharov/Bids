IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACal_BI_Menu_WithPermissions_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACal_BI_Menu_WithPermissions_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_TACal_BI_Menu_WithPermissions_SELECT]
(
	@TeamID UNIQUEIDENTIFIER
)

AS
BEGIN
	SELECT dfi.DashFolderItemID
		, dfi.DashFolderItemName
		, dfi.DashFolderItemIcon
		, dfi.DashFolderItemServerReportName
	FROM rDashFolderItem dfi
		INNER JOIN rDashFolder df ON dfi.DashFolderID = df.DashFolderID
		INNER JOIN fnx_Permissions_GetIntProductType_WorkflowPermissions(@TeamID, 17, 1) access ON access.WorkflowId = dfi.DashFolderItemID
	WHERE df.DashFolderName = 'Dev Calendar'
		AND (access.PermissionView = 1 OR access.PermissionRoleId = 3)
	ORDER BY dfi.DashFolderItemSort
		, dfi.DashFolderItemName

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09076', GetDate())
GO