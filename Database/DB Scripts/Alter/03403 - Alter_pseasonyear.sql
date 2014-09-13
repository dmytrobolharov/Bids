IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pseasonyear' and COLUMN_NAME = N'Season' and DATA_TYPE = N'varchar')
	BEGIN 
		ALTER TABLE pseasonyear ALTER COLUMN Season nvarchar(100)
		ALTER TABLE pseasonyear ALTER COLUMN Year nvarchar(200)
	END
	
GO

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03403', GetDate())
GO