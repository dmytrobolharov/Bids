IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMDimItem_REPLACE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMDimItem_REPLACE]
GO

CREATE PROCEDURE [dbo].[spx_StyleBOMDimItem_REPLACE]
	@StyleBOMDimensionID UNIQUEIDENTIFIER,
	@DimLevel INT,
	@DimID UNIQUEIDENTIFIER,
	@NewDimID UNIQUEIDENTIFIER,
	@NewDimName NVARCHAR(200) = NULL
AS
BEGIN

	if @NewDimName IS NULL
	begin
		declare @DimTypeName NVARCHAR(20) = (SELECT V.ItemDimTypeName FROM pStyleBOMDimension
											 CROSS APPLY (VALUES(ItemDim1TypeName, 1),
																(ItemDim2TypeName, 2),
																(ItemDim3TypeName, 3))
															   V(ItemDimTypeName, DimLevel)
											 WHERE StyleBOMDimensionID = @StyleBOMDimensionID 
												AND V.DimLevel = @DimLevel)
		
		if @DimTypeName = 'Color'
		begin
			SELECT @NewDimName = ColorName FROM pColorPalette WHERE ColorPaletteID = @NewDimID
		end
		
		print @NewDimName	
	end
	
	if @DimLevel = 1
	begin
		UPDATE pStyleBOMDimensionItem SET ItemDim1Id = @NewDimID, ItemDim1Name = @NewDimName
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim1Id = @DimID
		
		UPDATE pStyleBOMDimensionItems SET ItemDim1Id = @NewDimID, ItemDim1Name = @NewDimName
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim1Id = @DimID
		
		UPDATE pStyleBOMItem SET ItemDim1Id = @NewDimID, ItemDim1Name = @NewDimName
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim1Id = @DimID
	end
	else if @DimLevel = 2
	begin
		UPDATE pStyleBOMDimensionItem SET ItemDim2Id = @NewDimID, ItemDim2Name = @NewDimName
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim2Id = @DimID
		
		UPDATE pStyleBOMDimensionItems SET ItemDim2Id = @NewDimID, ItemDim2Name = @NewDimName
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim2Id = @DimID
		
		UPDATE pStyleBOMItem SET ItemDim2Id = @NewDimID, ItemDim2Name = @NewDimName
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim2Id = @DimID
	end
	else if @DimLevel = 3
	begin
		UPDATE pStyleBOMDimensionItem SET ItemDim3Id = @NewDimID, ItemDim3Name = @NewDimName
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim3Id = @DimID
		
		UPDATE pStyleBOMDimensionItems SET ItemDim3Id = @NewDimID, ItemDim3Name = @NewDimName
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim3Id = @DimID
		
		UPDATE pStyleBOMItem SET ItemDim3Id = @NewDimID, ItemDim3Name = @NewDimName
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim3Id = @DimID
	end
	
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06110', GetDate())
GO
