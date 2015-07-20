delete from pTACalReferenceTask
delete from pTACalReference
delete from pTACalTemplateTaskDep
delete from pTACalTemplateTask
delete from pTACalTemplate
delete from pTATaskWorkflow

GO

INSERT INTO pTATaskWorkflow(WorkflowId,WorkflowName,WorkflowFolder,WorkflowSchemaGrid)
select WorkflowID, Workflow,'STYLE', 'TACalendarTemplateTask_Style_Reference.xml' from pWorkflow where Active=1 and Body=0 and WorkflowTypeID <> '0'

INSERT INTO pTATaskWorkflow(WorkflowId,WorkflowName,WorkflowFolder,WorkflowSchemaGrid)
select NEWID(), 'Tech Pack','STYLE TECHPACK', 'TACalendarTemplateTask_Style_Reference.xml' 

INSERT INTO pTATaskWorkflow(WorkflowId,WorkflowName,WorkflowFolder,WorkflowSchemaGrid)
select SampleWorkflowGUID, SampleWorkflow, 'SAMPLE REQUEST', 'TACalendarTemplateTask_SampleRequest_Reference.xml' from pSampleWorkflow where lower(Active)='yes'

INSERT INTO pTATaskWorkflow(WorkflowId,WorkflowName,WorkflowFolder,WorkflowSchemaGrid)
select MaterialTemplatePageID, MaterialTemplatePageName,'MATERIAL', 'TACalendarTemplateTask_Material_Reference.xml' FROM pMaterialTemplatePage where Active=1

INSERT INTO pTATaskWorkflow(WorkflowId,WorkflowName,WorkflowFolder,WorkflowSchemaGrid)
select ImageWorkflowTemplateItemID, ImageWorkflowTemplateItemName,'IMAGE', 'TACalendarTemplateTask_Image_Reference.xml' FROM pImageWorkflowTemplateItem where Active=1

INSERT INTO pTATaskWorkflow(WorkflowId,WorkflowName,WorkflowFolder,WorkflowSchemaGrid)
select NEWID(), 'Color','COLOR', 'TACalendarTemplateTask_Color_Reference.xml'

INSERT INTO pTATaskWorkflow(WorkflowId,WorkflowName,WorkflowFolder,WorkflowSchemaGrid)
select MaterialRequestWorkflowGUIDID, MaterialRequestWorkflow, 'MATERIAL REQUEST', 'TACalendarTemplateTask_MaterialRequest_Reference.xml' from pMaterialRequestWorkflow where Active=1

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08064', GetDate())
GO