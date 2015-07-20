IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningCalendar_NotCoveredDivisions_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningCalendar_NotCoveredDivisions_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_PlanningCalendar_NotCoveredDivisions_SELECT]
(
	@PlanningID UNIQUEIDENTIFIER
	, @SeasonYearID UNIQUEIDENTIFIER
)
AS

BEGIN
	SELECT DISTINCT d.CustomID AS DivisionID, d.Custom AS DivisionName
	FROM pPlanningItem pli
		INNER JOIN pStyleHeader sh ON pli.StyleID = sh.StyleID
		INNER JOIN pStyleSeasonYear ssy ON pli.StyleID = ssy.StyleID
			AND pli.StyleSeasonYearID = ssy.StyleSeasonYearID
		INNER JOIN iCustom1 d ON sh.DivisionID = d.CustomID
		LEFT JOIN pTACalTemplateDivision tactd 
			INNER JOIN pPlanningTACalendar ptac ON tactd.TACalTemplateID = ptac.TACalTemplateID
			ON pli.PlanningID = ptac.PlanningID
				AND ssy.SeasonYearID = ptac.SeasonYearID
				AND sh.DivisionID = tactd.DivisionID
	WHERE
		tactd.DivisionID IS NULL
		AND pli.PlanningID = @PlanningID
		AND ssy.SeasonYearID = @SeasonYearID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08782', GetDate())
GO
