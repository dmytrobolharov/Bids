IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pPlanningBusiness' AND COLUMN_NAME = 'Active')
BEGIN
	ALTER TABLE pPlanningBusiness ADD Active INT DEFAULT(1)
END
GO

UPDATE pPlanningBusiness SET Active = 1 WHERE Active IS NULL
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07091', GetDate())
GO
