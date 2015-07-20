IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pPlanningColor' AND COLUMN_NAME = 'SeasonYearID')
BEGIN
	ALTER TABLE pPlanningColor ADD SeasonYearID UNIQUEIDENTIFIER
END
GO

UPDATE pPlanningColor 
SET SeasonYearID = p.IntroSeasonYearID
FROM pPlanning p
WHERE pPlanningColor.PlanningID = p.PlanningID AND pPlanningColor.SeasonYearID IS NULL
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06564', GetDate())
GO
