

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pFlashEditFolderItem'
    AND  COLUMN_NAME = 'SPXFlashEditItemLogicSelect')
	ALTER TABLE pFlashEditFolderItem ADD SPXFlashEditItemLogicSelect NVARCHAR(200)
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '01529', GetDate())
GO
	
	
	
	
	