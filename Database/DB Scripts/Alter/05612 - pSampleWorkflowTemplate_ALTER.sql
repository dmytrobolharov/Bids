IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pSampleWorkflowTemplate' AND COLUMN_NAME = 'DefaultTemplate')
BEGIN
	ALTER TABLE pSampleWorkflowTemplate ADD DefaultTemplate INT
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05612', GetDate())
GO
