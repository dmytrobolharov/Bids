
/****** Object:  StoredProcedure [dbo].[spx_Commitment_INSERT]    Script Date: 11/21/2012 17:27:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Commitment_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Commitment_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_Commitment_INSERT]    Script Date: 11/21/2012 17:27:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_Commitment_INSERT]
(
@QuoteItemID uniqueidentifier,
@MUser nvarchar(200),
@MDate datetime
)
AS 
Declare @CommitmentId uniqueidentifier
Declare @CommitmentBOMId uniqueidentifier
BEGIN
set @CommitmentId =  NEWID()
set @CommitmentBOMId =  NEWID()
	insert into pSourcingCommitmentItem( SourcingCommitmentItemID, StyleQuoteItemID, 
                      StyleQuoteItemNo, StyleQuoteItemShare, StyleQuoteItemStatusId, 
                      StyleQuoteVariationId, StyleQuoteID, StyleQuotaDutyID, 
                      StyleDevelopmentID, StyleID, StyleQuoteTradePartnerID, 
                      StyleCostingID, StyleCostingType, StyleCostingFreightTypeID, 
                      TradePartnerID, TradePartnerVendorID, StyleQuoteItemDueDate, 
                      StyleQuoteItemApprovedBy, StyleQuoteItemApprovedDate, 
                      StyleQuoteItemCustomField1, StyleQuoteItemCustomField2, 
                      StyleQuoteItemCustomField3, StyleQuoteItemCustomField5, 
                      StyleQuoteItemCustomField4, StyleQuoteItemCustomField6, 
                      StyleQuoteItemCustomField7, StyleQuoteItemCustomField8, 
                      StyleQuoteItemCustomField9, StyleQuoteItemCustomField10, 
                      StyleQuoteItemCustomField11, StyleQuoteItemCustomField12, 
                      StyleQuoteItemCustomField13, StyleQuoteItemCustomField14, 
                      StyleQuoteItemCustomField15, StyleQuoteItemCustomField16, 
                      StyleQuoteItemCustomField17, StyleQuoteItemCustomField18, 
                      StyleQuoteItemCustomField19, StyleQuoteItemCustomField20, 
                      StyleQuoteItemCustomField21, StyleQuoteItemCustomField22, 
                      StyleQuoteItemCustomField23, StyleQuoteItemCustomField24, 
                      StyleQuoteItemCustomField25, StyleQuoteItemCustomField26, 
                      StyleQuoteItemCustomField27, StyleQuoteItemCustomField28, 
                      StyleQuoteItemCustomField29, StyleQuoteItemCustomField30, 
                      StyleQuoteItemCustomField31, StyleQuoteItemCustomField32, 
                      StyleQuoteItemCustomField33, StyleQuoteItemCustomField34, 
                      StyleQuoteItemCustomField35, StyleQuoteItemNotes, 
                      StyleCostingCustomField1, StyleCostingCustomField2, 
                      StyleCostingCustomField3, StyleCostingCustomField4, 
                      StyleCostingCustomField5, StyleCostingCustomField6, 
                      StyleCostingCustomField7, StyleCostingCustomField8, 
                      StyleCostingCustomField9, StyleCostingCustomField10, 
                      StyleCostingCustomField11, StyleCostingCustomField12, 
                      StyleCostingCustomField13, StyleCostingCustomField15, 
                      StyleCostingCustomField14, StyleCostingCustomField16, 
                      StyleCostingCustomField17, StyleCostingCustomField18, 
                      StyleCostingCustomField19, StyleCostingCustomField20, 
                      StyleCostingCustomField21, StyleCostingCustomField22, 
                      StyleCostingCustomField23, StyleCostingCustomField24, 
                      StyleCostingCustomField25, StyleCostingCustomField26, 
                      StyleCostingCustomField27, StyleCostingCustomField28, 
                      StyleCostingCustomField29, StyleCostingCustomField30, 
                      StyleCostingCustomField31, StyleCostingCustomField32, 
                      StyleCostingCustomField33, StyleCostingCustomField34, 
                      StyleCostingCustomField35, CUser, CDate, 
                      MUser, MDate, QuoteFolderSort, 
                      AgentView, StyleColorID, StyleSourcingID, 
                      StyleSeasonYearID, BOMCost, BOLCost, 
                      BOLCurr, StyleQuotaVendorDutyID, SourcingHeaderID)
                       select
                        @CommitmentId,  StyleQuoteItemID, 
                      StyleQuoteItemNo, StyleQuoteItemShare, 0, 
                      StyleQuoteVariationId, StyleQuoteID, StyleQuotaDutyID, 
                      StyleDevelopmentID, StyleID, StyleQuoteTradePartnerID, 
                      StyleCostingID, StyleCostingType, StyleCostingFreightTypeID, 
                      TradePartnerID, TradePartnerVendorID, StyleQuoteItemDueDate, 
                      StyleQuoteItemApprovedBy, StyleQuoteItemApprovedDate, 
                      StyleQuoteItemCustomField1, StyleQuoteItemCustomField2, 
                      StyleQuoteItemCustomField3, StyleQuoteItemCustomField5, 
                      StyleQuoteItemCustomField4, StyleQuoteItemCustomField6, 
                      StyleQuoteItemCustomField7, StyleQuoteItemCustomField8, 
                      StyleQuoteItemCustomField9, StyleQuoteItemCustomField10, 
                      StyleQuoteItemCustomField11, StyleQuoteItemCustomField12, 
                      StyleQuoteItemCustomField13, StyleQuoteItemCustomField14, 
                      StyleQuoteItemCustomField15, StyleQuoteItemCustomField16, 
                      StyleQuoteItemCustomField17, StyleQuoteItemCustomField18, 
                      StyleQuoteItemCustomField19, StyleQuoteItemCustomField20, 
                      StyleQuoteItemCustomField21, StyleQuoteItemCustomField22, 
                      StyleQuoteItemCustomField23, StyleQuoteItemCustomField24, 
                      StyleQuoteItemCustomField25, StyleQuoteItemCustomField26, 
                      StyleQuoteItemCustomField27, StyleQuoteItemCustomField28, 
                      StyleQuoteItemCustomField29, StyleQuoteItemCustomField30, 
                      StyleQuoteItemCustomField31, StyleQuoteItemCustomField32, 
                      StyleQuoteItemCustomField33, StyleQuoteItemCustomField34, 
                      StyleQuoteItemCustomField35, StyleQuoteItemNotes, 
                      StyleCostingCustomField1, StyleCostingCustomField2, 
                      StyleCostingCustomField3, StyleCostingCustomField4, 
                      StyleCostingCustomField5, StyleCostingCustomField6, 
                      StyleCostingCustomField7, StyleCostingCustomField8, 
                      StyleCostingCustomField9, StyleCostingCustomField10, 
                      StyleCostingCustomField11, StyleCostingCustomField12, 
                      StyleCostingCustomField13, StyleCostingCustomField15, 
                      StyleCostingCustomField14, StyleCostingCustomField16, 
                      StyleCostingCustomField17, StyleCostingCustomField18, 
                      StyleCostingCustomField19, StyleCostingCustomField20, 
                      StyleCostingCustomField21, StyleCostingCustomField22, 
                      StyleCostingCustomField23, StyleCostingCustomField24, 
                      StyleCostingCustomField25, StyleCostingCustomField26, 
                      StyleCostingCustomField27, StyleCostingCustomField28, 
                      StyleCostingCustomField29, StyleCostingCustomField30, 
                      StyleCostingCustomField31, StyleCostingCustomField32, 
                      StyleCostingCustomField33, StyleCostingCustomField34, 
                      StyleCostingCustomField35, @MUser, @MDate, 
                      @MUser, @MDate, QuoteFolderSort, 
                      AgentView, StyleColorID, StyleSourcingID, 
                      StyleSeasonYearID, BOMCost, BOLCost, 
                      BOLCurr, StyleQuotaVendorDutyID, SourcingHeaderID
                      from pStyleQuoteItem where StyleQuoteItemID = @QuoteItemID
   
   
   
   
   insert into pSourcingCommitmentBOM(SourcingCommitmentBOMID, StyleBOMDimensionItemID, 
                      SourcingCommitmentItemID, StyleQuoteItemID, SourcingHeaderID, 
                      StyleBOMDimensionID, SourcingStyleID, WorkFlowID, 
                      WorkFlowItemID, StyleID, StyleSet, 
                      ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, 
                      ItemDim1Id, ItemDim2Id, ItemDim3Id, 
                      ItemDim1Name, ItemDim2Name, ItemDim3Name, 
                      ItemDim1Sort, ItemDim2Sort, ItemDim3Sort, 
                      ItemDim1Active, ItemDim2Active, ItemDim3Active, 
                      Comments, ImageId, CDate, CUser, 
                      MDate, MUser, Amlmeashdrid, 
                      Sizerangeid)
                      select
                      NEWID(), StyleBOMDimensionItemID, 
                      @CommitmentId, StyleQuoteItemID, SourcingHeaderID, 
                      StyleBOMDimensionID, SourcingStyleID, WorkFlowID, 
                      WorkFlowItemID, StyleID, StyleSet, 
                      ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, 
                      ItemDim1Id, ItemDim2Id, ItemDim3Id, 
                      ItemDim1Name, ItemDim2Name, ItemDim3Name, 
                      ItemDim1Sort, ItemDim2Sort, ItemDim3Sort, 
                      ItemDim1Active, ItemDim2Active, ItemDim3Active, 
                      Comments, ImageId, @MDate, @MUser, 
                      @MDate, @MUser, Amlmeashdrid, 
                      Sizerangeid
                      from pSourcingQuoteStyleBOM where StyleQuoteItemID = @QuoteItemID
                      
                      
                      insert into pSourcingCommitmentBOMDetails(SourcingCommitmentBOMDetailsID, SourcingCommitmentItemID, 
                      StyleQuoteItemID, SourcingHeaderId, 
                      SourcingStyleID, StyleID, styleset, 
                      WorkFlowID, WorkFlowItemID, 
                      StyleBOMDimensionId, StyleBOMDimensionItemId, 
                      ItemDim2TypeId, ItemDim1TypeId, 
                      ItemDim3TypeId, ItemDim1Id, ItemDim2Id, 
                      ItemDim3Id, ItemDim1Name, ItemDim2Name, 
                      ItemDim3Name, ItemDim1Sort, ItemDim2Sort, 
                      ItemDim3Sort, ItemDim1Active, ItemDim2Active, 
                      ItemDim3Active, Quantity, Cost, 
                      TotalCost, PartnerCost, PartnerTotal, 
                      CUser, MUser, CDate, 
                      MDate)
                      select
                      NEWID(), @CommitmentId, 
                      StyleQuoteItemID, SourcingHeaderId, 
                      SourcingStyleID, StyleID, styleset, 
                      WorkFlowID, WorkFlowItemID, 
                      StyleBOMDimensionId, StyleBOMDimensionItemId, 
                      ItemDim2TypeId, ItemDim1TypeId, 
                      ItemDim3TypeId, ItemDim1Id, ItemDim2Id, 
                      ItemDim3Id, ItemDim1Name, ItemDim2Name, 
                      ItemDim3Name, ItemDim1Sort, ItemDim2Sort, 
                      ItemDim3Sort, ItemDim1Active, ItemDim2Active, 
                      ItemDim3Active, Quantity, Cost, 
                      TotalCost, PartnerCost, PartnerTotal, 
                      @MUser, @MUser, @MDate, 
                      @MDate
                      from pSourcingQuotationBOMDetails where StyleQuoteItemID = @QuoteItemID

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04407', GetDate())
GO

