IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pPlanningBusiness' AND COLUMN_NAME = 'SeasonYearID')
BEGIN
	ALTER TABLE pPlanningBusiness ADD SeasonYearID UNIQUEIDENTIFIER
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06405', GetDate())
GO