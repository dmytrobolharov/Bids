DELETE FROM rReportFolder WHERE ReportFolderName = 'Sourcing Folder'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0.0000', '05664', GetDate())
GO
