IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMColorway_SeasonColor_PlanningFlash_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMColorway_SeasonColor_PlanningFlash_DELETE]
GO


CREATE PROCEDURE [dbo].[spx_StyleBOMColorway_SeasonColor_PlanningFlash_DELETE] 
	@PlanningItemID UNIQUEIDENTIFIER,
	@StyleBOMDimensionID UNIQUEIDENTIFIER,	
	@ColorPaletteID UNIQUEIDENTIFIER
AS
BEGIN

	IF @StyleBOMDimensionID IS NULL
	BEGIN
		SELECT @StyleBOMDimensionId = StyleBOMDimensionID FROM pPlanningItem WHERE PlanningItemID = @PlanningItemID
	END

	IF @StyleBOMDimensionID IS NOT NULL AND @StyleBOMDimensionID <> '00000000-0000-0000-0000-000000000000'
	BEGIN

		DECLARE @StyleColorID UNIQUEIDENTIFIER
		DECLARE @StyleID UNIQUEIDENTIFIER
		SELECT @StyleID = StyleID FROM pStyleBOMDimension WHERE StyleBOMDimensionID = @StyleBOMDimensionID
		SELECT @StyleColorID = StyleColorID FROM pStyleColorway WHERE StyleID = @StyleID AND ColorPaletteID = @ColorPaletteID
		
		DECLARE @Flag TABLE (Flag INT)
		INSERT INTO @Flag (Flag)
		EXEC spx_StyleBOMDimItem_IsUsed
				@StyleBOMDimensionID = @StyleBOMDimensionID,	
				@DimID = @StyleColorID
				
		IF (SELECT TOP 1 Flag FROM @Flag) = 0
		BEGIN
			EXEC spx_StyleBOMDimItem_DELETE
					@StyleBOMDimensionID = @StyleBOMDimensionID,	
					@DimID = @StyleColorID
		END

	END

END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07325', GetDate())
GO
