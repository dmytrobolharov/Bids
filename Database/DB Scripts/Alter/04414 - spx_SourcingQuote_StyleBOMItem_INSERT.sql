

/****** Object:  StoredProcedure [dbo].[spx_SourcingQuote_StyleBOMItem_INSERT]    Script Date: 11/22/2012 02:07:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingQuote_StyleBOMItem_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingQuote_StyleBOMItem_INSERT]
GO



/****** Object:  StoredProcedure [dbo].[spx_SourcingQuote_StyleBOMItem_INSERT]    Script Date: 11/22/2012 02:07:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- Stored Procedure

CREATE PROCEDURE [dbo].[spx_SourcingQuote_StyleBOMItem_INSERT]
(
@StyleQuoteItemID uniqueidentifier,
@StyleBOMDimensionId uniqueidentifier,
@SourcingHeaderID uniqueidentifier,
@SourcingStyleID uniqueidentifier,
@MUser nvarchar(200),
@MDate datetime
)
AS 

Declare @OldStyleBOMDimensionID uniqueidentifier
Declare @ItemDim1TypeId uniqueidentifier
Declare @ItemDim2TypeId uniqueidentifier
Declare @ItemDim3TypeId uniqueidentifier

select @ItemDim1TypeId = COALESCE(ItemDim1TypeId,'00000000-0000-0000-0000-000000000000') , @ItemDim2TypeId = COALESCE(ItemDim2TypeId,'00000000-0000-0000-0000-000000000000'), 
@ItemDim3TypeId=COALESCE(ItemDim3TypeId,'00000000-0000-0000-0000-000000000000')
from pStyleBOMDimension where StyleBOMDimensionId = @StyleBOMDimensionId
	
BEGIN
   
delete from pSourcingQuoteStyleBOM where StyleQuoteItemID=@StyleQuoteItemID		
delete from pSourcingQuotationBOMDetails where 	StyleQuoteItemID=@StyleQuoteItemID
   
if @ItemDim1TypeId<>'00000000-0000-0000-0000-000000000000' 	and @ItemDim2TypeId<>'00000000-0000-0000-0000-000000000000' 
and @ItemDim3TypeId<>'00000000-0000-0000-0000-000000000000' 
begin
	INSERT INTO [dbo].[pSourcingQuoteStyleBOM]
           ([SourcingQuoteStyleBOMId]
           ,[StyleBOMDimensionItemID]
           ,[StyleQuoteItemID]
           ,[SourcingHeaderID]
		    ,[SourcingStyleID]
           ,[StyleBOMDimensionID]
           ,[WorkFlowID]
           ,[WorkFlowItemID]
           ,[StyleID]
           ,[StyleSet]
           ,[ItemDim1TypeId]
           ,[ItemDim2TypeId]
           ,[ItemDim3TypeId]
           ,[ItemDim1Id]
           ,[ItemDim2Id]
           ,[ItemDim3Id]
           ,[ItemDim1Name]
           ,[ItemDim2Name]
           ,[ItemDim3Name]
           ,[ItemDim1Sort]
           ,[ItemDim2Sort]
           ,[ItemDim3Sort]
           ,[ItemDim1Active]
           ,[ItemDim2Active]
           ,[ItemDim3Active]
           ,[CDate]
           ,[CUser]
           ,[MDate]
           ,[MUser]
           ,[Amlmeashdrid]
           ,[Sizerangeid])
     select
     NEWID(),
     StyleBOMDimensionItemID,
     @StyleQuoteItemID,
     @SourcingHeaderID,
     @SourcingStyleID,
     @StyleBOMDimensionID,
     WorkFlowID,
     WorkFlowItemID,
     StyleID,
     StyleSet,
     ItemDim1TypeId,
     ItemDim2TypeId,
     ItemDim3TypeId,
     ItemDim1Id,
     ItemDim2Id,
     ItemDim3Id,
     ItemDim1Name,
     ItemDim2Name,
     ItemDim3Name,
     ItemDim1Sort,
     ItemDim2Sort,
     ItemDim3Sort,
     0,
     0,
     0,
     @MDate,
     @MUser,
     @MDate,
     @MUser,
     Amlmeashdrid,
     Sizerangeid from pStyleBOMDimensionItem where StyleBOMDimensionID=@StyleBOMDimensionID and ItemDim1Active=1 and 
     ItemDim1Id is not null
     
     INSERT INTO [dbo].[pSourcingQuoteStyleBOM]
           ([SourcingQuoteStyleBOMId]
           ,[StyleBOMDimensionItemID]
           ,[StyleQuoteItemID]
           ,[SourcingHeaderID]
		    ,[SourcingStyleID]
           ,[StyleBOMDimensionID]
           ,[WorkFlowID]
           ,[WorkFlowItemID]
           ,[StyleID]
           ,[StyleSet]
           ,[ItemDim1TypeId]
           ,[ItemDim2TypeId]
           ,[ItemDim3TypeId]
           ,[ItemDim1Id]
           ,[ItemDim2Id]
           ,[ItemDim3Id]
           ,[ItemDim1Name]
           ,[ItemDim2Name]
           ,[ItemDim3Name]
           ,[ItemDim1Sort]
           ,[ItemDim2Sort]
           ,[ItemDim3Sort]
           ,[ItemDim1Active]
           ,[ItemDim2Active]
           ,[ItemDim3Active]
           ,[CDate]
           ,[CUser]
           ,[MDate]
           ,[MUser]
           ,[Amlmeashdrid]
           ,[Sizerangeid])
     select
     NEWID(),
     StyleBOMDimensionItemID,
     @StyleQuoteItemID,
     @SourcingHeaderID,
     @SourcingStyleID,
     @StyleBOMDimensionID,
     WorkFlowID,
     WorkFlowItemID,
     StyleID,
     StyleSet,
     ItemDim1TypeId,
     ItemDim2TypeId,
     ItemDim3TypeId,
     ItemDim1Id,
     ItemDim2Id,
     ItemDim3Id,
     ItemDim1Name,
     ItemDim2Name,
     ItemDim3Name,
     ItemDim1Sort,
     ItemDim2Sort,
     ItemDim3Sort,
     0,
     0,
     0,
     @MDate,
     @MUser,
     @MDate,
     @MUser,
     Amlmeashdrid,
     Sizerangeid from pStyleBOMDimensionItem where StyleBOMDimensionID=@StyleBOMDimensionID and ItemDim2Active=1
     and ItemDim2Id is not null
     
     INSERT INTO [dbo].[pSourcingQuoteStyleBOM]
           ([SourcingQuoteStyleBOMId]
           ,[StyleBOMDimensionItemID]
           ,[StyleQuoteItemID]
           ,[SourcingHeaderID]
		    ,[SourcingStyleID]
           ,[StyleBOMDimensionID]
           ,[WorkFlowID]
           ,[WorkFlowItemID]
           ,[StyleID]
           ,[StyleSet]
           ,[ItemDim1TypeId]
           ,[ItemDim2TypeId]
           ,[ItemDim3TypeId]
           ,[ItemDim1Id]
           ,[ItemDim2Id]
           ,[ItemDim3Id]
           ,[ItemDim1Name]
           ,[ItemDim2Name]
           ,[ItemDim3Name]
           ,[ItemDim1Sort]
           ,[ItemDim2Sort]
           ,[ItemDim3Sort]
           ,[ItemDim1Active]
           ,[ItemDim2Active]
           ,[ItemDim3Active]
           ,[CDate]
           ,[CUser]
           ,[MDate]
           ,[MUser]
           ,[Amlmeashdrid]
           ,[Sizerangeid])
     select
     NEWID(),
     StyleBOMDimensionItemID,
     @StyleQuoteItemID,
     @SourcingHeaderID,
     @SourcingStyleID,
     @StyleBOMDimensionID,
     WorkFlowID,
     WorkFlowItemID,
     StyleID,
     StyleSet,
     ItemDim1TypeId,
     ItemDim2TypeId,
     ItemDim3TypeId,
     ItemDim1Id,
     ItemDim2Id,
     ItemDim3Id,
     ItemDim1Name,
     ItemDim2Name,
     ItemDim3Name,
     ItemDim1Sort,
     ItemDim2Sort,
     ItemDim3Sort,
     0,
     0,
     0,
     @MDate,
     @MUser,
     @MDate,
     @MUser,
     Amlmeashdrid,
     Sizerangeid from pStyleBOMDimensionItem where StyleBOMDimensionID=@StyleBOMDimensionID and ItemDim3Active=1
     and ItemDim3Id is not null
 end
 else if @ItemDim1TypeId<>'00000000-0000-0000-0000-000000000000' and @ItemDim2TypeId<>'00000000-0000-0000-0000-000000000000' 
	begin
		INSERT INTO [dbo].[pSourcingQuoteStyleBOM]
           ([SourcingQuoteStyleBOMId]
           ,[StyleBOMDimensionItemID]
           ,[StyleQuoteItemID]
           ,[SourcingHeaderID]
		    ,[SourcingStyleID]
           ,[StyleBOMDimensionID]
           ,[WorkFlowID]
           ,[WorkFlowItemID]
           ,[StyleID]
           ,[StyleSet]
           ,[ItemDim1TypeId]
           ,[ItemDim2TypeId]
           ,[ItemDim3TypeId]
           ,[ItemDim1Id]
           ,[ItemDim2Id]
           ,[ItemDim3Id]
           ,[ItemDim1Name]
           ,[ItemDim2Name]
           ,[ItemDim3Name]
           ,[ItemDim1Sort]
           ,[ItemDim2Sort]
           ,[ItemDim3Sort]
           ,[ItemDim1Active]
           ,[ItemDim2Active]
           ,[ItemDim3Active]
           ,[CDate]
           ,[CUser]
           ,[MDate]
           ,[MUser]
           ,[Amlmeashdrid]
           ,[Sizerangeid])
     select
     NEWID(),
     StyleBOMDimensionItemID,
     @StyleQuoteItemID,
     @SourcingHeaderID,
     @SourcingStyleID,
     @StyleBOMDimensionID,
     WorkFlowID,
     WorkFlowItemID,
     StyleID,
     StyleSet,
     ItemDim1TypeId,
     ItemDim2TypeId,
     ItemDim3TypeId,
     ItemDim1Id,
     ItemDim2Id,
     ItemDim3Id,
     ItemDim1Name,
     ItemDim2Name,
     ItemDim3Name,
     ItemDim1Sort,
     ItemDim2Sort,
     ItemDim3Sort,
     0,
     0,
     0,
     @MDate,
     @MUser,
     @MDate,
     @MUser,
     Amlmeashdrid,
     Sizerangeid from pStyleBOMDimensionItem where StyleBOMDimensionID=@StyleBOMDimensionID and ItemDim1Active=1
     and ItemDim1Id is not null
     
     INSERT INTO [dbo].[pSourcingQuoteStyleBOM]
           ([SourcingQuoteStyleBOMId]
           ,[StyleBOMDimensionItemID]
           ,[StyleQuoteItemID]
           ,[SourcingHeaderID]
		    ,[SourcingStyleID]
           ,[StyleBOMDimensionID]
           ,[WorkFlowID]
           ,[WorkFlowItemID]
           ,[StyleID]
           ,[StyleSet]
           ,[ItemDim1TypeId]
           ,[ItemDim2TypeId]
           ,[ItemDim3TypeId]
           ,[ItemDim1Id]
           ,[ItemDim2Id]
           ,[ItemDim3Id]
           ,[ItemDim1Name]
           ,[ItemDim2Name]
           ,[ItemDim3Name]
           ,[ItemDim1Sort]
           ,[ItemDim2Sort]
           ,[ItemDim3Sort]
           ,[ItemDim1Active]
           ,[ItemDim2Active]
           ,[ItemDim3Active]
           ,[CDate]
           ,[CUser]
           ,[MDate]
           ,[MUser]
           ,[Amlmeashdrid]
           ,[Sizerangeid])
     select
     NEWID(),
     StyleBOMDimensionItemID,
     @StyleQuoteItemID,
     @SourcingHeaderID,
     @SourcingStyleID,
     @StyleBOMDimensionID,
     WorkFlowID,
     WorkFlowItemID,
     StyleID,
     StyleSet,
     ItemDim1TypeId,
     ItemDim2TypeId,
     ItemDim3TypeId,
     ItemDim1Id,
     ItemDim2Id,
     ItemDim3Id,
     ItemDim1Name,
     ItemDim2Name,
     ItemDim3Name,
     ItemDim1Sort,
     ItemDim2Sort,
     ItemDim3Sort,
     0,
     0,
     0,
     @MDate,
     @MUser,
     @MDate,
     @MUser,
     Amlmeashdrid,
     Sizerangeid from pStyleBOMDimensionItem where StyleBOMDimensionID=@StyleBOMDimensionID and ItemDim2Active=1
     and ItemDim2Id is not null
	end 
 else if @ItemDim1TypeId<>'00000000-0000-0000-0000-000000000000' 
	begin
		INSERT INTO [dbo].[pSourcingQuoteStyleBOM]
           ([SourcingQuoteStyleBOMId]
           ,[StyleBOMDimensionItemID]
           ,[StyleQuoteItemID]
           ,[SourcingHeaderID]
		    ,[SourcingStyleID]
           ,[StyleBOMDimensionID]
           ,[WorkFlowID]
           ,[WorkFlowItemID]
           ,[StyleID]
           ,[StyleSet]
           ,[ItemDim1TypeId]
           ,[ItemDim2TypeId]
           ,[ItemDim3TypeId]
           ,[ItemDim1Id]
           ,[ItemDim2Id]
           ,[ItemDim3Id]
           ,[ItemDim1Name]
           ,[ItemDim2Name]
           ,[ItemDim3Name]
           ,[ItemDim1Sort]
           ,[ItemDim2Sort]
           ,[ItemDim3Sort]
           ,[ItemDim1Active]
           ,[ItemDim2Active]
           ,[ItemDim3Active]
           ,[CDate]
           ,[CUser]
           ,[MDate]
           ,[MUser]
           ,[Amlmeashdrid]
           ,[Sizerangeid])
     select
     NEWID(),
     StyleBOMDimensionItemID,
     @StyleQuoteItemID,
     @SourcingHeaderID,
     @SourcingStyleID,
     @StyleBOMDimensionID,
     WorkFlowID,
     WorkFlowItemID,
     StyleID,
     StyleSet,
     ItemDim1TypeId,
     ItemDim2TypeId,
     ItemDim3TypeId,
     ItemDim1Id,
     ItemDim2Id,
     ItemDim3Id,
     ItemDim1Name,
     ItemDim2Name,
     ItemDim3Name,
     ItemDim1Sort,
     ItemDim2Sort,
     ItemDim3Sort,
     0,
     0,
     0,
     @MDate,
     @MUser,
     @MDate,
     @MUser,
     Amlmeashdrid,
     Sizerangeid from pStyleBOMDimensionItem where StyleBOMDimensionID=@StyleBOMDimensionID and ItemDim1Active=1
     and ItemDim1Id is not null
     
	end 
	
	update pSourcingQuoteStyleBOM set ItemDim1Active=0, ItemDim2Active=0, ItemDim3Active=0
	where StyleQuoteItemID=@StyleQuoteItemID	
 
END



GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04414', GetDate())
GO
