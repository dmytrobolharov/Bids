IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_UserProfileDashFolderItem_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_UserProfileDashFolderItem_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_UserProfileDashFolderItem_SELECT](@TeamID uniqueidentifier)
AS 

SELECT     Users.DashFolderItemID, rDashFolderItem.DashFolderItemServerUrl, rDashFolderItem.DashFolderItemServerUrl,
			rDashFolderItem.DashFolderItemServerFolderName, rDashFolderItem.DashFolderItemServerReportName
FROM         rDashFolderItem INNER JOIN
                      Users ON rDashFolderItem.DashFolderItemID = Users.DashFolderItemID
where Users.TeamID = @TeamID


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04813', GetDate())
GO

