/****** Object:  StoredProcedure [dbo].[spx_Sourcing_QuoteCopy]    Script Date: 12/24/2012 17:51:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sourcing_QuoteCopy]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sourcing_QuoteCopy]
GO

/****** Object:  StoredProcedure [dbo].[spx_Sourcing_QuoteCopy]    Script Date: 12/24/2012 17:51:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_Sourcing_QuoteCopy]
(
@StyleQuoteItemID UNIQUEIDENTIFIER,
@SourcingTradePartnerId uniqueidentifier,
@MUser nvarchar(200),
@MDate datetime
)
AS 

Declare
@TradePartnerID uniqueidentifier,
@strNewId uniqueidentifier ,
@StyleBOMDimensionId uniqueidentifier

set @strNewId = newid()

SELECT @TradePartnerID = TradePartnerID from pSourcingTradePartner WITH (NOLOCK) WHERE SourcingTradePartnerID = @SourcingTradePartnerID
-- insert quote item

INSERT INTO pStyleQuoteItem(StyleQuoteItemID, StyleQuoteItemShare, StyleQuoteItemStatusId, StyleQuoteVariationId, StyleQuoteID, StyleQuotaDutyID, StyleDevelopmentID, 
                      StyleID, StyleQuoteTradePartnerID, StyleCostingID, StyleCostingType, StyleCostingFreightTypeID, TradePartnerID, TradePartnerVendorID, StyleQuoteItemDueDate, 
                      StyleQuoteItemApprovedBy, StyleQuoteItemApprovedDate, StyleQuoteItemCustomField1, StyleQuoteItemCustomField2, StyleQuoteItemCustomField3, 
                      StyleQuoteItemCustomField4, StyleQuoteItemCustomField5, StyleQuoteItemCustomField6, StyleQuoteItemCustomField7, StyleQuoteItemCustomField8, 
                      StyleQuoteItemCustomField9, StyleQuoteItemCustomField10, StyleQuoteItemCustomField11, StyleQuoteItemCustomField12, StyleQuoteItemCustomField13, 
                      StyleQuoteItemCustomField14, StyleQuoteItemCustomField15, StyleQuoteItemCustomField16, StyleQuoteItemCustomField17, StyleQuoteItemCustomField18, 
                      StyleQuoteItemCustomField19, StyleQuoteItemCustomField20, StyleQuoteItemCustomField21, StyleQuoteItemCustomField22, StyleQuoteItemCustomField23, 
                      StyleQuoteItemCustomField24, StyleQuoteItemCustomField25, StyleQuoteItemCustomField26, StyleQuoteItemCustomField27, StyleQuoteItemCustomField28, 
                      StyleQuoteItemCustomField29, StyleQuoteItemCustomField30, StyleQuoteItemCustomField31, StyleQuoteItemCustomField32, StyleQuoteItemCustomField33, 
                      StyleQuoteItemCustomField34, StyleQuoteItemCustomField35, StyleQuoteItemNotes, StyleCostingCustomField1, StyleCostingCustomField2, 
                      StyleCostingCustomField3, StyleCostingCustomField4, StyleCostingCustomField5, StyleCostingCustomField6, StyleCostingCustomField7, StyleCostingCustomField8, 
                      StyleCostingCustomField9, StyleCostingCustomField10, StyleCostingCustomField11, StyleCostingCustomField12, StyleCostingCustomField13, 
                      StyleCostingCustomField14, StyleCostingCustomField15, StyleCostingCustomField16, StyleCostingCustomField17, StyleCostingCustomField18, 
                      StyleCostingCustomField19, StyleCostingCustomField20, StyleCostingCustomField21, StyleCostingCustomField22, StyleCostingCustomField23, 
                      StyleCostingCustomField24, StyleCostingCustomField25, StyleCostingCustomField26, StyleCostingCustomField27, StyleCostingCustomField28, 
                      StyleCostingCustomField29, StyleCostingCustomField30, StyleCostingCustomField31, StyleCostingCustomField32, StyleCostingCustomField33, 
                      StyleCostingCustomField34, StyleCostingCustomField35, CUser, CDate, MUser, MDate, QuoteFolderSort, AgentView, StyleColorID, StyleSourcingID, 
                      StyleSeasonYearID, BOMCost, BOLCost, BOLCurr, StyleQuotaVendorDutyID, SourcingHeaderID, BOMOptionDefault, TechPack)
SELECT     @strNewId, StyleQuoteItemShare, StyleQuoteItemStatusId, StyleQuoteVariationId, StyleQuoteID, StyleQuotaDutyID, StyleDevelopmentID, 
                      StyleID, @SourcingTradePartnerId, StyleCostingID, StyleCostingType, StyleCostingFreightTypeID, @TradePartnerID, TradePartnerVendorID, StyleQuoteItemDueDate, 
                      StyleQuoteItemApprovedBy, StyleQuoteItemApprovedDate, StyleQuoteItemCustomField1, StyleQuoteItemCustomField2, StyleQuoteItemCustomField3, 
                      StyleQuoteItemCustomField4, StyleQuoteItemCustomField5, StyleQuoteItemCustomField6, StyleQuoteItemCustomField7, StyleQuoteItemCustomField8, 
                      StyleQuoteItemCustomField9, StyleQuoteItemCustomField10, StyleQuoteItemCustomField11, StyleQuoteItemCustomField12, StyleQuoteItemCustomField13, 
                      StyleQuoteItemCustomField14, StyleQuoteItemCustomField15, StyleQuoteItemCustomField16, StyleQuoteItemCustomField17, StyleQuoteItemCustomField18, 
                      StyleQuoteItemCustomField19, StyleQuoteItemCustomField20, StyleQuoteItemCustomField21, StyleQuoteItemCustomField22, StyleQuoteItemCustomField23, 
                      StyleQuoteItemCustomField24, StyleQuoteItemCustomField25, StyleQuoteItemCustomField26, StyleQuoteItemCustomField27, StyleQuoteItemCustomField28, 
                      StyleQuoteItemCustomField29, StyleQuoteItemCustomField30, StyleQuoteItemCustomField31, StyleQuoteItemCustomField32, StyleQuoteItemCustomField33, 
                      StyleQuoteItemCustomField34, StyleQuoteItemCustomField35, StyleQuoteItemNotes, StyleCostingCustomField1, StyleCostingCustomField2, 
                      StyleCostingCustomField3, StyleCostingCustomField4, StyleCostingCustomField5, StyleCostingCustomField6, StyleCostingCustomField7, StyleCostingCustomField8, 
                      StyleCostingCustomField9, StyleCostingCustomField10, StyleCostingCustomField11, StyleCostingCustomField12, StyleCostingCustomField13, 
                      StyleCostingCustomField14, StyleCostingCustomField15, StyleCostingCustomField16, StyleCostingCustomField17, StyleCostingCustomField18, 
                      StyleCostingCustomField19, StyleCostingCustomField20, StyleCostingCustomField21, StyleCostingCustomField22, StyleCostingCustomField23, 
                      StyleCostingCustomField24, StyleCostingCustomField25, StyleCostingCustomField26, StyleCostingCustomField27, StyleCostingCustomField28, 
                      StyleCostingCustomField29, StyleCostingCustomField30, StyleCostingCustomField31, StyleCostingCustomField32, StyleCostingCustomField33, 
                      StyleCostingCustomField34, StyleCostingCustomField35, @MUser, @MDate, @MUser, @MDate, QuoteFolderSort, AgentView, StyleColorID, StyleSourcingID, 
                      StyleSeasonYearID, BOMCost, BOLCost, BOLCurr, StyleQuotaVendorDutyID, SourcingHeaderID, BOMOptionDefault, TechPack
FROM         pStyleQuoteItem where StyleQuoteItemID=@StyleQuoteItemID


-- ADDITIONAL COST

INSERT INTO pSourcingAdditionalCost(QuoteItemID, SourcingHeaderID, SourcingStyleID, Description, Amount, Sort, CDate, CUser, MUser, MDate, TeamID) 
SELECT     @strNewId, SourcingHeaderID, SourcingStyleID, Description, Amount, Sort, @MDate, @MUser, @MUser, @MDate, TeamID
FROM         pSourcingAdditionalCost where QuoteItemID=@StyleQuoteItemID

--StyleBOM

INSERT INTO pSourcingQuoteStyleBOM( StyleBOMDimensionItemID, StyleQuoteItemID, SourcingHeaderID, StyleBOMDimensionID, WorkFlowID, WorkFlowItemID, StyleID, 
                      StyleSet, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim1Id, ItemDim2Id, ItemDim3Id, ItemDim1Name, ItemDim2Name, ItemDim3Name, ItemDim1Sort, 
                      ItemDim2Sort, ItemDim3Sort, ItemDim1Active, ItemDim2Active, ItemDim3Active, Comments, ImageId, CDate, CUser, MDate, MUser, Amlmeashdrid, Sizerangeid, 
                      SourcingStyleID)
SELECT    StyleBOMDimensionItemID, @strNewId, SourcingHeaderID, StyleBOMDimensionID, WorkFlowID, WorkFlowItemID, StyleID, 
                      StyleSet, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim1Id, ItemDim2Id, ItemDim3Id, ItemDim1Name, ItemDim2Name, ItemDim3Name, ItemDim1Sort, 
                      ItemDim2Sort, ItemDim3Sort, ItemDim1Active, ItemDim2Active, ItemDim3Active, Comments, ImageId, @MDate, @MUser, @MDate, @MUser, Amlmeashdrid, Sizerangeid, 
                      SourcingStyleID
FROM         pSourcingQuoteStyleBOM where StyleQuoteItemID=@StyleQuoteItemID

-- StyleBOM Details

INSERT INTO pSourcingQuotationBOMDetails(StyleQuoteItemID, SourcingHeaderId, StyleID, styleset, WorkFlowID, WorkFlowItemID, StyleBOMDimensionId, 
                      StyleBOMDimensionItemId, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim1Id, ItemDim2Id, ItemDim3Id, ItemDim1Name, ItemDim2Name, 
                      ItemDim3Name, ItemDim1Sort, ItemDim2Sort, ItemDim3Sort, ItemDim1Active, ItemDim2Active, ItemDim3Active, Quantity, Cost, TotalCost, PartnerCost, PartnerTotal, 
                      CUser, MUser, CDate, MDate, SourcingStyleID)
SELECT      @strNewId, SourcingHeaderId, StyleID, styleset, WorkFlowID, WorkFlowItemID, StyleBOMDimensionId, 
                      StyleBOMDimensionItemId, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim1Id, ItemDim2Id, ItemDim3Id, ItemDim1Name, ItemDim2Name, 
                      ItemDim3Name, ItemDim1Sort, ItemDim2Sort, ItemDim3Sort, ItemDim1Active, ItemDim2Active, ItemDim3Active, Quantity, Cost, TotalCost, PartnerCost, PartnerTotal, 
                      @MUser,@MUser, @MDate, @MDate, SourcingStyleID
FROM         pSourcingQuotationBOMDetails where StyleQuoteItemID=@StyleQuoteItemID


--BOM MATERIALS
INSERT INTO pSourcingQuotationBOMMaterials(StyleQuoteItemID, SourcingHeaderID, SourcingStyleID, StyleMaterialMasterID, CopyStyleMaterialID, MainMaterial, Development, MiscColor, StyleSet, 
                      StyleID, WorkflowId, WorkflowItemId, StyleBOMDimensionId, Dim1TypeSel, Dim2TypeSel, Dim3TypeSel, UOM, Qty, MaterialPrice, MaterialSize, Ext, MaterialID, 
                      MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, ComponentTypeID, 
                      MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, Source, Notes, Placement, VendorPrice, VolumePrice, 
                      VolumePriceMinimum, VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, height, width, CDate, CUser, MDate, MUser, MChange, SChange, 
                      DChange, CChange, Action, ColorPlacement, Artwork, License, Colorway, MaterialSort, MaterialTrack, MaterialLinked, MaterialDimension, MaterialSizeA0, 
                      MaterialSizeA1, MaterialSizeA2, MaterialSizeA3, MaterialSizeA4, MaterialSizeA5, MaterialSizeA6, MaterialSizeA7, MaterialSizeA8, MaterialSizeA9, MaterialSizeA10, 
                      MaterialSizeA11, MaterialSizeA12, MaterialSizeA13, MaterialSizeA14, MaterialSizeA15, MaterialSizeA16, MaterialSizeA17, MaterialSizeA18, MaterialSizeA19, 
                      MaterialSizeB0, MaterialSizeB1, MaterialSizeB2, MaterialSizeB3, MaterialSizeB4, MaterialSizeB5, MaterialSizeB6, MaterialSizeB7, MaterialSizeB8, MaterialSizeB9, 
                      MaterialSizeB10, MaterialSizeB11, MaterialSizeB12, MaterialSizeB13, MaterialSizeB14, MaterialSizeB15, MaterialSizeB16, MaterialSizeB17, MaterialSizeB18, 
                      MaterialSizeB19, MaterialLining, MaterialSizeID, MaterialColorId, MaterialPackLabelGroupID, TradePartnerID, TradePartnerVendorID, MaterialBOM, MaterialCode, 
                      StyleMaterialLinkID, MultiCloth, MaterialCoreItemID, MaterialSwing, MaterialLinkID, MultiMaterialParentID, WebPDMCustom_Category, WebPDMCustom_SubCategory,
                       WebPDMCustom_ItemTypeCode, WebPDMCustom_Approved, WebPDMCustom_Content, WebPDMCustom_Finish, WebPDMCustom_Construction, 
                      WebPDMCustom_GroupDesc, WebPDMCustom_Dutiable, WebPDMCustom_WasteFactor, WebPDMCustom_UOM, WebPDMCustom_UOMPurchase, 
                      WebPDMCustom_Comments, AUTOCOLOR, Comments)
SELECT      @strNewId, SourcingHeaderID, SourcingStyleID, StyleMaterialMasterID, CopyStyleMaterialID, MainMaterial, Development, MiscColor, StyleSet, 
                      StyleID, WorkflowId, WorkflowItemId, StyleBOMDimensionId, Dim1TypeSel, Dim2TypeSel, Dim3TypeSel, UOM, Qty, MaterialPrice, MaterialSize, Ext, MaterialID, 
                      MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, ComponentTypeID, 
                      MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, Source, Notes, Placement, VendorPrice, VolumePrice, 
                      VolumePriceMinimum, VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, height, width, @MDate, @MUser, @MDate, @MUser, MChange, SChange, 
                      DChange, CChange, Action, ColorPlacement, Artwork, License, Colorway, MaterialSort, MaterialTrack, MaterialLinked, MaterialDimension, MaterialSizeA0, 
                      MaterialSizeA1, MaterialSizeA2, MaterialSizeA3, MaterialSizeA4, MaterialSizeA5, MaterialSizeA6, MaterialSizeA7, MaterialSizeA8, MaterialSizeA9, MaterialSizeA10, 
                      MaterialSizeA11, MaterialSizeA12, MaterialSizeA13, MaterialSizeA14, MaterialSizeA15, MaterialSizeA16, MaterialSizeA17, MaterialSizeA18, MaterialSizeA19, 
                      MaterialSizeB0, MaterialSizeB1, MaterialSizeB2, MaterialSizeB3, MaterialSizeB4, MaterialSizeB5, MaterialSizeB6, MaterialSizeB7, MaterialSizeB8, MaterialSizeB9, 
                      MaterialSizeB10, MaterialSizeB11, MaterialSizeB12, MaterialSizeB13, MaterialSizeB14, MaterialSizeB15, MaterialSizeB16, MaterialSizeB17, MaterialSizeB18, 
                      MaterialSizeB19, MaterialLining, MaterialSizeID, MaterialColorId, MaterialPackLabelGroupID, TradePartnerID, TradePartnerVendorID, MaterialBOM, MaterialCode, 
                      StyleMaterialLinkID, MultiCloth, MaterialCoreItemID, MaterialSwing, MaterialLinkID, MultiMaterialParentID, WebPDMCustom_Category, WebPDMCustom_SubCategory,
                       WebPDMCustom_ItemTypeCode, WebPDMCustom_Approved, WebPDMCustom_Content, WebPDMCustom_Finish, WebPDMCustom_Construction, 
                      WebPDMCustom_GroupDesc, WebPDMCustom_Dutiable, WebPDMCustom_WasteFactor, WebPDMCustom_UOM, WebPDMCustom_UOMPurchase, 
                      WebPDMCustom_Comments, AUTOCOLOR, Comments
FROM         pSourcingQuotationBOMMaterials where StyleQuoteItemID=@StyleQuoteItemID



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04682', GetDate())
GO