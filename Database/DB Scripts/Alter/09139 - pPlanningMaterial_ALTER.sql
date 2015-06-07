IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pPlanningMaterial' AND COLUMN_NAME = 'Sort')
	ALTER TABLE pPlanningMaterial ADD Sort INT
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '6.1.0000', '09139', GetDate())
GO