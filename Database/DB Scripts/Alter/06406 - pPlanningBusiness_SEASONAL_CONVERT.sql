WITH PSY AS (
	SELECT *, ROW_NUMBER() OVER(PARTITION BY PlanningId ORDER BY CDate) as Num FROM pPlanningSeasonYear
)
UPDATE pPlanningBusiness SET SeasonYearID = PSY.SeasonYearID
FROM pPlanningBusiness pb
LEFT JOIN PSY ON pb.PlanningID = PSY.PlanningID AND PSY.Num = 1
WHERE pb.SeasonYearID IS NULL

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06406', GetDate())
GO