IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='rDashFolderItem' AND COLUMN_NAME='DashFolderItemVisible')
BEGIN
	ALTER TABLE rDashFolderItem
	ADD DashFolderItemVisible INT DEFAULT 1
END

GO

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='rReportFolderItem' AND COLUMN_NAME='ReportFolderItemVisible')
BEGIN
	ALTER TABLE rReportFolderItem
	ADD ReportFolderItemVisible INT DEFAULT 1
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10006', GetUTCDate())
GO
