IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOM_SeasonalColor_EXECUTE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOM_SeasonalColor_EXECUTE]
GO

CREATE PROCEDURE [dbo].[spx_StyleBOM_SeasonalColor_EXECUTE]
	@StyleBOMDimensionID UNIQUEIDENTIFIER
AS
BEGIN

	DECLARE @StyleID UNIQUEIDENTIFIER,
			@StyleSet INT,
			@WorkflowItemID UNIQUEIDENTIFIER
	SELECT @StyleID = StyleID, @StyleSet = StyleSet, @WorkFlowItemID = WorkFlowItemID 
	FROM pStyleBOMDimension WHERE StyleBOMDimensionID = @StyleBOMDimensionID
	
	/*** if bom has no color dimension but has unused slots in it ***/
	if EXISTS(SELECT * FROM pStyleBOMDimension 
			  WHERE StyleBOMDimensionID = @StyleBOMDimensionID 
				AND 'Color' NOT IN (ItemDim1TypeName, ItemDim2TypeName, ItemDim3TypeName)
				AND '00000000-0000-0000-0000-000000000000' IN (ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId))
	begin -- insert color dimension
		DECLARE @UnusedDimLevel INT,
				@ColorDimID UNIQUEIDENTIFIER = (SELECT DimTypeID FROM pStyleBOMDimType WHERE DimTypeName = 'Color')
		
		SELECT TOP 1 @UnusedDimLevel = DimLevel FROM pStyleBOMDimension
		CROSS APPLY (VALUES (ItemDim1TypeId, 1),
							(ItemDim2TypeId, 2),
							(ItemDim3TypeId, 3))
						   V(ItemDimTypeID,  DimLevel)
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID
			AND V.ItemDimTypeID = '00000000-0000-0000-0000-000000000000'
		ORDER BY V.DimLevel
		
		if @UnusedDimLevel = 1
			UPDATE pStyleBOMDimension SET ItemDim1TypeId = @ColorDimID, ItemDim1TypeName = 'Color' 
			WHERE StyleBOMDimensionID = @StyleBOMDimensionID
		else if @UnusedDimLevel = 2
			UPDATE pStyleBOMDimension SET ItemDim2TypeId = @ColorDimID, ItemDim2TypeName = 'Color' 
			WHERE StyleBOMDimensionID = @StyleBOMDimensionID
		else if @UnusedDimLevel = 3
			UPDATE pStyleBOMDimension SET ItemDim3TypeId = @ColorDimID, ItemDim3TypeName = 'Color' 
			WHERE StyleBOMDimensionID = @StyleBOMDimensionID
	end
	
	/*** check if color dimension exists, then copy seasonal colors ***/
	if EXISTS(SELECT * FROM pStyleBOMDimension 
			  WHERE StyleBOMDimensionID = @StyleBOMDimensionID 
				AND 'Color' IN (ItemDim1TypeName, ItemDim2TypeName, ItemDim3TypeName))
	begin -- copy colors from seasonal colorway
		declare @ColorDimTypeID UNIQUEIDENTIFIER,
				@ColorDimLevel INT
				
		SELECT @ColorDimTypeID = V.ItemDimTypeID, @ColorDimLevel = DimLevel 
		FROM pStyleBOMDimension
		CROSS APPLY (VALUES (ItemDim1TypeId, ItemDim1TypeName, 1),
							(ItemDim2TypeId, ItemDim2TypeName, 2),
							(ItemDim3TypeId, ItemDim3TypeName, 3))
						   V(ItemDimTypeID,  ItemDimTypeName,  DimLevel)
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND V.ItemDimTypeName = 'Color'
	
		declare @Colorway TABLE(ROW INT IDENTITY(1, 1), ColorPaletteID UNIQUEIDENTIFIER)
		INSERT INTO @Colorway(ColorPaletteID)
		SELECT ColorPaletteID FROM pStyleColorway WHERE StyleID = @StyleID
		
		declare @ROW INT = 1,
				@TOTAL INT = (SELECT COUNT(*) FROM @Colorway)
				
		while @ROW <= @TOTAL
		begin
			declare @ColorPaletteID UNIQUEIDENTIFIER = (SELECT ColorPaletteID FROM @Colorway WHERE ROW = @ROW)
		
			exec spx_StyleBOMColorways_Insert
				@ItemDimTypeId = @ColorDimTypeID,
				@StyleBOMDimensionId = @StyleBOMDimensionId,
				@ColorPaletteID = @ColorPaletteID,
				@StyleID = @StyleID, 
				@StyleSet = @StyleSet,
				@WorkflowID = '40000000-0000-0000-0000-000000000080', 
				@WorkflowItemID = @WorkflowItemID,
				@DimLevel = @ColorDimLevel
		
			set @ROW = @ROW + 1
		end
	end			 
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06104', GetDate())
GO
