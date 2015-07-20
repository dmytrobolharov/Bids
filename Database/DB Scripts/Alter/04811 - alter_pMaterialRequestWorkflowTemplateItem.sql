

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pMaterialRequestWorkflowTemplateItem'
    AND  COLUMN_NAME = 'MaterialRequestPartnerTypeID')
	
	ALTER TABLE dbo.pMaterialRequestWorkflowTemplateItem ADD MaterialRequestPartnerTypeID UNIQUEIDENTIFIER NULL 
GO 

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04811', GetDate())
GO