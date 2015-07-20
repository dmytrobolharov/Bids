IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMDimensionItem_Active_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMDimensionItem_Active_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_StyleBOMDimensionItem_Active_UPDATE]
	@StyleBOMDimensionItemID UNIQUEIDENTIFIER,
	@Active INT
AS
BEGIN

	DECLARE @StyleBOMDimensionID UNIQUEIDENTIFIER,
			@ItemDimID UNIQUEIDENTIFIER
	SELECT @StyleBOMDimensionID = StyleBOMDimensionID
		, @ItemDimID = COALESCE(ItemDim1Id, ItemDim2Id, ItemDim3Id) 
	FROM pStyleBOMDimensionItem WHERE StyleBOMDimensionItemID = @StyleBOMDimensionItemID
	
	UPDATE pStyleBOMDimensionItem 
	SET ItemDim1Active = CASE WHEN ItemDim1Id IS NOT NULL THEN @Active ELSE ItemDim1Active END
	  , ItemDim2Active = CASE WHEN ItemDim2Id IS NOT NULL THEN @Active ELSE ItemDim2Active END
	  , ItemDim3Active = CASE WHEN ItemDim3Id IS NOT NULL THEN @Active ELSE ItemDim3Active END
	WHERE StyleBOMDimensionItemID = @StyleBOMDimensionItemID
	
	UPDATE pStyleBOMDimensionItems
	SET ItemDim1Active = CASE WHEN ItemDim1Id = @ItemDimID THEN @Active ELSE ItemDim1Active END
	  , ItemDim2Active = CASE WHEN ItemDim2Id = @ItemDimID THEN @Active ELSE ItemDim2Active END
	  , ItemDim3Active = CASE WHEN ItemDim3Id = @ItemDimID THEN @Active ELSE ItemDim3Active END
	WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND @ItemDimID IN (ItemDim1Id, ItemDim2Id, ItemDim3Id)
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07561', GetDate())
GO
