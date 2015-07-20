INSERT INTO pTATaskWorkflow(WorkflowId,WorkflowName,WorkflowFolder,WorkflowSchemaGrid, WorkflowSchemaSearchGrid, Active)
SELECT WorkflowID, Workflow,'STYLE', 'TACalendarTemplateTask_Style_Reference.xml', 'TACalendarTemplateTask_Style_Reference_Search.xml',1 
FROM pWorkflow 
WHERE Active=1 AND Body=0 AND WorkflowTypeID <> '0' AND WorkflowID='40000000-0000-0000-0000-000000000099'

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10415', GetUTCDate())
GO