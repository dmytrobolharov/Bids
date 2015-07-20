
/****** Object:  StoredProcedure [dbo].[spx_Sourcing_StyleBOMHdrDimItem_select]    Script Date: 11/12/2012 11:51:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sourcing_StyleBOMHdrDimItem_select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sourcing_StyleBOMHdrDimItem_select]
GO

/****** Object:  StoredProcedure [dbo].[spx_Sourcing_StyleBOMHdrDimItem_select]    Script Date: 11/12/2012 11:51:15 ******/
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
and StyleQuoteItemId=@StyleQuoteItemId
				
if @TotalCnt > 0
	begin		
		if @DimLevel=1
			begin
				SELECT a.StyleBOMDimensionItemID, a.ItemDim1Id as ItemTypeId, a.ItemDim1Name as Dim1Name, a.ItemDim1Active as Dim1Active
				FROM pSourcingQuoteStyleBOM a, pStyleBOMDimensionItem b  where a.StyleBOMDimensionId = @StyleBOMDimensionId and b.ItemDim1Active=1
				and a.StyleQuoteItemId=@StyleQuoteItemId and a.StyleBOMDimensionItemID = b.StyleBOMDimensionItemID
				and a.ItemDim1Id is not null order by a.ItemDim1Sort, Dim1Name
			end
		if @DimLevel=2
			begin
				SELECT a.StyleBOMDimensionItemID, a.ItemDim2Id as ItemTypeId, a.ItemDim2Name as Dim2Name, a.ItemDim2Active as Dim2Active
				FROM pSourcingQuoteStyleBOM a, pStyleBOMDimensionItem b  where a.StyleBOMDimensionId = @StyleBOMDimensionId and b.ItemDim2Active=1
				and a.StyleQuoteItemId=@StyleQuoteItemId and a.StyleBOMDimensionItemID = b.StyleBOMDimensionItemID
				and a.ItemDim2Id is not null order by a.ItemDim2Sort, Dim2Name
			end
		if @DimLevel=3
			begin
				SELECT a.StyleBOMDimensionItemID, a.ItemDim3Id as ItemTypeId, a.ItemDim3Name as Dim3Name, a.ItemDim3Active as Dim3Active
				FROM pSourcingQuoteStyleBOM a, pStyleBOMDimensionItem b  where a.StyleBOMDimensionId = @StyleBOMDimensionId and b.ItemDim3Active=1
				and a.StyleQuoteItemId=@StyleQuoteItemId and a.StyleBOMDimensionItemID = b.StyleBOMDimensionItemID
				and a.ItemDim3Id is not null order by a.ItemDim3Sort, Dim3Name
			end							
	end

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04325', GetDate())

GO

