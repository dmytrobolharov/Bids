IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Commitment_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Commitment_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_Commitment_INSERT](
	@QuoteItemID UNIQUEIDENTIFIER,
	@BOMOptionID UNIQUEIDENTIFIER,
	@MUser NVARCHAR(200),
	@MDate DATETIME)
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
                      
                      
                      insert into pSourcingCommitmentAdditionalCost(CommitmentAdditionalCostID, SourcingAdditionalCostID,
                       CommitmentItemID, QuoteItemID, SourcingHeaderID,
                        SourcingStyleID, Description, Amount, Sort, CUser, 
                      CDate, MUser, MDate, TeamID ) 
                      select
                      NEWID(), SourcingAdditionalCostID,
                       @CommitmentId, QuoteItemID, SourcingHeaderID,
                        SourcingStyleID, Description, Amount, Sort, CUser, 
                      CDate, MUser, MDate, TeamID 
                      from pSourcingAdditionalCost where QuoteItemID = @QuoteItemID
           
    SELECT @BOMOptionID = BOMOptionDefault FROM pStyleQuoteItem WHERE StyleQuoteItemID = @QuoteItemID     
	if (@BOMOptionID IS NOT NULL) 
	begin
		declare @SourcingCommitmentBOMOptionID uniqueidentifier = NEWID()
		if EXISTS(SELECT * FROM pSourcingQuotationBOMOption WHERE StyleOptionID = @BOMOptionID) -- Option selected
		begin			
			INSERT INTO pSourcingCommitmentBOMOption
			   (SourcingCommitmentBOMOptionID, SourcingCommitmentItemID,
				StyleQuoteItemID, SourcingHeaderId, SourcingStyleID, StyleID, styleset, 
				OptionNo, OptionStatus, OptionSystem, WorkFlowID, WorkFlowItemID, StyleBOMDimensionId,
				CUser, MUser, CDate, MDate, 
				OptionName, XFactoryDate, OptionQuantity, OptionCost)
			SELECT @SourcingCommitmentBOMOptionID, @CommitmentId, 
				StyleQuoteItemID, SourcingHeaderId, SourcingStyleID, StyleID, styleset, 
				OptionNo, OptionStatus, OptionSystem, WorkFlowID, WorkFlowItemID, StyleBOMDimensionId, 
				CUser, MUser, CDate, MDate, 
				OptionName, XFactoryDate, OptionQuantity, OptionCost
		   FROM pSourcingQuotationBOMOption WHERE StyleOptionID = @BOMOptionID
	       
			INSERT INTO pSourcingCommitmentBOMOptionItems
			   (SourcingCommitmentBOMOptionID, SourcingCommitmentItemID, 
				StyleQuoteItemID, SourcingHeaderID, SourcingStyleID, 
				StyleMaterialID, StyleMaterialMasterID, CopyStyleMaterialID, 
				SubstituteForID, StyleOptionID, OptionNo, MainMaterial,
				Development, MiscColor, StyleSet, StyleID, 
				WorkflowId, WorkflowItemId, StyleBOMDimensionId, 
				Dim1TypeSel, Dim2TypeSel, Dim3TypeSel,
				UOM, Qty, MaterialPrice, Ext, 
				MaterialSize, MaterialID, MaterialPlacement, 
				MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion, 
				NoColorMatch, SupplierID, ComponentTypeID,
				MaterialType, MaterialNo, MaterialName, 
				A, B, C, D, E, F, G, H, I, J, K, L, M,
				N, O, P, Q, R, S, T, U, V, W, X, Y, Z, 
				Source, Notes, Placement, 
				VendorPrice, VolumePrice, VolumePriceMinimum, VendorProductionMin, VendorProductionLeadTime, 
				DetailYesNo, ImageType, height, width, 
				CDate, CUser, MDate, MUser, MChange, SChange, DChange, CChange,
				Action, ColorPlacement, Artwork, License, Colorway, 
				MaterialSort, MaterialTrack, MaterialLinked, MaterialDimension, 
				MaterialSizeA0, MaterialSizeA1, MaterialSizeA2, MaterialSizeA3, MaterialSizeA4, 
				MaterialSizeA5, MaterialSizeA6, MaterialSizeA7, MaterialSizeA8, MaterialSizeA9,
				MaterialSizeA10, MaterialSizeA11, MaterialSizeA12, MaterialSizeA13, MaterialSizeA14,
				MaterialSizeA15, MaterialSizeA16, MaterialSizeA17, MaterialSizeA18, MaterialSizeA19,
				MaterialSizeB0, MaterialSizeB1, MaterialSizeB2, MaterialSizeB3, MaterialSizeB4,
				MaterialSizeB5, MaterialSizeB6, MaterialSizeB7, MaterialSizeB8, MaterialSizeB9,
				MaterialSizeB10, MaterialSizeB11, MaterialSizeB12, MaterialSizeB13, MaterialSizeB14,
				MaterialSizeB15, MaterialSizeB16, MaterialSizeB17, MaterialSizeB18, MaterialSizeB19,
				MaterialLining, MaterialSizeID, MaterialColorId, MaterialPackLabelGroupID,
				TradePartnerID, TradePartnerVendorID, MaterialBOM, MaterialCode, StyleMaterialLinkID, 
				MultiCloth, MaterialCoreItemID, MaterialSwing, MaterialLinkID, MultiMaterialParentID, 
				WebPDMCustom_Category, WebPDMCustom_SubCategory, WebPDMCustom_ItemTypeCode,
				WebPDMCustom_Approved, WebPDMCustom_Content, WebPDMCustom_Finish, WebPDMCustom_Construction,
				WebPDMCustom_GroupDesc, WebPDMCustom_Dutiable, WebPDMCustom_WasteFactor,
				WebPDMCustom_UOM, WebPDMCustom_UOMPurchase, WebPDMCustom_Comments,
				AUTOCOLOR, Comments)
		   SELECT @SourcingCommitmentBOMOptionID, @CommitmentId, 
				StyleQuoteItemID, SourcingHeaderID, SourcingStyleID, 
				StyleMaterialID, StyleMaterialMasterID, CopyStyleMaterialID,
				SubstituteForID, StyleOptionID, OptionNo, MainMaterial, 
				Development, MiscColor, StyleSet, StyleID,
				WorkflowId, WorkflowItemId, StyleBOMDimensionId,
				Dim1TypeSel, Dim2TypeSel, Dim3TypeSel,
				UOM, Qty, MaterialPrice, Ext, 
				MaterialSize, MaterialID, MaterialPlacement,
				MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion,
				NoColorMatch, SupplierID, ComponentTypeID,
				MaterialType, MaterialNo, MaterialName,
				A, B, C, D, E, F, G, H, I, J, K, L, M,
				N, O, P, Q, R, S, T, U, V, W, X, Y, Z,
				Source, Notes, Placement,
				VendorPrice, VolumePrice, VolumePriceMinimum, VendorProductionMin, VendorProductionLeadTime,
				DetailYesNo, ImageType, height, width,
				CDate, CUser, MDate, MUser, MChange, SChange, DChange, CChange,
				Action, ColorPlacement, Artwork, License, Colorway,
				MaterialSort, MaterialTrack, MaterialLinked, MaterialDimension, 
				MaterialSizeA0, MaterialSizeA1, MaterialSizeA2, MaterialSizeA3, MaterialSizeA4, 
				MaterialSizeA5, MaterialSizeA6, MaterialSizeA7, MaterialSizeA8, MaterialSizeA9,
				MaterialSizeA10, MaterialSizeA11, MaterialSizeA12, MaterialSizeA13, MaterialSizeA14,
				MaterialSizeA15, MaterialSizeA16, MaterialSizeA17, MaterialSizeA18, MaterialSizeA19,
				MaterialSizeB0, MaterialSizeB1, MaterialSizeB2, MaterialSizeB3, MaterialSizeB4,
				MaterialSizeB5, MaterialSizeB6, MaterialSizeB7, MaterialSizeB8, MaterialSizeB9,
				MaterialSizeB10, MaterialSizeB11, MaterialSizeB12, MaterialSizeB13, MaterialSizeB14,
				MaterialSizeB15, MaterialSizeB16, MaterialSizeB17, MaterialSizeB18, MaterialSizeB19,
				MaterialLining, MaterialSizeID, MaterialColorId, MaterialPackLabelGroupID,
				TradePartnerID, TradePartnerVendorID, MaterialBOM, MaterialCode, StyleMaterialLinkID, 
				MultiCloth, MaterialCoreItemID, MaterialSwing, MaterialLinkID, MultiMaterialParentID, 
				WebPDMCustom_Category, WebPDMCustom_SubCategory, WebPDMCustom_ItemTypeCode,
				WebPDMCustom_Approved, WebPDMCustom_Content, WebPDMCustom_Finish, WebPDMCustom_Construction,
				WebPDMCustom_GroupDesc, WebPDMCustom_Dutiable, WebPDMCustom_WasteFactor,
				WebPDMCustom_UOM, WebPDMCustom_UOMPurchase, WebPDMCustom_Comments,
				AUTOCOLOR, Comments
		   FROM pSourcingQuotationBOMOptionItems WHERE StyleOptionID = @BOMOptionID
		end
       
		else -- Original BOM selected
       
		begin
			INSERT INTO pSourcingCommitmentBOMOption
			   (SourcingCommitmentBOMOptionID, SourcingCommitmentItemID,
				StyleQuoteItemID, SourcingHeaderId, SourcingStyleID,
				StyleID, styleset, 
				OptionNo, OptionStatus, OptionSystem,
				WorkFlowID, WorkFlowItemID, StyleBOMDimensionId,
				CUser, MUser, CDate, MDate, OptionName)
			SELECT @SourcingCommitmentBOMOptionID, @CommitmentId,
				StyleQuoteItemID, SourcingHeaderId, q.StyleSourcingID,
				q.StyleID, b.styleset, 
				0, 0, 0, 
				b.WorkFlowID, b.WorkFlowItemID, StyleBOMDimensionId,
				q.CUser, q.MUser, q.CDate, q.MDate, w.WorkFlowItemName
		   FROM pstylequoteitem q 
		   INNER JOIN pStyleBOMDimension b on q.styleColorid=b.StyleBOMDimensionID 
		   LEFT JOIN pWorkFlowItem w on w.WorkFlowItemID = b.WorkFlowItemID 
		   WHERE q.StyleQuoteItemID = @QuoteItemID
		   
			INSERT INTO pSourcingCommitmentBOMOptionItems
			   (SourcingCommitmentBOMOptionID, SourcingCommitmentItemID,
				StyleQuoteItemID, SourcingHeaderID, SourcingStyleID,
				StyleMaterialID, StyleMaterialMasterID, CopyStyleMaterialID,
				SubstituteForID, StyleOptionID, OptionNo, MainMaterial,
				Development, MiscColor,
				StyleSet, StyleID,
				WorkflowId, WorkflowItemId, StyleBOMDimensionId,
				Dim1TypeSel, Dim2TypeSel, Dim3TypeSel,
				UOM, Qty, MaterialPrice, Ext,
				MaterialSize, MaterialID, MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail,
				MaterialImageID, MaterialImageVersion, NoColorMatch,
				SupplierID, ComponentTypeID, MaterialType, MaterialNo, MaterialName,
				A, B, C, D, E, F, G, H, I, J, K, L, M,
				N, O, P, Q, R, S, T, U, V, W, X, Y, Z,
				Source, Notes, Placement,
				VendorPrice, VolumePrice, VolumePriceMinimum, VendorProductionMin, VendorProductionLeadTime,
				DetailYesNo, ImageType, height, width,
				CDate, CUser, MDate, MUser,
				MChange, SChange, DChange, CChange,
				Action, ColorPlacement, Artwork, License, Colorway,
				MaterialSort, MaterialTrack, MaterialLinked, MaterialDimension,
				MaterialSizeA0, MaterialSizeA1, MaterialSizeA2, MaterialSizeA3, MaterialSizeA4,
				MaterialSizeA5, MaterialSizeA6, MaterialSizeA7, MaterialSizeA8, MaterialSizeA9,
				MaterialSizeA10, MaterialSizeA11, MaterialSizeA12, MaterialSizeA13, MaterialSizeA14,
				MaterialSizeA15, MaterialSizeA16, MaterialSizeA17, MaterialSizeA18, MaterialSizeA19,
				MaterialSizeB0, MaterialSizeB1, MaterialSizeB2, MaterialSizeB3, MaterialSizeB4,
				MaterialSizeB5, MaterialSizeB6, MaterialSizeB7, MaterialSizeB8, MaterialSizeB9,
				MaterialSizeB10, MaterialSizeB11, MaterialSizeB12, MaterialSizeB13, MaterialSizeB14,
				MaterialSizeB15, MaterialSizeB16, MaterialSizeB17, MaterialSizeB18, MaterialSizeB19,
				MaterialLining, MaterialSizeID, MaterialColorId, MaterialPackLabelGroupID,
				TradePartnerID, TradePartnerVendorID, MaterialBOM, MaterialCode, StyleMaterialLinkID, 
				MultiCloth, MaterialCoreItemID, MaterialSwing, MaterialLinkID, MultiMaterialParentID,
				WebPDMCustom_Category, WebPDMCustom_SubCategory, WebPDMCustom_ItemTypeCode,
				WebPDMCustom_Approved, WebPDMCustom_Content, WebPDMCustom_Finish, WebPDMCustom_Construction,
				WebPDMCustom_GroupDesc, WebPDMCustom_Dutiable, WebPDMCustom_WasteFactor, WebPDMCustom_UOM,
				WebPDMCustom_UOMPurchase, WebPDMCustom_Comments, AUTOCOLOR, Comments)
		   SELECT @SourcingCommitmentBOMOptionID, @CommitmentId,
				StyleQuoteItemID, sqi.SourcingHeaderID, SourcingStyleID,
				StyleMaterialID, StyleMaterialMasterID, CopyStyleMaterialID,
				NULL, NULL, 0, MainMaterial,
				Development, MiscColor,
				sb.StyleSet, sb.StyleID,
				WorkflowId, WorkflowItemId, StyleBOMDimensionId,
				Dim1TypeSel, Dim2TypeSel, Dim3TypeSel,
				UOM, Qty, MaterialPrice, Ext,
				MaterialSize, MaterialID, MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail,
				MaterialImageID, MaterialImageVersion, NoColorMatch,
				SupplierID, ComponentTypeID, MaterialType, MaterialNo, MaterialName,
				A, B, C, D, E, F, G, H, I, J, K, L, M,
				N, O, P, Q, R, S, T, U, V, W, X, Y, Z,
				Source, Notes, Placement,
				VendorPrice, VolumePrice, VolumePriceMinimum, VendorProductionMin, VendorProductionLeadTime,
				DetailYesNo, ImageType, height, width,
				@MDate, @MUser, @MDate, @MUser,
				MChange, SChange, DChange, CChange,
				Action, ColorPlacement, Artwork, License, Colorway,
				MaterialSort, MaterialTrack, MaterialLinked, MaterialDimension,
				MaterialSizeA0, MaterialSizeA1, MaterialSizeA2, MaterialSizeA3, MaterialSizeA4,
				MaterialSizeA5, MaterialSizeA6, MaterialSizeA7, MaterialSizeA8, MaterialSizeA9,
				MaterialSizeA10, MaterialSizeA11, MaterialSizeA12, MaterialSizeA13, MaterialSizeA14,
				MaterialSizeA15, MaterialSizeA16, MaterialSizeA17, MaterialSizeA18, MaterialSizeA19,
				MaterialSizeB0, MaterialSizeB1, MaterialSizeB2, MaterialSizeB3, MaterialSizeB4,
				MaterialSizeB5, MaterialSizeB6, MaterialSizeB7, MaterialSizeB8, MaterialSizeB9,
				MaterialSizeB10, MaterialSizeB11, MaterialSizeB12, MaterialSizeB13, MaterialSizeB14,
				MaterialSizeB15, MaterialSizeB16, MaterialSizeB17, MaterialSizeB18, MaterialSizeB19,
				MaterialLining, MaterialSizeID, MaterialColorId, MaterialPackLabelGroupID,
				sb.TradePartnerID, sb.TradePartnerVendorID, MaterialBOM, MaterialCode, StyleMaterialLinkID, 
				MultiCloth, MaterialCoreItemID, MaterialSwing, MaterialLinkID, MultiMaterialParentID,
				WebPDMCustom_Category, WebPDMCustom_SubCategory, WebPDMCustom_ItemTypeCode,
				WebPDMCustom_Approved, WebPDMCustom_Content, WebPDMCustom_Finish, WebPDMCustom_Construction,
				WebPDMCustom_GroupDesc, WebPDMCustom_Dutiable, WebPDMCustom_WasteFactor, WebPDMCustom_UOM,
				WebPDMCustom_UOMPurchase, WebPDMCustom_Comments, AUTOCOLOR, sb.WebPDMCustom_Comments
		   FROM pStyleBOM sb 
		   INNER JOIN pStyleQuoteItem sqi ON sb.StyleBOMDimensionId = sqi.StyleColorID 
		   INNER JOIN pSourcingStyle ss ON sqi.StyleID = ss.StyleID AND ss.SourcingHeaderID = sqi.SourcingHeaderID
		   WHERE StyleQuoteItemID = @QuoteItemID
		end
	end

END




GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06678', GetDate())
GO
