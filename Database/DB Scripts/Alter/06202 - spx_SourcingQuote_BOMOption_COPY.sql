IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingQuote_BOMOption_COPY]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingQuote_BOMOption_COPY]
GO

CREATE PROCEDURE [dbo].[spx_SourcingQuote_BOMOption_COPY]
	@BOMOptionID UNIQUEIDENTIFIER,
	@NewBOMOptionID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS
BEGIN
	
	DECLARE @StyleQuoteItemID UNIQUEIDENTIFIER = (SELECT StyleQuoteItemID FROM pSourcingQuotationBOMOption WHERE StyleOptionID = @BOMOptionID)
	DECLARE @OptionNo INT = (SELECT COUNT(*) FROM pSourcingQuotationBOMOption WHERE StyleQuoteItemID = @StyleQuoteItemID) + 1
	
	INSERT INTO pSourcingQuotationBOMOption (
		StyleOptionID, StyleQuoteItemID, SourcingHeaderId, SourcingStyleID, StyleID, styleset, OptionNo, OptionStatus, OptionSystem, 
		WorkFlowID, WorkFlowItemID, StyleBOMDimensionId, CUser, MUser, CDate, MDate, OptionName, XFactoryDate, OptionQuantity, 
		OptionCost)
	SELECT @NewBOMOptionID, StyleQuoteItemID, SourcingHeaderId, SourcingStyleID, StyleID, styleset, @OptionNo, OptionStatus, 
		OptionSystem, WorkFlowID, WorkFlowItemID, StyleBOMDimensionId, @CUser, @CUser, @CDate, @CDate, OptionName, XFactoryDate, 
		OptionQuantity, OptionCost
	FROM pSourcingQuotationBOMOption WHERE StyleOptionID = @BOMOptionID
	
	INSERT INTO pSourcingQuotationBOMOptionItems (
		StyleQuoteItemID, SourcingHeaderID, SourcingStyleID, StyleMaterialID, StyleMaterialMasterID, 
		CopyStyleMaterialID, SubstituteForID, StyleOptionID, OptionNo, MainMaterial, Development, MiscColor, StyleSet, StyleID, 
		WorkflowId, WorkflowItemId, StyleBOMDimensionId, Dim1TypeSel, Dim2TypeSel, Dim3TypeSel, UOM, Qty, MaterialPrice, Ext, 
		MaterialSize, MaterialID, MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, 
		MaterialImageVersion, NoColorMatch, SupplierID, ComponentTypeID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, 
		J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, Source, Notes, Placement, VendorPrice, VolumePrice, VolumePriceMinimum, 
		VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, height, width, CDate, CUser, MDate, MUser, MChange, 
		SChange, DChange, CChange, Action, ColorPlacement, Artwork, License, Colorway, MaterialSort, MaterialTrack, MaterialLinked, 
		MaterialDimension, MaterialSizeA0, MaterialSizeA1, MaterialSizeA2, MaterialSizeA3, MaterialSizeA4, MaterialSizeA5, 
		MaterialSizeA6, MaterialSizeA7, MaterialSizeA8, MaterialSizeA9, MaterialSizeA10, MaterialSizeA11, MaterialSizeA12, 
		MaterialSizeA13, MaterialSizeA14, MaterialSizeA15, MaterialSizeA16, MaterialSizeA17, MaterialSizeA18, MaterialSizeA19, 
		MaterialSizeB0, MaterialSizeB1, MaterialSizeB2, MaterialSizeB3, MaterialSizeB4, MaterialSizeB5, MaterialSizeB6, 
		MaterialSizeB7, MaterialSizeB8, MaterialSizeB9, MaterialSizeB10, MaterialSizeB11, MaterialSizeB12, MaterialSizeB13, 
		MaterialSizeB14, MaterialSizeB15, MaterialSizeB16, MaterialSizeB17, MaterialSizeB18, MaterialSizeB19, MaterialLining, 
		MaterialSizeID, MaterialColorId, MaterialPackLabelGroupID, TradePartnerID, TradePartnerVendorID, MaterialBOM, MaterialCode
		, StyleMaterialLinkID, MultiCloth, MaterialCoreItemID, MaterialSwing, MaterialLinkID, MultiMaterialParentID, 
		WebPDMCustom_Category, WebPDMCustom_SubCategory, WebPDMCustom_ItemTypeCode, WebPDMCustom_Approved, WebPDMCustom_Content, 
		WebPDMCustom_Finish, WebPDMCustom_Construction, WebPDMCustom_GroupDesc, WebPDMCustom_Dutiable, WebPDMCustom_WasteFactor, 
		WebPDMCustom_UOM, WebPDMCustom_UOMPurchase, WebPDMCustom_Comments, AUTOCOLOR, Comments)
	SELECT StyleQuoteItemID, SourcingHeaderID, SourcingStyleID, StyleMaterialID, StyleMaterialMasterID, 
		CopyStyleMaterialID, SubstituteForID, @NewBOMOptionID, @OptionNo, MainMaterial, Development, MiscColor, StyleSet, StyleID, 
		WorkflowId, WorkflowItemId, StyleBOMDimensionId, Dim1TypeSel, Dim2TypeSel, Dim3TypeSel, UOM, Qty, MaterialPrice, Ext, 
		MaterialSize, MaterialID, MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, 
		MaterialImageVersion, NoColorMatch, SupplierID, ComponentTypeID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, 
		J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, Source, Notes, Placement, VendorPrice, VolumePrice, VolumePriceMinimum, 
		VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, height, width, CDate, CUser, MDate, MUser, MChange, 
		SChange, DChange, CChange, Action, ColorPlacement, Artwork, License, Colorway, MaterialSort, MaterialTrack, MaterialLinked, 
		MaterialDimension, MaterialSizeA0, MaterialSizeA1, MaterialSizeA2, MaterialSizeA3, MaterialSizeA4, MaterialSizeA5, 
		MaterialSizeA6, MaterialSizeA7, MaterialSizeA8, MaterialSizeA9, MaterialSizeA10, MaterialSizeA11, MaterialSizeA12, 
		MaterialSizeA13, MaterialSizeA14, MaterialSizeA15, MaterialSizeA16, MaterialSizeA17, MaterialSizeA18, MaterialSizeA19, 
		MaterialSizeB0, MaterialSizeB1, MaterialSizeB2, MaterialSizeB3, MaterialSizeB4, MaterialSizeB5, MaterialSizeB6, 
		MaterialSizeB7, MaterialSizeB8, MaterialSizeB9, MaterialSizeB10, MaterialSizeB11, MaterialSizeB12, MaterialSizeB13, 
		MaterialSizeB14, MaterialSizeB15, MaterialSizeB16, MaterialSizeB17, MaterialSizeB18, MaterialSizeB19, MaterialLining, 
		MaterialSizeID, MaterialColorId, MaterialPackLabelGroupID, TradePartnerID, TradePartnerVendorID, MaterialBOM, MaterialCode
		, StyleMaterialLinkID, MultiCloth, MaterialCoreItemID, MaterialSwing, MaterialLinkID, MultiMaterialParentID, 
		WebPDMCustom_Category, WebPDMCustom_SubCategory, WebPDMCustom_ItemTypeCode, WebPDMCustom_Approved, WebPDMCustom_Content, 
		WebPDMCustom_Finish, WebPDMCustom_Construction, WebPDMCustom_GroupDesc, WebPDMCustom_Dutiable, WebPDMCustom_WasteFactor, 
		WebPDMCustom_UOM, WebPDMCustom_UOMPurchase, WebPDMCustom_Comments, AUTOCOLOR, Comments
	FROM pSourcingQuotationBOMOptionItems WHERE StyleOptionID = @BOMOptionID	
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06202', GetDate())
GO
