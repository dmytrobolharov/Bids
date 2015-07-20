UPDATE pTATaskWorkflow SET WorkflowId='10000000-0000-0000-0000-000000000000' WHERE WorkflowFolder='COLOR'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08711', GetDate())
GO
