UPDATE pWorkflow SET Workflow = 'Freelance Design' WHERE Workflow = 'Rough'
GO


UPDATE Mapping SET MapDetail = 'Freelance Design' WHERE MapDetail = 'Rough'
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06041', GetDate())
GO
