DELETE FROM rReportFolder WHERE ReportFolderName = 'Sample Folder'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09172', GetDate())
GO
