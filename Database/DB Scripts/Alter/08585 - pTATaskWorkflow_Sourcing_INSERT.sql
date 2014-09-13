INSERT INTO pTATaskWorkflow(WorkflowId, WorkflowName, WorkflowFolder, WorkflowSchemaGrid, WorkflowSchemaSearchGrid, Active)
VALUES ('10000000-0000-0000-0000-000000000001', 'Quote', 'SOURCING QUOTATION', 'TACalendarTemplateTask_Quote_Reference.xml', 'TACalendarTemplateTask_Quote_Reference_Search.xml', 1)
GO

INSERT INTO pTATaskWorkflow(WorkflowId, WorkflowName, WorkflowFolder, WorkflowSchemaGrid, WorkflowSchemaSearchGrid, Active)
VALUES ('10000000-0000-0000-0000-000000000001', 'Commitment', 'SOURCING COMMITMENT', 'TACalendarTemplateTask_Commitment_Reference.xml', 'TACalendarTemplateTask_Commitment_Reference_Search.xml', 1)
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08585', GetDate())
GO
