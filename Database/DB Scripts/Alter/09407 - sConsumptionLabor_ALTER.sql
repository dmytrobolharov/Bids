ALTER TABLE sConsumptionLabor ALTER COLUMN SizeClass NVARCHAR(400);
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09407', GetDate())
GO
