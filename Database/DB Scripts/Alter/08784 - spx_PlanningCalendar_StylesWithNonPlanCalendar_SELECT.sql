IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningCalendar_StylesWithNonPlanCalendar_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningCalendar_StylesWithNonPlanCalendar_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_PlanningCalendar_StylesWithNonPlanCalendar_SELECT]
(
	@PlanningID UNIQUEIDENTIFIER
	, @SeasonYearID UNIQUEIDENTIFIER
)
AS

BEGIN
	SELECT DISTINCT pli.PlanningID
	FROM pPlanningItem pli
		INNER JOIN pPlanningSeasonYear psy ON pli.PlanningID = psy.PlanningID
		INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
			AND psy.SeasonYearID = ssy.SeasonYearID
		INNER JOIN pTACalReference tacr ON pli.StyleID = tacr.ReferenceId
		INNER JOIN pTACalTemplate tact ON tacr.TACalTemplateId = tact.TACalTemplateId
			AND ssy.SeasonYearID = tact.SeasonYearId
		LEFT JOIN pPlanningTACalendar ptac ON pli.PlanningID = ptac.PlanningID
			AND ssy.SeasonYearID = ptac.SeasonYearID
			AND tact.TACalTemplateId = ptac.TACalTemplateID
	WHERE
		ptac.TACalTemplateID IS NULL
		AND pli.PlanningID = @PlanningID
		AND ssy.SeasonYearID = @SeasonYearID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08784', GetDate())
GO
