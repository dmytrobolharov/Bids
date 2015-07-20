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
		EXEC spx_StyleBOMDimItem_DELETE
				@StyleBOMDimensionID = @StyleBOMDimensionID,	
				@DimID = @ColorPaletteID
	END

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06718', GetDate())
GO
