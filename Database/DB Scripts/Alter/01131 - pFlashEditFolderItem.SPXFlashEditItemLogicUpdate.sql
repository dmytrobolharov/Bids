
IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pFlashEditFolderItem' 
    AND  COLUMN_NAME = 'SPXFlashEditItemLogicUpdate')
	ALTER TABLE pFlashEditFolderItem ADD SPXFlashEditItemLogicUpdate NVARCHAR(200)
	

	
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01131', GetDate())
GO





	