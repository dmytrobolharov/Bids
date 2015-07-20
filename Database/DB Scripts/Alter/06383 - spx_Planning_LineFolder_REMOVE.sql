IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_LineFolder_REMOVE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_LineFolder_REMOVE]
GO

CREATE procedure [dbo].[spx_Planning_LineFolder_REMOVE]
	@PlanningID UNIQUEIDENTIFIER,
	@LineFolderID UNIQUEIDENTIFIER,
	@RemoveStyles INT,
	@CUser NVARCHAR(200),
	@CDate DATETIME
as

	UPDATE pLineFolder SET PlanningID = NULL WHERE LineFolderID = @LineFolderID
	
	if @RemoveStyles = 1
	begin		
		-- remove styles from planning
		DECLARE @PlanningItems TABLE(
			ROWID INT IDENTITY(1, 1), 
			PlanningItemID UNIQUEIDENTIFIER)
			
		INSERT INTO @PlanningItems(PlanningItemID)
		SELECT PlanningItemID FROM pLineFolderItem lfi
		INNER JOIN pPlanningItem ppi ON lfi.StyleID = ppi.StyleID 
			AND lfi.StyleSeasonYearID = ppi.StyleSeasonYearID			
		WHERE LineFolderID = @LineFolderID AND PlanningID = @PlanningID
		
		DECLARE @ROW INT = 1,
				@TOTAL INT = (SELECT COUNT(*) FROM @PlanningItems)
				
		WHILE @ROW <= @TOTAL
		BEGIN
			DECLARE @PlanningItemID UNIQUEIDENTIFIER
					
			SELECT @PlanningItemID = PlanningItemID FROM @PlanningItems WHERE ROWID = @ROW
					
			exec spx_PlanningItem_Drop
				@PlanningItemID = @PlanningItemID,
				@PlanningItemDrop = 1,
				@PlanningItemDropUser = @CUser,
				@PlanningItemDropDate = @CDate
		
			SET @ROW = @ROW + 1
		END	
	end

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06383', GetDate())
GO
