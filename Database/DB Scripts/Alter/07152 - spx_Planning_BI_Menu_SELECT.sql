IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_BI_Menu_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_BI_Menu_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_BI_Menu_SELECT]

AS
BEGIN
	SELECT dfi.DashFolderItemID
		, dfi.DashFolderItemName
		, dfi.DashFolderItemIcon
		, dfi.DashFolderItemServerReportName
	FROM rDashFolderItem dfi
		INNER JOIN rDashFolder df ON dfi.DashFolderID = df.DashFolderID
	WHERE df.DashFolderName = 'Planning'
	ORDER BY dfi.DashFolderItemSort, dfi.DashFolderItemName
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07152', GetDate())
GO
