IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_DashFolderItem_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_DashFolderItem_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_DashFolderItem_SELECT]
(
	@DashFolderItemID UNIQUEIDENTIFIER
)
AS
BEGIN
	SELECT DashFolderItemID
		, DashFolderID
		, DashFolderItemName
		, DashFolderItemIcon
		, DashFolderItemSort
		, DashFolderItemActive
		, DashFolderItemServerReportName
	FROM rDashFolderItem
	WHERE DashFolderItemID = @DashFolderItemID
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10064', GetUTCDate())
GO
