/****** Object:  StoredProcedure [dbo].[spx_Planning_BI_Menu_WithPermissions_SELECT]    Script Date: 04/14/2014 14:38:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_BI_Menu_WithPermissions_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_BI_Menu_WithPermissions_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_BI_Menu_WithPermissions_SELECT](
@PlanningTypeId uniqueidentifier,
@TeamID  uniqueidentifier
)

AS
BEGIN
		SELECT dfi.DashFolderItemID
		, dfi.DashFolderItemName
		, dfi.DashFolderItemIcon
		, dfi.DashFolderItemServerReportName
	FROM rDashFolderItem dfi
		INNER JOIN rDashFolder df ON dfi.DashFolderID = df.DashFolderID
		INNER JOIN sAccessPlanningFolderItem access 
		ON access.PlanningItemID = dfi.DashFolderItemID AND access.TeamID = @TeamID AND access.PlanningTypeID = @PlanningTypeId
	WHERE df.DashFolderName = 'Planning' AND (access.AccessView = 1 OR access.AccessRoleId = 3)
	ORDER BY dfi.DashFolderItemSort, dfi.DashFolderItemName
END



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07473', GetDate())
GO