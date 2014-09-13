

/****** Object:  StoredProcedure [dbo].[spx_SourcingQuote_StyleBOMDetails_INSERT]    Script Date: 10/16/2012 10:16:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingQuote_StyleBOMDetails_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingQuote_StyleBOMDetails_INSERT]
GO


/****** Object:  StoredProcedure [dbo].[spx_SourcingQuote_StyleBOMDetails_INSERT]    Script Date: 10/16/2012 10:16:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- Stored Procedure

CREATE PROCEDURE [dbo].[spx_SourcingQuote_StyleBOMDetails_INSERT]
(
@StyleQuoteItemID uniqueidentifier,
@StyleBOMDimensionId uniqueidentifier,
@SourcingHeaderID uniqueidentifier,
@MUser nvarchar(200),
@MDate datetime
)
AS 

BEGIN
	INSERT INTO [dbo].[pSourcingQuotationBOMDetails]
           ([SourcingQuotationBOMDetailsID]
           ,[StyleQuoteItemID]
           ,[SourcingHeaderId]
           ,[StyleID]
           ,[styleset]
           ,[WorkFlowID]
           ,[WorkFlowItemID]
           ,[StyleBOMDimensionId]
           ,[StyleBOMDimensionItemId]
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
           ,[Quantity]
           ,[Cost]
           ,[TotalCost]
           ,[PartnerCost]
           ,[PartnerTotal]
           ,[CUser]
           ,[MUser]
           ,[CDate]
           ,[MDate])
     select
           NEWID()
           ,@StyleQuoteItemID
           ,@SourcingHeaderId
           ,StyleID
           ,styleset
           ,WorkFlowID
           ,WorkFlowItemID
           ,@StyleBOMDimensionId
           ,StyleBOMDimensionItemId
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
           ,0
           ,0
           ,0
           ,0
           ,0
           ,@MUser
           ,@MUser
           ,@MDate
           ,@MDate from pStyleBOMDimensionItems where StyleBOMDimensionID=@StyleBOMDimensionID
           and StyleBOMDimensionID not in (select StyleBOMDimensionID from pSourcingQuotationBOMDetails where 
			SourcingHeaderID=@SourcingHeaderID and StyleQuoteItemID=@StyleQuoteItemID)
     
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04211', GetDate())
GO
