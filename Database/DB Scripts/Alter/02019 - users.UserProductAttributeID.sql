
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'users'
    AND  COLUMN_NAME = 'UserProductAttributeID')
	
	ALTER TABLE dbo.users ADD UserProductAttributeID UNIQUEIDENTIFIER NULL 
GO 


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02019'))
BEGIN
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02019', GetDate())

END	  
GO





