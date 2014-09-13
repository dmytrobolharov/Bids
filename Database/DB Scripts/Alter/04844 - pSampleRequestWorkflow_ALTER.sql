
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pSampleRequestWorkflow'
    AND  COLUMN_NAME = 'SampleWorkflowPartnerTypeID')
	
	ALTER TABLE dbo.pSampleRequestWorkflow ADD SampleWorkflowPartnerTypeID UNIQUEIDENTIFIER NULL 
GO 

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pSampleRequestWorkflowBOM'
    AND  COLUMN_NAME = 'SampleWorkflowPartnerTypeID')
	
	ALTER TABLE dbo.pSampleRequestWorkflowBOM ADD SampleWorkflowPartnerTypeID UNIQUEIDENTIFIER NULL 
GO 

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pSampleRequestWorkflowTemp'
    AND  COLUMN_NAME = 'SampleWorkflowPartnerTypeID')
	
	ALTER TABLE dbo.pSampleRequestWorkflowTemp ADD SampleWorkflowPartnerTypeID UNIQUEIDENTIFIER NULL 
GO 

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pSampleRequestWorkflowBOMTemp'
    AND  COLUMN_NAME = 'SampleWorkflowPartnerTypeID')
	
	ALTER TABLE dbo.pSampleRequestWorkflowBOMTemp ADD SampleWorkflowPartnerTypeID UNIQUEIDENTIFIER NULL 
GO 


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04844', GetDate())
GO
