IF NOT EXISTS(SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE 
				TABLE_NAME = 'rReportStylePageItemTemp' AND COLUMN_NAME = 'ReportBatchQueueID')
BEGIN
	ALTER TABLE rReportStylePageItemTemp ADD ReportBatchQueueID UNIQUEIDENTIFIER NULL
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '06915', GetDate())
GO
