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
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05989', GetDate())
GO
