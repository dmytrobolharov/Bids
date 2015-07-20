UPDATE rDashFolderItem
SET DashFolderItemActive = 0
WHERE DashFolderItemServerReportName = 'Dash_SampleVendorScore'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01082', GetDate())
GO