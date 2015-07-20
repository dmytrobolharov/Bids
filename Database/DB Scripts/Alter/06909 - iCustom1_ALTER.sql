IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'iCustom1' AND COLUMN_NAME = 'CustomKey')
BEGIN
	ALTER TABLE iCustom1 ALTER COLUMN CustomKey NVARCHAR(10)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '06909', GetDate())
GO
