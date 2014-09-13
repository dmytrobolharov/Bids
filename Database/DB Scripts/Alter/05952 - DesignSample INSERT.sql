insert into pSampleWorkflow(SampleWorkflowID, SampleWorkflow, WorkflowID, GroupID, GroupName,  Active, SampleWorkflowSort, AllowUpdateGradeRules,SampleWorkflowRepId)
values('96A', 'Design Sample', '40000000-0000-0000-0000-000000000051', 'D', 'Design Sample', 'Yes', '021',0,NEWID())



INSERT INTO pSampleRequestWorkflowStatusSchema(SampleWorkflowID, StatusID, SummaryXML, EditXML, MaterialXML, SampleRequestWorkFlowStatusSchemaId)
values('96A', 0, 'SampleRequestSubmitItem_Summary_Default.xml', 'SampleRequestSubmitItem_E_Edit.xml','SampleRequestSubmitItem_E_POM.xml', NEWID())

INSERT INTO pSampleRequestWorkflowStatusSchema(SampleWorkflowID, StatusID, SummaryXML, EditXML, MaterialXML, SampleRequestWorkFlowStatusSchemaId)
values('96A', 1, 'SampleRequestSubmitItem_Summary_Default.xml', 'SampleRequestSubmitItem_E_Edit.xml','SampleRequestSubmitItem_E_POM.xml', NEWID())

INSERT INTO pSampleRequestWorkflowStatusSchema(SampleWorkflowID, StatusID, SummaryXML, EditXML, MaterialXML, SampleRequestWorkFlowStatusSchemaId)
values('96A', 2, 'SampleRequestSubmitItem_Summary_Default.xml', 'SampleRequestSubmitItem_E_Edit.xml','SampleRequestSubmitItem_E_POM.xml', NEWID())

INSERT INTO pSampleRequestWorkflowStatusSchema(SampleWorkflowID, StatusID, SummaryXML, EditXML, MaterialXML, SampleRequestWorkFlowStatusSchemaId)
values('96A', 3, 'SampleRequestSubmitItem_Summary_Default.xml', 'SampleRequestSubmitItem_E_Edit.xml','SampleRequestSubmitItem_E_POM.xml', NEWID())

INSERT INTO pSampleRequestWorkflowStatusSchema(SampleWorkflowID, StatusID, SummaryXML, EditXML, MaterialXML, SampleRequestWorkFlowStatusSchemaId)
values('96A', 4, 'SampleRequestSubmitItem_Summary_Default.xml', 'SampleRequestSubmitItem_E_Edit.xml','SampleRequestSubmitItem_E_POM.xml', NEWID())

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05952', GetDate())
GO