UPDATE sPermissionWorkflow 
SET Active=0 
WHERE WorkflowId='50000000-0000-0000-0000-000000000051'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09861', GetDate())
GO