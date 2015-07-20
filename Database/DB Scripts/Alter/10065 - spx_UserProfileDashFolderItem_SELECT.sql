IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_UserProfileDashFolderItem_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_UserProfileDashFolderItem_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_UserProfileDashFolderItem_SELECT]
(
	@TeamID UNIQUEIDENTIFIER
)
AS
BEGIN
	SELECT Users.DashFolderItemID
		, rDashFolderItem.DashFolderItemServerReportName
	FROM rDashFolderItem
		INNER JOIN Users ON rDashFolderItem.DashFolderItemID = Users.DashFolderItemID
	WHERE Users.TeamID = @TeamID
END
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10065', GetUTCDate())
GO
