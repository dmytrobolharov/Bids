IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_DashFolder_Items_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_DashFolder_Items_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_DashFolder_Items_SELECT]
	@DashFolderID UNIQUEIDENTIFIER
AS
BEGIN
	SELECT DashFolderItemID
		, DashFolderID
		, DashFolderItemName
		, DashFolderItemIcon
		, DashFolderItemSort
		, DashFolderItemActive
	FROM rDashFolderItem
	WHERE DashFolderItemActive = 1
		AND DashFolderItemVisible = 1
		AND DashFolderID = @DashFolderID
	ORDER BY DashFolderItemSort
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10063', GetUTCDate())
GO
