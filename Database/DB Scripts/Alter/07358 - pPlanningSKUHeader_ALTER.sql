IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pPlanningSKUHeader' AND COLUMN_NAME = 'Sort')
BEGIN
	ALTER TABLE pPlanningSKUHeader ADD Sort NVARCHAR(4)	
END
GO

UPDATE pPlanningSKUHeader SET Sort = '001' WHERE Sort IS NULL
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07358', GetDate())
GO
