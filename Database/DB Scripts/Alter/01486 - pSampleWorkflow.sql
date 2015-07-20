Update pSampleWorkflow set Active = 'No' where SampleWorkflowID in ('18A','20A','27A')
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '01486', GetDate())
GO