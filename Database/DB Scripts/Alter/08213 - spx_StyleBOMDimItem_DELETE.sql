IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMDimItem_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMDimItem_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_StyleBOMDimItem_DELETE]
	@StyleBOMDimensionID UNIQUEIDENTIFIER,	
	@DimID UNIQUEIDENTIFIER
AS
BEGIN

	DECLARE @DimLevel AS INT

	-- get level for @DimID
	SELECT @DimLevel = V.DimLevel
	FROM pStyleBOMDimensionItem sbdi
	CROSS APPLY (
		VALUES (sbdi.ItemDim1Id, 1), 
			   (sbdi.ItemDim2Id, 2), 
			   (sbdi.ItemDim3Id, 3)
	) V(ItemDimID, DimLevel)
	WHERE StyleBOMDimensionID = @StyleBOMDimensionID
		AND ItemDimID = @DimID

	if @DimLevel = 1
	begin
		DELETE FROM pStyleBOMDimensionItem WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim1Id = @DimID
		DELETE FROM pStyleBOMDimensionItems WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim1Id = @DimID
		DELETE FROM pStyleBOMItem WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim1Id = @DimID
	end
	else if @DimLevel = 2
	begin
		DELETE FROM pStyleBOMDimensionItem WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim2Id = @DimID
		DELETE FROM pStyleBOMDimensionItems WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim2Id = @DimID
		DELETE FROM pStyleBOMItem WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim2Id = @DimID
	end
	else if @DimLevel = 3
	begin
		DELETE FROM pStyleBOMDimensionItem WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim3Id = @DimID
		DELETE FROM pStyleBOMDimensionItems WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim3Id = @DimID
		DELETE FROM pStyleBOMItem WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim3Id = @DimID
	end
	
	-- if color is deleted from DimBOM it should be deleted from SeasonalColorway page
	IF EXISTS (SELECT * FROM pStyleColorway WHERE StyleColorID = @DimID)
	BEGIN
		DECLARE @StyleID UNIQUEIDENTIFIER 
		DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER 
		
		SELECT @StyleID = pStyleBOMDimension.StyleID, @StyleSeasonYearID = pWorkFlowItem.StyleSeasonYearID 
		FROM pStyleBOMDimension 
			INNER JOIN pWorkFlowItem ON pStyleBOMDimension.WorkFlowItemID = pWorkFlowItem.WorkFlowItemID
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID
		
		-- if the same color doesn't exist on other dimBOM pages with the same season year
		IF (SELECT COUNT(*) FROM pStyleBOMDimensionItem
				INNER JOIN pWorkFlowItem ON pStyleBOMDimensionItem.WorkFlowItemID = pWorkFlowItem.WorkFlowItemID
			WHERE pStyleBOMDimensionItem.StyleID = @StyleID 
			AND pWorkFlowItem.StyleSeasonYearID = @StyleSeasonYearID
			AND (ItemDim1Id = @DimID OR ItemDim2Id = @DimID OR ItemDim3Id = @DimID)
			) = 0
		BEGIN
			DELETE pStyleColorwaySeasonYear 
			FROM pStyleColorwaySeasonYear INNER JOIN pStyleColorway ON pStyleColorway.StyleColorID = pStyleColorwaySeasonYear.StyleColorwayID
			WHERE pStyleColorwaySeasonYear.StyleID = @StyleID AND StyleSeasonYearID = @StyleSeasonYearID
			AND StyleColorID = @DimID
		END
	END
	
	EXEC spx_StyleSKU_BOM_Logic_UPDATE @StyleBOMDimensionId
	
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08213', GetDate())
GO
