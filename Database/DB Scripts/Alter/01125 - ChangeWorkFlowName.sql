update pWorkflow set Workflow = 'Process Details' where WorkflowID = '80000000-0000-0000-0000-000000000008'
GO
update Mapping set MapDetail = 'Process Details' where Map = '80000000-0000-0000-0000-000000000008'
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01125', GetDate())
GO