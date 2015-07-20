UPDATE pWorkflowItemType SET ItemTypeLabel = 'Freelance Design' WHERE ItemTypeLabel = 'Rough'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06054', GetDate())
GO
