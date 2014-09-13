IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningItem_Drop]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningItem_Drop]
GO

CREATE PROCEDURE [dbo].[spx_PlanningItem_Drop] 
	@PlanningItemID UNIQUEIDENTIFIER,
	@PlanningItemDrop NVARCHAR(10),
	@PlanningItemDropUser NVARCHAR(200),
	@PlanningItemDropDate DATETIME,
	@SyncLineFolderItems INT = 1
AS
BEGIN

	UPDATE pPlanningItem SET
		PlanningItemDrop = @PlanningItemDrop,
		PlanningItemDropUser = @PlanningItemDropUser,
		PlanningItemDropDate = @PlanningItemDropDate
	WHERE PlanningItemID = @PlanningItemID
	
	IF @PlanningItemDrop = 'Yes' -- remove calendar
	BEGIN
		DECLARE @Calendars TABLE(
			ROWNO INT IDENTITY(1, 1),
			PlanningTACalendarID UNIQUEIDENTIFIER)
			
		INSERT INTO @Calendars(PlanningTACalendarID)
		SELECT pcal.PlanningTACalendarID FROM pPlanningItem pli
		INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
		INNER JOIN pTACalReference cr ON pli.StyleID = cr.ReferenceId
		INNER JOIN pPlanningTACalendar pcal ON cr.TACalTemplateId = pcal.TACalTemplateID
			AND pli.PlanningID = pcal.PlanningID AND ssy.SeasonYearID = pcal.SeasonYearID
		WHERE pli.PlanningItemID = @PlanningItemID
		
		DECLARE @ROW INT = 1,
				@TOTAL INT = (SELECT COUNT(*) FROM @Calendars)
				
		WHILE @ROW <= @TOTAL
		BEGIN
			DECLARE @PlanningTACalendarID UNIQUEIDENTIFIER = (
				SELECT PlanningTACalendarID FROM @Calendars WHERE ROWNO = @ROW)
				
			EXEC spx_PlanningItem_Calendar_REMOVE
				@PlanningItemID = @PlanningItemID,
				@PlanningTACalendarID = @PlanningTACalendarID	

			SET @ROW = @ROW + 1
		END
	END
	
	/* WI#24021 */
	IF @SyncLineFolderItems = 1
	BEGIN
		DECLARE @StyleID UNIQUEIDENTIFIER
		DECLARE @PlanningID UNIQUEIDENTIFIER
		SELECT @StyleID = StyleID, @PlanningID = PlanningID FROM pPlanningItem WHERE PlanningItemID = @PlanningItemID

		UPDATE pLineFolderItem SET
			LineFolderItemDrop = @PlanningItemDrop, 
			LineFolderItemDropUser = @PlanningItemDropUser,
			LineFolderItemDropDate = @PlanningItemDropDate
		WHERE StyleID = @StyleID
			AND LineFolderID IN (SELECT LineFolderID FROM pLineFolder WHERE PlanningID = @PlanningID)
	END


END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08787', GetDate())
GO
