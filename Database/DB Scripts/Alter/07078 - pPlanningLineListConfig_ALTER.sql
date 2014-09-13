IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pPlanningLineListConfig' AND COLUMN_NAME = 'SeasonYearID')
BEGIN
	ALTER TABLE pPlanningLineListConfig ADD SeasonYearID UNIQUEIDENTIFIER
END
GO

UPDATE pPlanningLineListConfig
SET SeasonYearID = (SELECT IntroSeasonYearID FROM pPlanning WHERE PlanningID = pPlanningLineListConfig.PlanningID)
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07078', GetDate())
GO
