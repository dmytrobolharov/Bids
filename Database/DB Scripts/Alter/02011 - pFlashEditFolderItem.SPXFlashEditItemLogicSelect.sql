IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pFlashEditFolderItem'
    AND  COLUMN_NAME = 'SPXFlashEditItemLogicSelect')
	
	ALTER TABLE dbo.pFlashEditFolderItem ADD [SPXFlashEditItemLogicSelect] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
GO 



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02011'))
BEGIN
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02011', GetDate())

END	  
GO

