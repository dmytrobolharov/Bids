

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'Users'
    AND  COLUMN_NAME = 'DashFolderItemID')
	
	ALTER TABLE dbo.users ADD DashFolderItemID UNIQUEIDENTIFIER NULL 
GO 

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04802', GetDate())
GO