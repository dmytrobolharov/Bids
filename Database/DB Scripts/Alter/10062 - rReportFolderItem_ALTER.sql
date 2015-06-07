IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'rReportFolderItem' AND COLUMN_NAME = 'ReportItemURL')
ALTER TABLE rReportFolderItem DROP COLUMN ReportItemURL
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10062', GetUTCDate())
GO
