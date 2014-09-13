
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pStyleMaterialTemp'
    AND  COLUMN_NAME = 'BatchQJobID')
	
	ALTER TABLE dbo.pStyleMaterialTemp ADD BatchQJobID UNIQUEIDENTIFIER
GO 


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02017'))
BEGIN
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02017', GetDate())

END	  
GO




