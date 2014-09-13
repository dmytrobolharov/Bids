
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pSampleWorkflowItemTemplate'
    AND  COLUMN_NAME = 'SampleWorkflowPartnerTypeID')
	
	ALTER TABLE dbo.pSampleWorkflowItemTemplate ADD SampleWorkflowPartnerTypeID UNIQUEIDENTIFIER NULL 
GO 


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04840', GetDate())
GO
