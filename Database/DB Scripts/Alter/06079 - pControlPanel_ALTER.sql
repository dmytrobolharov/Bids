IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pControlPanel' AND COLUMN_NAME = 'Sort')
BEGIN
	ALTER TABLE pControlPanel ADD Sort INT
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06079', GetDate())
GO
