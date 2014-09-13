UPDATE pSampleWorkflow SET SampleWorkflowGUID = NEWID() WHERE SampleWorkflowGUID IS NULL
GO

ALTER TABLE pSampleWorkflow ALTER COLUMN SampleWorkflowGUID UNIQUEIDENTIFIER NOT NULL
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08012', GetDate())
GO
