IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMDimensionListSelect_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleBOMDimensionListSelect_UPDATE]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleBOMDimensionListSelect_UPDATE]    Script Date: 09/06/2011 12:23:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[spx_StyleBOMDimensionListSelect_UPDATE]
(
	@StyleBOMDimension1ItemId nvarchar(50)
	,@StyleBOMDimension2ItemId nvarchar(50)
	,@StyleBOMDimension3ItemId nvarchar(50)
	,@StyleID nvarchar(50)
	,@StyleSet int		
	,@StyleBOMDimensionId nvarchar(50)	
)

AS

Declare @ItemDim1TypeId nvarchar(50)
Declare @ItemDim2TypeId nvarchar(50)
Declare @ItemDim3TypeId nvarchar(50)
Declare @StyleBOMDimensionItemID nvarchar(50)


Select ItemDim1TypeId=@ItemDim1TypeId ,ItemDim2TypeId=@ItemDim2TypeId, ItemDim3TypeId=@ItemDim3TypeId
from pStyleBOMDimension where StyleBOMDimensionId=@StyleBOMDimensionId

Update pStyleBOMDimensionItems set ItemDimActive=0 where StyleBOMDimensionId=@StyleBOMDimensionId

If @StyleBOMDimension3ItemId <> '' 
	begin
		select  @StyleBOMDimensionItemID = StyleBOMDimensionItemID  from pStyleBOMDimensionItems where ItemDim3Id=@StyleBOMDimension3ItemId
		and ItemDim1Id=@StyleBOMDimension1ItemId
		and ItemDim2Id=@StyleBOMDimension2ItemId and StyleBOMDimensionId=@StyleBOMDimensionId
	end
else if @StyleBOMDimension2ItemId <> '' 	
	begin
		select  @StyleBOMDimensionItemID = StyleBOMDimensionItemID  from pStyleBOMDimensionItems where 	ItemDim1Id=@StyleBOMDimension1ItemId
		and ItemDim2Id=@StyleBOMDimension2ItemId and StyleBOMDimensionId=@StyleBOMDimensionId
	end
else if @StyleBOMDimension1ItemId <> ''
	begin
		select  @StyleBOMDimensionItemID = StyleBOMDimensionItemID  from pStyleBOMDimensionItems where 	ItemDim1Id=@StyleBOMDimension1ItemId
		and StyleBOMDimensionId=@StyleBOMDimensionId
	end

Update pStyleBOMDimensionItems set ItemDimActive=1 where 
		StyleBOMDimensionItemID = @StyleBOMDimensionItemID 
		and StyleBOMDimensionId = @StyleBOMDimensionId
		
		
--If @StyleBOMDimension3ItemId <> '' 
--	begin
--		Update pStyleBOMDimensionItems set ItemDimActive=1 where 
--		ItemDim1Id=@StyleBOMDimension1ItemId
--		and ItemDim2Id=@StyleBOMDimension2ItemId and ItemDim3Id=@StyleBOMDimension3ItemId	
--		and StyleBOMDimensionId=@StyleBOMDimensionId
--	end
--else
--	begin
--		If @StyleBOMDimension2ItemId <> '' 	
--			begin
--				Update pStyleBOMDimensionItems set ItemDimActive=1 where 
--				ItemDim1Id=@StyleBOMDimension1ItemId
--				and ItemDim2Id=@StyleBOMDimension2ItemId 	
--				and StyleBOMDimensionId=@StyleBOMDimensionId
--			end
--		else
--			begin
--				Update pStyleBOMDimensionItems set ItemDimActive=1 where 
--				ItemDim1Id=@StyleBOMDimension1ItemId					
--				and StyleBOMDimensionId=@StyleBOMDimensionId
--			end
--	end
	
	
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01878'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01878', GetDate())
END

GO
