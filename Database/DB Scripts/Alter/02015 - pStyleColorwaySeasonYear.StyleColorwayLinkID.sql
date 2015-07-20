
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pStyleColorwaySeasonYear'
    AND  COLUMN_NAME = 'StyleColorwayLinkID')
	
	ALTER TABLE dbo.pStyleColorwaySeasonYear ADD StyleColorwayLinkID UNIQUEIDENTIFIER
GO 



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02015'))
BEGIN
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02015', GetDate())

END	  
GO




