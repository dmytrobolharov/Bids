IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_LineFolder_Existing_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_LineFolder_Existing_INSERT]
GO
/****** Object:  StoredProcedure [dbo].[spx_Planning_LineFolder_Existing_INSERT]    Script Date: 08/26/2014 12:16:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
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
		SeasonYearID UNIQUEIDENTIFIER,
		StyleBOMDimensionID UNIQUEIDENTIFIER,
		PlanningItemDrop nvarchar(5))
		
	INSERT INTO @LineFolderItems(StyleID, SeasonYearID, StyleBOMDimensionID, PlanningItemDrop)
	SELECT DISTINCT lfi.StyleID, ssy.SeasonYearID, lfi.StyleBOMDimensionID, lfi.LineFolderItemDrop FROM pLineFolderItem lfi
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
				@StyleBOMDimensionID UNIQUEIDENTIFIER,
				@PlanningItemID UNIQUEIDENTIFIER = NEWID(),
				@PlanningItemDrop nvarchar(5)
				
		SELECT @StyleID = StyleID, @SeasonYearID = SeasonYearID, @StyleBOMDimensionID = StyleBOMDimensionID, @PlanningItemDrop = PlanningItemDrop FROM @LineFolderItems WHERE ROWID = @ROW
				
		exec spx_PlanningItem_INSERT
			@PlanningItemID = @PlanningItemID,
			@PlanningID = @PlanningID,
			@StyleID = @StyleID,
			@SeasonYearID = @SeasonYearID,
			@CreatedDate = @CDate,
			@CreatedBy = @CUser,
			@StyleBOMDimensionID = @StyleBOMDimensionID,
			@PlanningItemDrop = @PlanningItemDrop
		SET @ROW = @ROW + 1
	END	
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08999', GetDate())
GO