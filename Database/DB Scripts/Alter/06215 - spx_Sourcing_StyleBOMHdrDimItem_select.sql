/****** Object:  StoredProcedure [dbo].[spx_Sourcing_StyleBOMHdrDimItem_select]    Script Date: 08/22/2013 17:22:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sourcing_StyleBOMHdrDimItem_select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sourcing_StyleBOMHdrDimItem_select]
GO
/****** Object:  StoredProcedure [dbo].[spx_Sourcing_StyleBOMHdrDimItem_select]    Script Date: 08/22/2013 17:22:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[spx_Sourcing_StyleBOMHdrDimItem_select](
@StyleQuoteItemId uniqueidentifier,
@StyleBOMDimensionId uniqueidentifier,
@DimLevel Int
)
AS 

Declare @TotalCnt int

SELECT @TotalCnt = Count(StyleBOMDimensionItemID) FROM pSourcingQuoteStyleBOM  where StyleBOMDimensionId = @StyleBOMDimensionId
and StyleQuoteItemId=@StyleQuoteItemId and NotShow <> 1
				
if @TotalCnt > 0
	begin		
		if @DimLevel=1
			begin
				SELECT StyleBOMDimensionItemID,  ItemDim1Name as Dim1Name, ItemDim1Active as Dim1Active
				FROM pSourcingQuoteStyleBOM  where StyleBOMDimensionId = @StyleBOMDimensionId 
				and StyleQuoteItemId=@StyleQuoteItemId
				and NotShow <> 1
				and ItemDim1Id is not null order by ItemDim1Sort, Dim1Name
				
			end
		if @DimLevel=2
			begin
				SELECT StyleBOMDimensionItemID, ItemDim2Name as Dim2Name, ItemDim2Active as Dim2Active
				FROM pSourcingQuoteStyleBOM  where StyleBOMDimensionId = @StyleBOMDimensionId 
				and StyleQuoteItemId=@StyleQuoteItemId
				and NotShow <> 1
				and ItemDim2Id is not null order by ItemDim2Sort, Dim2Name
				
			end
		if @DimLevel=3
			begin
				SELECT StyleBOMDimensionItemID, ItemDim3Name as Dim3Name, ItemDim3Active as Dim3Active
				FROM pSourcingQuoteStyleBOM  where StyleBOMDimensionId = @StyleBOMDimensionId 
				and StyleQuoteItemId=@StyleQuoteItemId
				and NotShow <> 1
				and ItemDim3Id is not null order by ItemDim3Sort, Dim3Name
				
				
			end							
	end



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06215', GetDate())
GO