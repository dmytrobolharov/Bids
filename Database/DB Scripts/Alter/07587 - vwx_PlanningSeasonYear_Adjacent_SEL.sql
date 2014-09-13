IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_PlanningSeasonYear_Adjacent_SEL]'))
DROP VIEW [dbo].[vwx_PlanningSeasonYear_Adjacent_SEL]
GO

CREATE VIEW [dbo].[vwx_PlanningSeasonYear_Adjacent_SEL]
AS

SELECT psy1.SeasonYearID
	, psy1.PlanningSeasonYearID
	, ISNULL(psy1.PlanningSeason, '') + ' ' + ISNULL(psy1.PlanningYear, '') AS SeasonYear
	, psy2.SeasonYearID AS SrcSeasonYear
	, psy2.PlanningSeasonYearID AS SrcPlanningSeasonYearID
FROM dbo.pPlanningSeasonYear AS psy1
INNER JOIN dbo.pPlanningSeasonYear AS psy2 ON psy1.PlanningID = psy2.PlanningID
	AND psy1.PlanningSeasonYearID <> psy2.PlanningSeasonYearID


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07587', GetDate())
GO
