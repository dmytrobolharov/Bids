
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pStyleColorway'
    AND  COLUMN_NAME = 'StyleColorwayLinkID')
	
	ALTER TABLE dbo.pStyleColorway ADD StyleColorwayLinkID UNIQUEIDENTIFIER
GO 



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02014'))
BEGIN
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02014', GetDate())

END	  
GO



