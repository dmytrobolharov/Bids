IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pPlanningConfig' AND COLUMN_NAME = 'SubCategoryID')
BEGIN
	ALTER TABLE pPlanningConfig ADD SubCategoryID UNIQUEIDENTIFIER
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pPlanningConfig' AND COLUMN_NAME = 'SeasonYearID')
BEGIN
	ALTER TABLE pPlanningConfig ADD SeasonYearID UNIQUEIDENTIFIER
END
GO

UPDATE pPlanningConfig SET SeasonYearID = (SELECT TOP 1 SeasonYearID FROM pPlanningSeasonYear psy WHERE pPlanningConfig.PlanningID = psy.PlanningID)
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06879', GetDate())
GO
