IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_TACalendar_REMOVE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_TACalendar_REMOVE]
GO

CREATE PROCEDURE [dbo].[spx_Planning_TACalendar_REMOVE]
	@PlanningTACalendarID UNIQUEIDENTIFIER
AS

DECLARE @TACalTemplateID UNIQUEIDENTIFIER = (
	SELECT TACalTemplateID FROM pPlanningTACalendar 
	WHERE PlanningTACalendarID = @PlanningTACalendarID)
	
DECLARE @Styles TABLE(
	ROWNO INT IDENTITY(1, 1),
	StyleID UNIQUEIDENTIFIER)
	
INSERT INTO @Styles(StyleID)
SELECT pli.StyleID
FROM pPlanningItem pli
INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
INNER JOIN pTACalReference cr ON pli.StyleID = cr.ReferenceId
INNER JOIN pPlanningTACalendar pcal ON cr.TACalTemplateId = pcal.TACalTemplateID
	AND pli.PlanningID = pcal.PlanningID AND ssy.SeasonYearID = pcal.SeasonYearID
WHERE pcal.PlanningTACalendarID = @PlanningTACalendarID

DECLARE @ROW INT = 1,
		@TOTAL INT = (SELECT COUNT(*) FROM @Styles)
		
WHILE @ROW <= @TOTAL
BEGIN
	DECLARE @StyleID UNIQUEIDENTIFIER = (
		SELECT StyleID FROM @Styles WHERE ROWNO = @ROW)
		
	EXEC spx_TACalReferenceFromStyle_DELETE
		@StyleID = @StyleID,
		@TACalTemplateID = @TACalTemplateID	

	SET @ROW = @ROW + 1
END


DELETE FROM pPlanningTACalendar WHERE PlanningTACalendarID = @PlanningTACalendarID


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08773', GetDate())
GO
