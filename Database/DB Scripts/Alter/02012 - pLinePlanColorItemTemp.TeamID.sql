IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pLinePlanColorItemTemp'
    AND  COLUMN_NAME = 'TeamID')
	
	ALTER TABLE dbo.pLinePlanColorItemTemp ADD TeamID UNIQUEIDENTIFIER
GO 



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02012'))
BEGIN
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02012', GetDate())

END	  
GO

