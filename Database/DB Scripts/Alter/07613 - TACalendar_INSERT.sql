INSERT INTO pTATaskWorkflow([TATaskWorkflowId],[WorkflowId],[WorkflowName],[WorkflowFolder]) 
VALUES('5FB2961A-E9BA-E311-BECF-20C9D0B2B914','40000000-0000-0000-0000-000000000050', 'Measurements','STYLE')
  
INSERT INTO pTATaskWorkflow([TATaskWorkflowId],[WorkflowId],[WorkflowName],[WorkflowFolder]) 
VALUES('cb05e364-e9ba-e311-becf-20c9d0b2b914','40000000-0000-0000-0000-000000000080','Bill of Material','STYLE')
  
INSERT INTO pTATaskWorkflow(TATaskWorkflowId,WorkflowId,WorkflowName,WorkflowFolder) 
VALUES('0a467691-e9ba-e311-becf-20c9d0b2b914','40000000-0000-0000-0000-000000000010','Artwork','STYLE')
  
INSERT INTO pTATaskWorkflow([TATaskWorkflowId],[WorkflowId],[WorkflowName],[WorkflowFolder]) 
VALUES('2306aead-e9ba-e311-becf-20c9d0b2b914','40000000-0000-0000-0000-000000000006','Design Detail','STYLE')
  
INSERT INTO pTATaskWorkflow([TATaskWorkflowId],[WorkflowId],[WorkflowName],[WorkflowFolder]) 
VALUES('610538e1-e9ba-e311-becf-20c9d0b2b914','50000000-0000-0000-0000-000000000050','Tech Pack','STYLE')
  
INSERT INTO pTATaskWorkflow([TATaskWorkflowId],[WorkflowId],[WorkflowName],[WorkflowFolder]) 
VALUES('e43a5e0a-eaba-e311-becf-20c9d0b2b914','10000000-0000-0000-0000-000000000010','Costing','STYLE')
  
INSERT INTO pTATaskWorkflow([TATaskWorkflowId],[WorkflowId],[WorkflowName],[WorkflowFolder]) 
VALUES('0b5c2d95-eaba-e311-becf-20c9d0b2b914','40000000-0000-0000-0000-000000000050','Proto Sample','SAMPLE REQUEST')
  
INSERT INTO pTATaskWorkflow([TATaskWorkflowId],[WorkflowId],[WorkflowName],[WorkflowFolder]) 
VALUES('44f627c6-eaba-e311-becf-20c9d0b2b914','40000000-0000-0000-0000-000000000050','PP Sample','SAMPLE REQUEST')
  
INSERT INTO pTATaskWorkflow([TATaskWorkflowId],[WorkflowId],[WorkflowName],[WorkflowFolder]) 
VALUES('e60c96d4-eaba-e311-becf-20c9d0b2b914','40000000-0000-0000-0000-000000000050','TOP Sample','SAMPLE REQUEST')
  
INSERT INTO pTATaskWorkflow([TATaskWorkflowId],[WorkflowId],[WorkflowName],[WorkflowFolder]) 
VALUES('a7fb3632-ebba-e311-becf-20c9d0b2b914','e724458c-1c25-4904-807f-3d3b6443b120','Lab Dip','MATERIAL REQUEST')
  
INSERT INTO pTATaskWorkflow([TATaskWorkflowId],[WorkflowId],[WorkflowName],[WorkflowFolder]) 
VALUES('bb8ae773-ebba-e311-becf-20c9d0b2b914','8dd86229-5aa7-4d17-a837-fcb36fdf7292','Sample Yardage','MATERIAL REQUEST')

INSERT INTO [pTATaskType]([TATaskTypeId],[TATaskTypeName]) VALUES (0,'Event')
INSERT INTO [pTATaskType]([TATaskTypeId],[TATaskTypeName]) VALUES (1,'Action')

INSERT INTO [pTATaskDepType]([TATaskDepTypeId],[TATaskDepTypeName]) VALUES (0,'None')
INSERT INTO [pTATaskDepType]([TATaskDepTypeId],[TATaskDepTypeName]) VALUES (1,'Start')
INSERT INTO [pTATaskDepType]([TATaskDepTypeId],[TATaskDepTypeName]) VALUES (2,'End')

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07613', GetDate())
GO