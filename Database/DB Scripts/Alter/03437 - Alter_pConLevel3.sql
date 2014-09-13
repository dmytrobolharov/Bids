IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pConLevel3' and COLUMN_NAME = N'Detail' and DATA_TYPE = N'text')
	BEGIN 
		ALTER TABLE pConLevel3 ALTER COLUMN Detail nvarchar(MAX)
	END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03437', GetDate())
GO
