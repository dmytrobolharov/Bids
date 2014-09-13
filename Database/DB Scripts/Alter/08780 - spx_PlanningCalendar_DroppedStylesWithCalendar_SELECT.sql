IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningCalendar_DroppedStylesWithCalendar_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningCalendar_DroppedStylesWithCalendar_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_PlanningCalendar_DroppedStylesWithCalendar_SELECT]
(
	@PlanningTACalendarID UNIQUEIDENTIFIER
)
AS

BEGIN
	SELECT pli.PlanningItemID
	FROM pPlanningTACalendar ptac
		INNER JOIN pPlanningItem pli ON ptac.PlanningID = pli.PlanningID
		INNER JOIN pStyleSeasonYear ssy ON pli.StyleID = ssy.StyleID
			AND pli.StyleSeasonYearID = ssy.StyleSeasonYearID
			AND ptac.SeasonYearID = ssy.SeasonYearID
		INNER JOIN pTACalReference tacr ON ptac.TACalTemplateID = tacr.TACalTemplateId
			AND pli.StyleID = tacr.ReferenceId
		INNER JOIN pTACalTemplate tact ON ptac.TACalTemplateID = tact.TACalTemplateId
			AND ssy.SeasonYearID = tact.SeasonYearId
	WHERE
		ptac.PlanningTACalendarID = @PlanningTACalendarID
		AND pli.PlanningItemDrop = 'Yes'
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08780', GetDate())
GO
