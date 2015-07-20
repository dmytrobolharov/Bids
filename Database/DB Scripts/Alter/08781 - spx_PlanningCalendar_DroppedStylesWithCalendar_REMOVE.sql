IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningCalendar_DroppedStylesWithCalendar_REMOVE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningCalendar_DroppedStylesWithCalendar_REMOVE]
GO

CREATE PROCEDURE [dbo].[spx_PlanningCalendar_DroppedStylesWithCalendar_REMOVE]
	@PlanningTACalendarID UNIQUEIDENTIFIER
AS

DECLARE @tmpDropped TABLE(
	ROWNO INT IDENTITY(1, 1),
	PlanningItemID UNIQUEIDENTIFIER)

INSERT INTO @tmpDropped(PlanningItemID)
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

DECLARE @ROW INT = 1,
		@Total INT = (SELECT COUNT(*) FROM @tmpDropped)
		
WHILE @ROW <= @Total
BEGIN
	DECLARE @PlanningItemID UNIQUEIDENTIFIER
	SELECT @PlanningItemID = PlanningItemID FROM @tmpDropped WHERE ROWNO = @ROW
	
	EXEC spx_PlanningItem_Calendar_REMOVE 
		@PlanningItemID = @PlanningItemID,
		@PlanningTACalendarID = @PlanningTACalendarID

	SET @ROW = @ROW + 1
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08781', GetDate())
GO
