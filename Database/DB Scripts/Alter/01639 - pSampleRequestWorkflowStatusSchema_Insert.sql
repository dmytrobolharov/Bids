
IF EXISTS(SELECT SampleWorkflow FROM psampleworkflow WHERE SampleWorkflow='QA Meas Worksheet')
   BEGIN
      update psampleworkflow set GroupName='-QA Worksheet' where SampleWorkflow='QA Meas Worksheet'
   END
ELSE
  BEGIN
	Insert into psampleworkflow values('95A', 'QA Meas Worksheet',    '40000000-0000-0000-0000-000000000050',    'A'   ,'-QA Worksheet',     '21', 'Yes',      NULL, NULL  ,NULL,      NULL      ,'015',     0, NEWID())
  END
GO

IF NOT EXISTS (SELECT * from pSampleRequestWorkflowStatusSchema WHERE SampleWorkflowID = '95A') 
	begin
		INSERT INTO pSampleRequestWorkflowStatusSchema (SampleWorkflowID, StatusID,
		  SummaryXML, EditXML, MaterialXML) values
		  ('95A', 0,'SampleRequestSubmitItem_Summary_Default.xml','SampleRequestSubmitItem_A_Edit.xml',
		  'SampleRequestSubmitItem_A_POM.xml')		  
		INSERT INTO pSampleRequestWorkflowStatusSchema (SampleWorkflowID, StatusID,
		  SummaryXML, EditXML, MaterialXML) values
		  ('95A', 1,'SampleRequestSubmitItem_Summary_Default.xml','SampleRequestSubmitItem_A_Edit.xml',
		  'SampleRequestSubmitItem_A_POM.xml')	 	   
		INSERT INTO pSampleRequestWorkflowStatusSchema (SampleWorkflowID, StatusID,
		  SummaryXML, EditXML, MaterialXML) values
		  ('95A', 2,'SampleRequestSubmitItem_Summary_Default.xml','SampleRequestSubmitItem_A_Edit.xml',
		  'SampleRequestSubmitItem_A_POM.xml')		  
		INSERT INTO pSampleRequestWorkflowStatusSchema (SampleWorkflowID, StatusID,
		  SummaryXML, EditXML, MaterialXML) values
		  ('95A', 3,'SampleRequestSubmitItem_Summary_Default.xml','SampleRequestSubmitItem_A_Edit.xml',
		  'SampleRequestSubmitItem_A_POM.xml')    
		INSERT INTO pSampleRequestWorkflowStatusSchema (SampleWorkflowID, StatusID,
		  SummaryXML, EditXML, MaterialXML) values
		  ('95A', 4,'SampleRequestSubmitItem_Summary_Default.xml','SampleRequestSubmitItem_A_Edit.xml',
		  'SampleRequestSubmitItem_A_POM.xml')     
      end
      
go

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES      ('DB_Version', '4.1.0000', '01639', GetDate())
GO

