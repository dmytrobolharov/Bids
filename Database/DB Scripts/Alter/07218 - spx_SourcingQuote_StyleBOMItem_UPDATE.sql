IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingQuote_StyleBOMItem_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingQuote_StyleBOMItem_UPDATE]
GO


-- Stored Procedure

CREATE PROCEDURE [dbo].[spx_SourcingQuote_StyleBOMItem_UPDATE]
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

UPDATE pSourcingQuoteStyleBOM 
SET ItemDim1TypeId = @ItemDim1TypeId, ItemDim2TypeId = @ItemDim2TypeId, ItemDim3TypeId = @ItemDim3TypeId 
WHERE StyleQuoteItemID = @StyleQuoteItemID AND StyleBOMDimensionID = @StyleBOMDimensionId 
	
BEGIN
   
--delete from pSourcingQuoteStyleBOM where StyleQuoteItemID=@StyleQuoteItemID		
--delete from pSourcingQuotationBOMDetails where 	StyleQuoteItemID=@StyleQuoteItemID
   
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
     ItemDim1Id is not null and ItemDim1Id not in (SELECT ItemDim1Id from pSourcingQuoteStyleBOM where StyleQuoteItemID=@StyleQuoteItemID and ItemDim1Id is not null)
     
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
     and ItemDim2Id is not null and ItemDim2Id not in (SELECT ItemDim2Id from pSourcingQuoteStyleBOM where StyleQuoteItemID=@StyleQuoteItemID and ItemDim2Id is not null)
     
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
     and ItemDim3Id is not null and ItemDim3Id not in (SELECT ItemDim3Id from pSourcingQuoteStyleBOM where StyleQuoteItemID=@StyleQuoteItemID and ItemDim3Id is not null)
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
     and ItemDim1Id is not null and ItemDim1Id not in (SELECT ItemDim1Id from pSourcingQuoteStyleBOM where StyleQuoteItemID=@StyleQuoteItemID and ItemDim1Id is not null)
     
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
     and ItemDim2Id is not null and ItemDim2Id not in (SELECT ItemDim2Id from pSourcingQuoteStyleBOM where StyleQuoteItemID=@StyleQuoteItemID and ItemDim2Id is not null)
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
     and ItemDim1Id is not null and ItemDim1Id not in (SELECT ItemDim1Id from pSourcingQuoteStyleBOM where StyleQuoteItemID=@StyleQuoteItemID and ItemDim1Id is not null)
     
	end 
	
	update pSourcingQuoteStyleBOM set NotShow=1
	where StyleQuoteItemID=@StyleQuoteItemID and ItemDim1Id is not null and ItemDim1Id not in (SELECT ItemDim1Id from pStyleBOMDimensionItem where StyleBOMDimensionID=@StyleBOMDimensionID and ItemDim1Id is not null )
	
	update pSourcingQuoteStyleBOM set NotShow=1
	where StyleQuoteItemID=@StyleQuoteItemID and ItemDim2Id is not null and ItemDim2Id not in (SELECT ItemDim2Id from pStyleBOMDimensionItem where StyleBOMDimensionID=@StyleBOMDimensionID and ItemDim2Id is not null )
	
	update pSourcingQuoteStyleBOM set NotShow=1
	where StyleQuoteItemID=@StyleQuoteItemID and ItemDim3Id is not null and ItemDim3Id not in (SELECT ItemDim3Id from pStyleBOMDimensionItem where StyleBOMDimensionID=@StyleBOMDimensionID and ItemDim3Id is not null )
	
		update pSourcingQuoteStyleBOM set NotShow=1
	where StyleQuoteItemID=@StyleQuoteItemID and ItemDim1Id is not null and ItemDim1Id in (SELECT ItemDim1Id from pStyleBOMDimensionItem where StyleBOMDimensionID=@StyleBOMDimensionID and ItemDim1Id is not null and ItemDim1Active=0)
	
	update pSourcingQuoteStyleBOM set NotShow=1
	where StyleQuoteItemID=@StyleQuoteItemID and ItemDim2Id is not null and ItemDim2Id in (SELECT ItemDim2Id from pStyleBOMDimensionItem where StyleBOMDimensionID=@StyleBOMDimensionID and ItemDim2Id is not null and ItemDim2Active=0)
	
	update pSourcingQuoteStyleBOM set NotShow=1
	where StyleQuoteItemID=@StyleQuoteItemID and ItemDim3Id is not null and ItemDim3Id in (SELECT ItemDim3Id from pStyleBOMDimensionItem where StyleBOMDimensionID=@StyleBOMDimensionID and ItemDim3Id is not null and ItemDim3Active=0)
	
	update pSourcingQuoteStyleBOM set NotShow=0
	where StyleQuoteItemID=@StyleQuoteItemID and ItemDim1Id is not null and ItemDim1Id  in (SELECT ItemDim1Id from pStyleBOMDimensionItem where StyleBOMDimensionID=@StyleBOMDimensionID and ItemDim1Id is not null and ItemDim1Active=1) 
	
	update pSourcingQuoteStyleBOM set NotShow=0
	where StyleQuoteItemID=@StyleQuoteItemID and ItemDim2Id is not null and ItemDim2Id  in (SELECT ItemDim2Id from pStyleBOMDimensionItem where StyleBOMDimensionID=@StyleBOMDimensionID and ItemDim2Id is not null and ItemDim2Active=1) 
	
	update pSourcingQuoteStyleBOM set NotShow=0
	where StyleQuoteItemID=@StyleQuoteItemID and ItemDim3Id is not null and ItemDim3Id in (SELECT ItemDim3Id from pStyleBOMDimensionItem where StyleBOMDimensionID=@StyleBOMDimensionID and ItemDim3Id is not null and ItemDim3Active=1) 
 
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07218', GetDate())
GO
