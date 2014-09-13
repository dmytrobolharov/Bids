IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingCommitment_StyleBOMItem_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingCommitment_StyleBOMItem_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_SourcingCommitment_StyleBOMItem_UPDATE]
(
@StyleCommitmentItemID uniqueidentifier,
@StyleBOMDimensionId uniqueidentifier,
@SourcingHeaderID uniqueidentifier,
@SourcingStyleID uniqueidentifier,
@StyleSKUItemID uniqueidentifier = NULL,
@MUser nvarchar(200),
@MDate datetime
)
AS 

Declare @OldStyleBOMDimensionID uniqueidentifier
Declare @ItemDim1TypeId uniqueidentifier
Declare @ItemDim2TypeId uniqueidentifier
Declare @ItemDim3TypeId uniqueidentifier
Declare @StyleQuoteItemID uniqueidentifier

select @StyleQuoteItemID = StyleQuoteItemID from pSourcingCommitmentItem where SourcingCommitmentItemID=@StyleCommitmentItemID

select @ItemDim1TypeId = COALESCE(ItemDim1TypeId,'00000000-0000-0000-0000-000000000000') , @ItemDim2TypeId = COALESCE(ItemDim2TypeId,'00000000-0000-0000-0000-000000000000'), 
@ItemDim3TypeId=COALESCE(ItemDim3TypeId,'00000000-0000-0000-0000-000000000000')
from pStyleBOMDimension where StyleBOMDimensionId = @StyleBOMDimensionId
	
BEGIN

IF @StyleSKUItemID IS NOT NULL
BEGIN
	DELETE FROM pSourcingCommitmentBOM WHERE SourcingCommitmentItemID = @StyleCommitmentItemID
	DELETE FROM pSourcingCommitmentBOMDetails WHERE SourcingCommitmentItemID = @StyleCommitmentItemID

	;WITH dims AS (
		SELECT DISTINCT sbdi.*
		FROM pStyleBOMDimensionItem sbdi
		CROSS APPLY (VALUES (sbdi.ItemDim1TypeId, sbdi.ItemDim1Id, sbdi.ItemDim1Active, 1),
							(sbdi.ItemDim2TypeId, sbdi.ItemDim2Id, sbdi.ItemDim2Active, 2),
							(sbdi.ItemDim3TypeId, sbdi.ItemDim3Id, sbdi.ItemDim3Active, 3)) 
						   V(DimTypeID, DimID, DimActive, Lvl)
		INNER JOIN pStyleSKUItem sku ON sku.StyleSKUItemID = @StyleSKUItemID
			AND V.DimTypeID IN (sku.ItemDim1TypeID, sku.ItemDim2TypeID, sku.ItemDim3TypeID)
		WHERE sbdi.StyleBOMDimensionID = @StyleBOMDimensionId
			AND V.DimID IS NOT NULL
			AND V.DimActive = 1)
	INSERT INTO pSourcingCommitmentBOM (
		 SourcingCommitmentBOMID
		,StyleBOMDimensionItemID
		,SourcingCommitmentItemID
		,StyleQuoteItemID
		,SourcingHeaderID
		,SourcingStyleID
		,StyleBOMDimensionID
		,WorkFlowID
		,WorkFlowItemID
		,StyleID
		,StyleSet
		,ItemDim1TypeId
		,ItemDim2TypeId
		,ItemDim3TypeId
		,ItemDim1Id
		,ItemDim2Id
		,ItemDim3Id
		,ItemDim1Name
		,ItemDim2Name
		,ItemDim3Name
		,ItemDim1Sort
		,ItemDim2Sort
		,ItemDim3Sort
		,ItemDim1Active
		,ItemDim2Active
		,ItemDim3Active
		,CDate
		,CUser
		,MDate
		,MUser
		,Amlmeashdrid
		,Sizerangeid)
	SELECT NEWID()
		,StyleBOMDimensionItemID
		,@StyleCommitmentItemID
		,@StyleQuoteItemID
		,@SourcingHeaderID
		,@SourcingStyleID
		,@StyleBOMDimensionID
		,WorkFlowID
		,WorkFlowItemID
		,StyleID
		,StyleSet
		,ItemDim1TypeId
		,ItemDim2TypeId
		,ItemDim3TypeId
		,ItemDim1Id
		,ItemDim2Id
		,ItemDim3Id
		,ItemDim1Name
		,ItemDim2Name
		,ItemDim3Name
		,ItemDim1Sort
		,ItemDim2Sort
		,ItemDim3Sort
		,0
		,0
		,0
		,@MDate
		,@MUser
		,@MDate
		,@MUser
		,Amlmeashdrid
		,Sizerangeid
	FROM dims


	RETURN
END
   
--delete from pSourcingQuoteStyleBOM where StyleQuoteItemID=@StyleQuoteItemID		
--delete from pSourcingQuotationBOMDetails where 	StyleQuoteItemID=@StyleQuoteItemID
   
if @ItemDim1TypeId<>'00000000-0000-0000-0000-000000000000' 	and @ItemDim2TypeId<>'00000000-0000-0000-0000-000000000000' 
and @ItemDim3TypeId<>'00000000-0000-0000-0000-000000000000' 
begin
	INSERT INTO [dbo].[pSourcingCommitmentBOM]
           ([SourcingCommitmentBOMID]
           ,[StyleBOMDimensionItemID]
           ,[SourcingCommitmentItemID]
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
     @StyleCommitmentItemID,
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
     ItemDim1Id is not null and ItemDim1Id not in (SELECT ItemDim1Id from pSourcingCommitmentBOM where SourcingCommitmentItemID=@StyleCommitmentItemID and ItemDim1Id is not null)
     
     INSERT INTO [dbo].[pSourcingCommitmentBOM]
           ([SourcingCommitmentBOMID]
           ,[StyleBOMDimensionItemID]
           ,[SourcingCommitmentItemID]
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
     @StyleCommitmentItemID,
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
     and ItemDim2Id is not null and ItemDim2Id not in (SELECT ItemDim2Id from pSourcingCommitmentBOM where SourcingCommitmentItemID=@StyleCommitmentItemID and ItemDim2Id is not null)
     
     INSERT INTO [dbo].[pSourcingCommitmentBOM]
           ([SourcingCommitmentBOMID]
           ,[StyleBOMDimensionItemID]
           ,[SourcingCommitmentItemID]
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
     @StyleCommitmentItemID,
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
     and ItemDim3Id is not null and ItemDim3Id not in (SELECT ItemDim3Id from pSourcingCommitmentBOM where SourcingCommitmentItemID=@StyleCommitmentItemID and ItemDim3Id is not null)
 end
 else if @ItemDim1TypeId<>'00000000-0000-0000-0000-000000000000' and @ItemDim2TypeId<>'00000000-0000-0000-0000-000000000000' 
	begin
		INSERT INTO [dbo].[pSourcingCommitmentBOM]
           ([SourcingCommitmentBOMID]
           ,[StyleBOMDimensionItemID]
           ,[SourcingCommitmentItemID]
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
     @StyleCommitmentItemID,
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
     and ItemDim1Id is not null and ItemDim1Id not in (SELECT ItemDim1Id from pSourcingCommitmentBOM where SourcingCommitmentItemID=@StyleCommitmentItemID and ItemDim1Id is not null)
     
     INSERT INTO [dbo].[pSourcingCommitmentBOM]
           ([SourcingCommitmentBOMID]
           ,[StyleBOMDimensionItemID]
           ,[SourcingCommitmentItemID]
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
     @StyleCommitmentItemID,
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
     and ItemDim2Id is not null and ItemDim2Id not in (SELECT ItemDim2Id from pSourcingCommitmentBOM where SourcingCommitmentItemID=@StyleCommitmentItemID and ItemDim2Id is not null)
	end 
 else if @ItemDim1TypeId<>'00000000-0000-0000-0000-000000000000' 
	begin
		INSERT INTO [dbo].[pSourcingCommitmentBOM]
           ([SourcingCommitmentBOMID]
           ,[StyleBOMDimensionItemID]
           ,[SourcingCommitmentItemID]
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
     @StyleCommitmentItemID,
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
     and ItemDim1Id is not null and ItemDim1Id not in (SELECT ItemDim1Id from pSourcingCommitmentBOM where SourcingCommitmentItemID=@StyleCommitmentItemID and ItemDim1Id is not null)
     
	end 
	
	update pSourcingCommitmentBOM set NotShow=1
	where SourcingCommitmentItemID=@StyleCommitmentItemID and ItemDim1Id is not null and ItemDim1Id not in (SELECT ItemDim1Id from pStyleBOMDimensionItem where StyleBOMDimensionID=@StyleBOMDimensionID and ItemDim1Id is not null )
	
	update pSourcingCommitmentBOM set NotShow=1
	where SourcingCommitmentItemID=@StyleCommitmentItemID and ItemDim2Id is not null and ItemDim2Id not in (SELECT ItemDim2Id from pStyleBOMDimensionItem where StyleBOMDimensionID=@StyleBOMDimensionID and ItemDim2Id is not null )
	
	update pSourcingCommitmentBOM set NotShow=1
	where SourcingCommitmentItemID=@StyleCommitmentItemID and ItemDim3Id is not null and ItemDim3Id not in (SELECT ItemDim3Id from pStyleBOMDimensionItem where StyleBOMDimensionID=@StyleBOMDimensionID and ItemDim3Id is not null )
	
		update pSourcingCommitmentBOM set NotShow=1
	where SourcingCommitmentItemID=@StyleCommitmentItemID and ItemDim1Id is not null and ItemDim1Id in (SELECT ItemDim1Id from pStyleBOMDimensionItem where StyleBOMDimensionID=@StyleBOMDimensionID and ItemDim1Id is not null and ItemDim1Active=0)
	
	update pSourcingCommitmentBOM set NotShow=1
	where SourcingCommitmentItemID=@StyleCommitmentItemID and ItemDim2Id is not null and ItemDim2Id in (SELECT ItemDim2Id from pStyleBOMDimensionItem where StyleBOMDimensionID=@StyleBOMDimensionID and ItemDim2Id is not null and ItemDim2Active=0)
	
	update pSourcingCommitmentBOM set NotShow=1
	where SourcingCommitmentItemID=@StyleCommitmentItemID and ItemDim3Id is not null and ItemDim3Id in (SELECT ItemDim3Id from pStyleBOMDimensionItem where StyleBOMDimensionID=@StyleBOMDimensionID and ItemDim3Id is not null and ItemDim3Active=0)
	
	update pSourcingCommitmentBOM set NotShow=0
	where SourcingCommitmentItemID=@StyleCommitmentItemID and ItemDim1Id is not null and ItemDim1Id  in (SELECT ItemDim1Id from pStyleBOMDimensionItem where StyleBOMDimensionID=@StyleBOMDimensionID and ItemDim1Id is not null and ItemDim1Active=1) 
	
	update pSourcingCommitmentBOM set NotShow=0
	where SourcingCommitmentItemID=@StyleCommitmentItemID and ItemDim2Id is not null and ItemDim2Id  in (SELECT ItemDim2Id from pStyleBOMDimensionItem where StyleBOMDimensionID=@StyleBOMDimensionID and ItemDim2Id is not null and ItemDim2Active=1) 
	
	update pSourcingCommitmentBOM set NotShow=0
	where SourcingCommitmentItemID=@StyleCommitmentItemID and ItemDim3Id is not null and ItemDim3Id in (SELECT ItemDim3Id from pStyleBOMDimensionItem where StyleBOMDimensionID=@StyleBOMDimensionID and ItemDim3Id is not null and ItemDim3Active=1) 
 
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08224', GetDate())
GO
