UPDATE sPermissionWorkflow
SET Active = 1
WHERE ParentWorkflowID IS NOT NULL
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09233', GetDate())
GO