IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'sSystemServerStorageSetting' and COLUMN_NAME = N'LineListPath')
BEGIN 
	ALTER TABLE sSystemServerStorageSetting
	ADD LineListPath nVARCHAR(200) NULL
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '07089', GetDate())
GO

