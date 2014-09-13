/****** Object:  StoredProcedure [dbo].[spx_SourcingQuote_StyleBOMQuickItem_INSERT]    Script Date: 11/16/2012 17:20:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingQuote_StyleBOMQuickItem_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingQuote_StyleBOMQuickItem_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SourcingQuote_StyleBOMQuickItem_INSERT]    Script Date: 11/16/2012 17:20:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Stored Procedure

CREATE PROCEDURE [dbo].[spx_SourcingQuote_StyleBOMQuickItem_INSERT]
(
@StyleQuoteItemID uniqueidentifier,
@StyleBOMDimensionId uniqueidentifier,
@SourcingHeaderID uniqueidentifier,
@Quantity int,
@MUser nvarchar(200),
@MDate datetime
)
AS 

Declare @OldStyleBOMDimensionID uniqueidentifier

BEGIN
   select top 1 @OldStyleBOMDimensionID=COALESCE(StyleBOMDimensionID,'00000000-0000-0000-0000-000000000000') from pSourcingQuoteStyleBOM where 
   SourcingHeaderID=@SourcingHeaderID and StyleQuoteItemID=@StyleQuoteItemID
    
   If @OldStyleBOMDimensionID<>@StyleBOMDimensionId 
   begin
		delete from pSourcingQuoteStyleBOM where 
		StyleBOMDimensionID=@OldStyleBOMDimensionID and SourcingHeaderID=@SourcingHeaderID and StyleQuoteItemID=@StyleQuoteItemID
		
		delete from pSourcingQuotationBOMDetails where 
		StyleBOMDimensionID=@OldStyleBOMDimensionID and SourcingHeaderID=@SourcingHeaderID and StyleQuoteItemID=@StyleQuoteItemID
   end
   
	
	INSERT INTO [dbo].[pSourcingQuoteStyleBOM]
           ([SourcingQuoteStyleBOMId]
           ,[StyleBOMDimensionItemID]
           ,[StyleQuoteItemID]
           ,[SourcingHeaderID]
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
     1,
     1,
     1,
     @MDate,
     @MUser,
     @MDate,
     @MUser,
     Amlmeashdrid,
     Sizerangeid from pStyleBOMDimensionItem where StyleBOMDimensionID=@StyleBOMDimensionID
     and StyleBOMDimensionID not in (select StyleBOMDimensionID from pSourcingQuoteStyleBOM where 
	 SourcingHeaderID=@SourcingHeaderID and StyleQuoteItemID=@StyleQuoteItemID)
			
     EXECUTE spx_SourcingQuote_StyleBOMDetailsQuick_INSERT
		@StyleQuoteItemID 
		,@StyleBOMDimensionId 
		,@SourcingHeaderID
		,@Quantity 
		,@MUser 
		,@MDate 
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04362', GetDate())
GO
