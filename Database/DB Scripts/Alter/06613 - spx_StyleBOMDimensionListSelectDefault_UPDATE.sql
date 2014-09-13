IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMDimensionListSelectDefault_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMDimensionListSelectDefault_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_StyleBOMDimensionListSelectDefault_UPDATE]
(
	@StyleBOMDimensionId nvarchar(50)
)

AS

IF EXISTS (SELECT * FROM pStyleBOMDimensionItems WHERE StyleBOMDimensionId=@StyleBOMDimensionId AND ItemDimActive = 1)
BEGIN
	RETURN
END

Declare @StyleBOMDimension1ItemId nvarchar(50)
Declare @StyleBOMDimension2ItemId nvarchar(50)
Declare @StyleBOMDimension3ItemId nvarchar(50)
Declare @StyleBOMDimensionItemID nvarchar(50)

SELECT TOP 1 @StyleBOMDimension1ItemId = ItemDim1Id FROM pStyleBOMDimensionItems 
WHERE StyleBOMDimensionID = @StyleBOMDimensionId AND ItemDim1Active = 1
ORDER BY ItemDim1Sort, ItemDim1Name

SELECT TOP 1 @StyleBOMDimension2ItemId = ItemDim2Id FROM pStyleBOMDimensionItems 
WHERE StyleBOMDimensionID = @StyleBOMDimensionId AND ItemDim2Active = 1
ORDER BY ItemDim2Sort, ItemDim2Name

SELECT TOP 1 @StyleBOMDimension3ItemId = ItemDim3Id FROM pStyleBOMDimensionItems 
WHERE StyleBOMDimensionID = @StyleBOMDimensionId AND ItemDim3Active = 1
ORDER BY ItemDim3Sort, ItemDim3Name

IF @StyleBOMDimension1ItemId IS NOT NULL  -- is we have items in table pStyleBOMDimensionItems
BEGIN

	Update pStyleBOMDimensionItems set ItemDimActive=0 where StyleBOMDimensionId=@StyleBOMDimensionId

	If @StyleBOMDimension3ItemId IS NOT NULL
		begin
			select  @StyleBOMDimensionItemID = StyleBOMDimensionItemID  from pStyleBOMDimensionItems where ItemDim3Id=@StyleBOMDimension3ItemId
			and ItemDim1Id=@StyleBOMDimension1ItemId
			and ItemDim2Id=@StyleBOMDimension2ItemId and StyleBOMDimensionId=@StyleBOMDimensionId
		end
	else if @StyleBOMDimension2ItemId IS NOT NULL
		begin
			select  @StyleBOMDimensionItemID = StyleBOMDimensionItemID  from pStyleBOMDimensionItems where 	ItemDim1Id=@StyleBOMDimension1ItemId
			and ItemDim2Id=@StyleBOMDimension2ItemId and StyleBOMDimensionId=@StyleBOMDimensionId
		end
	else if @StyleBOMDimension1ItemId IS NOT NULL
		begin
			select  @StyleBOMDimensionItemID = StyleBOMDimensionItemID  from pStyleBOMDimensionItems where 	ItemDim1Id=@StyleBOMDimension1ItemId
			and StyleBOMDimensionId=@StyleBOMDimensionId
		end

	Update pStyleBOMDimensionItems set ItemDimActive=1 where 
			StyleBOMDimensionItemID = @StyleBOMDimensionItemID 
			and StyleBOMDimensionId = @StyleBOMDimensionId
			
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06613', GetDate())
GO
