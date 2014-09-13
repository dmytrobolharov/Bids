UPDATE pSampleWorkflow SET SampleWorkflowSort = '000' WHERE SampleWorkflowID = '96A'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06052', GetDate())
GO
