IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningItem_TACalendar_REMOVE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningItem_TACalendar_REMOVE]
GO

CREATE PROCEDURE [dbo].[spx_PlanningItem_TACalendar_REMOVE]
	@TACalTemplateID UNIQUEIDENTIFIER,
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS

DECLARE @Styles TABLE(
	ROWNO INT IDENTITY(1, 1),
	StyleID UNIQUEIDENTIFIER)
	
INSERT INTO @Styles(StyleID)
SELECT DISTINCT pli.StyleID FROM pPlanningItem pli
INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
INNER JOIN pTACalReference cr ON pli.StyleID = cr.ReferenceId
WHERE pli.PlanningID = @PlanningID AND ssy.SeasonYearID = @SeasonYearID
	AND cr.TACalTemplateId = @TACalTemplateID
	
DECLARE @ROW INT = 1,
		@Total INT = (SELECT COUNT(*) FROM @Styles)
		
WHILE @ROW <= @Total
BEGIN
	DECLARE @StyleID UNIQUEIDENTIFIER
	SELECT @StyleID = StyleID FROM @Styles WHERE ROWNO = @ROW
	
	EXEC spx_TACalReferenceFromStyle_DELETE
		@StyleID = @StyleID,
		@TACalTemplateID = @TACalTemplateID		

	SET @ROW = @ROW + 1
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08801', GetDate())
GO
