UPDATE rDashFolderItem SET DashFolderItemVisible = DashFolderItemActive
WHERE DashFolderItemVisible IS NULL
GO

UPDATE rReportFolderItem SET ReportFolderItemVisible = ReportFolderItemActive
WHERE ReportFolderItemVisible IS NULL
GO

UPDATE rDashFolderItem
SET DashFolderItemActive = 1
WHERE DashFolderItemName IN ('Action Details', 'Calendar Extract')
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10007', GetUTCDate())
GO
