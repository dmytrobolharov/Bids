UPDATE sPermissionWorkflow SET Active = 1 WHERE WorkflowID = '70000000-0000-0000-0000-000000000001'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '6.1.0000', '09238', GetDate())
GO
