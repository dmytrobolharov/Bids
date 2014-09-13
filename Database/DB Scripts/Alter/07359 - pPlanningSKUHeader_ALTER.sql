IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pPlanningSKUHeader' AND COLUMN_NAME = 'WorkStatus')
BEGIN
	ALTER TABLE pPlanningSKUHeader ADD WorkStatus INT	
END
GO

UPDATE pPlanningSKUHeader SET WorkStatus = 6 WHERE WorkStatus IS NULL
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07359', GetDate())
GO
