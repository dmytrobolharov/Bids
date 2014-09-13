
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pStyleMaterials'
    AND  COLUMN_NAME = 'BatchQJobID')
	
	ALTER TABLE dbo.pStyleMaterials ADD BatchQJobID UNIQUEIDENTIFIER
GO 


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02016'))
BEGIN
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02016', GetDate())

END	  
GO