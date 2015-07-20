IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pYear' and COLUMN_NAME = N'CustomKey' and DATA_TYPE = N'varchar')
	BEGIN 
		ALTER TABLE pYear ALTER COLUMN CustomKey nvarchar(100)
		ALTER TABLE pYear ALTER COLUMN Custom nvarchar(200)
	END
	
GO

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03402', GetDate())
GO
