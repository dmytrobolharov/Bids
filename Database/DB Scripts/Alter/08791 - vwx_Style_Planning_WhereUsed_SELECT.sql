IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Style_Planning_WhereUsed_SELECT]'))
DROP VIEW [dbo].[vwx_Style_Planning_WhereUsed_SELECT]
GO

CREATE VIEW [dbo].[vwx_Style_Planning_WhereUsed_SELECT]
AS
SELECT pli.StyleID, vpl.*
FROM vwx_Planning_SELECT vpl
	INNER JOIN pPlanningItem pli ON vpl.PlanningID = pli.PlanningID
	INNER JOIN pStyleSeasonYear ssy ON vpl.SeasonYearID = ssy.SeasonYearID
		AND pli.StyleID = ssy.StyleID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08791', GetDate())
GO

