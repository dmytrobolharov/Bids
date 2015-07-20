UPDATE rDashFolderItem SET DashFolderItemActive = 1 WHERE DashFolderItemServerReportName = 'Dash_Style_CostingScenario'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06114', GetDate())
GO
