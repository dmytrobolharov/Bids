Delete FROM pWorkflowTemplateItem where WorkflowTemplateID in (select WorkflowTemplateID from pWorkflowTemplate where Body = 0)
AND WorkflowID in ('11111111-0000-0000-0000-000000000002','11111111-0000-0000-0000-000000000003','11111111-0000-0000-0000-000000000004')
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '01473', GetDate())
GO
