DELETE FROM rReportFolder WHERE ReportFolderName = 'Sample Folder'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0001', '09168', GetDate())
GO
