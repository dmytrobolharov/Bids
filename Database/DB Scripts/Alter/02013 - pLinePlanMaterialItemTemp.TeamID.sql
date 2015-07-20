
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pLinePlanMaterialItemTemp'
    AND  COLUMN_NAME = 'TeamID')
	
	ALTER TABLE dbo.pLinePlanMaterialItemTemp ADD TeamID UNIQUEIDENTIFIER
GO 



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02013'))
BEGIN
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02013', GetDate())

END	  
GO


