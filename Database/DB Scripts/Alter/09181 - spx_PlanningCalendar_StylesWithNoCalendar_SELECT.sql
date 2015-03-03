IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningCalendar_StylesWithNoCalendar_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningCalendar_StylesWithNoCalendar_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_PlanningCalendar_StylesWithNoCalendar_SELECT]
(
	@PlanningTACalendarID UNIQUEIDENTIFIER
)
AS

BEGIN
	SELECT pli.StyleID
	FROM pPlanningTACalendar ptac
		INNER JOIN pPlanningItem pli ON ptac.PlanningID = pli.PlanningID
		INNER JOIN pStyleHeader sh ON pli.StyleID = sh.StyleID
		INNER JOIN pStyleSeasonYear ssy ON pli.StyleID = ssy.StyleID
			AND pli.StyleSeasonYearID = ssy.StyleSeasonYearID
			AND ptac.SeasonYearID = ssy.SeasonYearID
		INNER JOIN pTACalTemplate tact ON ptac.TACalTemplateID = tact.TACalTemplateId
			AND ssy.SeasonYearID = tact.SeasonYearId
		INNER JOIN pTACalTemplateDivision tactd ON ptac.TACalTemplateId = tactd.TACalTemplateID
			AND sh.DivisionID = tactd.DivisionID
		LEFT JOIN pTACalReference tacr ON ptac.TACalTemplateID = tacr.TACalTemplateId
			AND pli.StyleID = tacr.ReferenceId
	WHERE
		tacr.ReferenceId IS NULL
		AND ptac.PlanningTACalendarID = @PlanningTACalendarID
		AND pli.PlanningItemDrop != 'Yes'
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0001', '09181', GetDate())
GO