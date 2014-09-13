IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_LineFolder_Existing_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_LineFolder_Existing_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_LineFolder_Existing_INSERT]
	@PlanningID UNIQUEIDENTIFIER,
	@LineFolderID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS
BEGIN
	
	UPDATE pLineFolder SET PlanningID = @PlanningID WHERE LineFolderID = @LineFolderID
	
	-- Add styles from Line List to Planning
	DECLARE @LineFolderItems TABLE(
		ROWID INT IDENTITY(1, 1), 
		StyleID UNIQUEIDENTIFIER, 
		SeasonYearID UNIQUEIDENTIFIER)
		
	INSERT INTO @LineFolderItems(StyleID, SeasonYearID)
	SELECT DISTINCT lfi.StyleID, ssy.SeasonYearID FROM pLineFolderItem lfi
	INNER JOIN pStyleSeasonYear ssy ON lfi.StyleSeasonYearID = ssy.StyleSeasonYearID
	WHERE LineFolderID = @LineFolderID 
		AND NOT EXISTS(
			SELECT * FROM pPlanningItem ppi 
			WHERE lfi.StyleID = ppi.StyleID 
				AND lfi.StyleSeasonYearID = ppi.StyleSeasonYearID 
				AND PlanningID = @PlanningID)
	
	DECLARE @ROW INT = 1,
			@TOTAL INT = (SELECT COUNT(*) FROM @LineFolderItems)
			
	WHILE @ROW <= @TOTAL
	BEGIN
		DECLARE @StyleID UNIQUEIDENTIFIER,
				@SeasonYearID UNIQUEIDENTIFIER,
				@PlanningItemID UNIQUEIDENTIFIER = NEWID()
				
		SELECT @StyleID = StyleID, @SeasonYearID = SeasonYearID FROM @LineFolderItems WHERE ROWID = @ROW
				
		exec spx_PlanningItem_INSERT
			@PlanningItemID = @PlanningItemID,
			@PlanningID = @PlanningID,
			@StyleID = @StyleID,
			@SeasonYearID = @SeasonYearID,
			@CreatedDate = @CDate,
			@CreatedBy = @CUser
	
		SET @ROW = @ROW + 1
	END	
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06389', GetDate())
GO
