UPDATE pTATaskWorkflow 
SET WorkflowSchemaGrid = 'TACalendarTemplateTask_TechPack_Reference.xml', 
WorkflowSchemaSearchGrid='TACalendarTemplateTask_TechPack_Reference_Search.xml'
WHERE WorkflowFolder='STYLE TECHPACK'

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08557', GetDate())
GO
