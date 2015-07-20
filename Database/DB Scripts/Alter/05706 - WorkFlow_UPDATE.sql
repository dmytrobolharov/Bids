UPDATE [Mapping] set MapDetail='Look Book' WHERE [Map]='40000000-0000-0000-0000-000000000085' 
UPDATE [pWorkFlow] set [Workflow]='Look Book' WHERE WorkflowID = '40000000-0000-0000-0000-000000000085' 

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05706', GetDate())
GO
