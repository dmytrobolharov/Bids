IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pSampleWorkflow' AND COLUMN_NAME = 'SampleWorkflowGUID')
BEGIN
	ALTER TABLE pSampleWorkflow ADD SampleWorkflowGUID UNIQUEIDENTIFIER
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08003', GetDate())
GO