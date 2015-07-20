

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'rDashFolderItem'
    AND  COLUMN_NAME = 'DashFolderItemLandPage')
	
	ALTER TABLE dbo.rDashFolderItem ADD DashFolderItemLandPage INT NULL DEFAULT ((0))
GO 


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02018'))
BEGIN
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02018', GetDate())

END	  
GO




