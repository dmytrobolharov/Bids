/****** Object:  StoredProcedure [dbo].[spx_SourcingQuote_StyleBOMItem_INSERT]    Script Date: 11/21/2012 11:59:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingQuote_StyleBOMItem_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingQuote_StyleBOMItem_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SourcingQuote_StyleBOMItem_INSERT]    Script Date: 11/21/2012 11:59:03 ******/
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

BEGIN
   
		delete from pSourcingQuoteStyleBOM where 		
		SourcingHeaderID=@SourcingHeaderID and StyleQuoteItemID=@StyleQuoteItemID
		and SourcingStyleID=@SourcingStyleID

		delete from pSourcingQuotationBOMDetails where 		
		SourcingHeaderID=@SourcingHeaderID and StyleQuoteItemID=@StyleQuoteItemID
		and SourcingStyleID=@SourcingStyleID
		
		delete from pSourcingQuotationBOMMaterials where
		SourcingHeaderID = @SourcingHeaderID AND StyleQuoteItemID = @StyleQuoteItemID
		AND SourcingStyleID = @SourcingStyleID
  
   
	
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
     ItemDim1Active,
     ItemDim2Active,
     ItemDim3Active,
     @MDate,
     @MUser,
     @MDate,
     @MUser,
     Amlmeashdrid,
     Sizerangeid from pStyleBOMDimensionItem where StyleBOMDimensionID=@StyleBOMDimensionID
 
     EXECUTE spx_SourcingQuote_StyleBOMDetails_INSERT
		@StyleQuoteItemID 
		,@StyleBOMDimensionId 
		,@SourcingHeaderID 
		,@SourcingStyleID
		,@MUser 
		,@MDate 
		
	EXECUTE spx_SourcingQuote_StyleBOMMaterials_INSERT
		@StyleQuoteItemID,
		@SourcingHeaderID,
		@SourcingStyleID,
		@StyleBOMDimensionId
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04410', GetDate())
GO