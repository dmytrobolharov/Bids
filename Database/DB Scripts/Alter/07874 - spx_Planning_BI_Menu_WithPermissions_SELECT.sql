/****** Object:  StoredProcedure [dbo].[spx_Planning_BI_Menu_WithPermissions_SELECT]    Script Date: 06/04/2014 13:03:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_BI_Menu_WithPermissions_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_BI_Menu_WithPermissions_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_Planning_BI_Menu_WithPermissions_SELECT]    Script Date: 06/04/2014 13:03:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
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
		INNER JOIN fnx_Permissions_GetGuidProductType_WorkflowPermissions(@TeamID, 22, @PlanningTypeId) access 
		ON access.WorkflowId = dfi.DashFolderItemID 
	WHERE df.DashFolderName = 'Planning' AND (access.PermissionView = 1 OR access.PermissionRoleId = 3)
	ORDER BY dfi.DashFolderItemSort, dfi.DashFolderItemName
END




GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07874', GetDate())
GO