IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDimBOMQuickAddPending_INSERTQE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleDimBOMQuickAddPending_INSERTQE]
GO



CREATE PROCEDURE [dbo].[spx_StyleDimBOMQuickAddPending_INSERTQE](
	@StyleMaterialID UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@WorkflowItemId UNIQUEIDENTIFIER,
	@WorkflowId UNIQUEIDENTIFIER,
	@StyleBOMDimensionID UNIQUEIDENTIFIER,
	@StyleLink NVARCHAR(2),
	@CreatedDate DATETIME,
	@CreatedBy NVARCHAR(200),
	@NewMaterialID UNIQUEIDENTIFIER = NULL OUTPUT,
	@NewStyleMaterialID UNIQUEIDENTIFIER = NULL OUTPUT
)

AS 

DECLARE @MaterialID  UNIQUEIDENTIFIER 
DECLARE @MaterialSizeID  UNIQUEIDENTIFIER 
DECLARE @MaterialSize NVARCHAR(200)

DECLARE @INSERTED TABLE (StyleMaterialID UNIQUEIDENTIFIER,
							MaterialID UNIQUEIDENTIFIER) -- is used for change management
							
-- For added material selecting dimensions, which are selected in BOM header
DECLARE @Dim1TypeSel INT = 0
DECLARE @Dim2TypeSel INT = 0
DECLARE @Dim3TypeSel INT = 0

SELECT @Dim1TypeSel = CASE WHEN ItemDim1TypeId = '00000000-0000-0000-0000-000000000000' THEN 0 ELSE 1 END, 
		@Dim2TypeSel = CASE WHEN ItemDim2TypeId = '00000000-0000-0000-0000-000000000000' THEN 0 ELSE 1 END, 
		@Dim3TypeSel = CASE WHEN ItemDim3TypeId  = '00000000-0000-0000-0000-000000000000' THEN 0 ELSE 1 END
FROM pStyleBOMDimension WHERE StyleBOMDimensionID = @StyleBOMDimensionID


If @StyleLink='1'
	begin
		set @MaterialID=NEWID()	
		select @MaterialID as Material	
		INSERT INTO pMaterial
		(UOM, MaterialID, MaterialPlacement, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
		MaterialType, MaterialNo, MaterialName, Source, Notes,  VendorPrice, VolumePrice, VolumePriceMinimum, 
		VendorProductionMin, VendorProductionLeadTime, DetailYesNo,  height, width, CDate, CUser, MDate, MUser, MChange,  
		DChange, Action,  A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, 
		TradePartnerID, TradePartnerVendorID)
		SELECT UOM,  @MaterialID,
		MaterialPlacement,  MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
		MaterialType, MaterialNo, MaterialName, Source, Notes, COALESCE(VendorPrice,'0'), COALESCE(VolumePrice,'0'), VolumePriceMinimum, 
		VendorProductionMin, VendorProductionLeadTime, DetailYesNo,  height, width, 
		@CreatedDate AS CDate, @CreatedBy AS CUser, @CreatedDate AS MDate, @CreatedBy AS MUser, 
		COALESCE(MChange,'0'), DChange, Action,  A, B, C, D, E, F, G, H, I, J, K, 
		L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, TradePartnerID, TradePartnerVendorID	 
		FROM  pStyleBOMTemp WITH (NOLOCK) WHERE StyleMaterialID = @StyleMaterialID
		AND StyleID = @StyleID AND StyleSet = @StyleSet
		AND WorkflowItemId=@WorkflowItemId and WorkflowId=@WorkflowId
		AND StyleBOMDimensionID=@StyleBOMDimensionID and QuickAdd=2
			
		INSERT INTO pStyleBOM
		(StyleMaterialMasterID, MainMaterial,MaterialLining, Development, MiscColor, StyleSet, StyleID, UOM, Qty, MaterialPrice, Ext, 
		MaterialSize, MaterialID, StyleBOMDimensionID, WorkflowItemId, WorkflowId,
		MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
		ComponentTypeID, MaterialType, MaterialNo, MaterialName, Source, Notes, Placement, VendorPrice, VolumePrice, VolumePriceMinimum, 
		VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, height, width, CDate, CUser, MDate, MUser, MChange, SChange, 
		DChange, CChange, Action, ColorPlacement, Artwork, License, Colorway, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, 
		MaterialLinked, MaterialTrack, TradePartnerID, TradePartnerVendorID, MaterialBOM , MaterialSizeID, StyleMaterialLinkID,			
		MaterialCoreItemID, Dim1TypeSel, Dim2TypeSel, Dim3TypeSel, MaterialSort)
		OUTPUT INSERTED.StyleMaterialID, INSERTED.MaterialID INTO @INSERTED
		SELECT '00000000-0000-0000-0000-000000000000' as StyleMaterialMasterID, MainMaterial,MaterialLining,Development, MiscColor, @StyleSet, @StyleID, UOM, Qty, MaterialPrice, Ext, 
		MaterialSize, @MaterialID, @StyleBOMDimensionID, @WorkflowItemId, @WorkflowId, 
		MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
		ComponentTypeID, MaterialType, MaterialNo, MaterialName, Source, Notes, Placement, COALESCE(VendorPrice,'0'), COALESCE(VolumePrice,'0'), VolumePriceMinimum, 
		VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, height, width, 
		@CreatedDate AS CDate, @CreatedBy AS CUser, @CreatedDate AS MDate, @CreatedBy AS MUser, 
		COALESCE(MChange,'0'), SChange, DChange, CChange, Action, ColorPlacement, Artwork, License, Colorway, A, B, C, D, E, F, G, H, I, J, K, 
		L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, 0, 0, TradePartnerID, TradePartnerVendorID, MaterialBOM ,  MaterialSizeID, StyleMaterialLinkID, 			
		MaterialCoreItemID, @Dim1TypeSel, @Dim2TypeSel, @Dim3TypeSel, MaterialSort
		FROM  pStyleBOMTemp WITH (NOLOCK)
		WHERE StyleMaterialID = @StyleMaterialID AND StyleID = @StyleID	AND StyleSet = @StyleSet
		AND WorkflowItemId=@WorkflowItemId AND WorkflowId=@WorkflowId AND StyleBOMDimensionID=@StyleBOMDimensionID AND QuickAdd=2
		
		--select * from pmaterial where Materialid=@MaterialID
		--select * from pStyleBOMTemp where styleMaterialid=@styleMaterialid
		--select * from pStyleBOM where styleMaterialid=@styleMaterialid and Materialid=@MaterialID
		
		DELETE FROM pStyleBOMTemp WHERE StyleMaterialID = @StyleMaterialID AND StyleID = @StyleID AND StyleSet = @StyleSet
		and WorkflowItemId=@WorkflowItemId and WorkflowId=@WorkflowId and  StyleBOMDimensionID=@StyleBOMDimensionID 
		and QuickAdd=2
		
		SELECT @NewStyleMaterialID = StyleMaterialID FROM @INSERTED

		INSERT INTO pStyleBOMItem (StyleBOMDimensionId, StyleBOMDimensionItemId, StyleMaterialID, WorkflowID, WorkflowItemID, StyleID, StyleSet
			, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim1ID, ItemDim1Name, ItemDim2ID, ItemDim2Name, ItemDim3ID, ItemDim3Name, CDate, CUser, MDate, MUser)		
		SELECT @StyleBOMDimensionId, StyleBOMDimensionItemId, @NewStyleMaterialID, @WorkflowID, @WorkflowItemID, @StyleID, @StyleSet,
			ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim1Id, ItemDim1Name, ItemDim2Id, ItemDim2Name, ItemDim3Id, ItemDim3Name, @CreatedDate, @CreatedBy, @CreatedDate, @CreatedBy 
		FROM pStyleBOMDimensionItems
		WHERE StyleBOMDimensionId=@StyleBOMDimensionId AND StyleBOMDimensionItemId NOT IN
			(SELECT StyleBOMDimensionItemId FROM pstylebomitem WHERE StyleMaterialID=@NewStyleMaterialID AND StyleBOMDimensionId=@StyleBOMDimensionId)
		
			
	end 	
else
	begin		
		INSERT INTO pStyleBOM
		(StyleMaterialMasterID, MainMaterial,MaterialLining, Development, MiscColor, StyleSet, StyleID, UOM, Qty, MaterialPrice, Ext, 
		MaterialSize, MaterialID, StyleBOMDimensionID, WorkflowItemId, WorkflowId,
		MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
		ComponentTypeID, MaterialType, MaterialNo, MaterialName, Source, Notes, Placement, VendorPrice, VolumePrice, VolumePriceMinimum, 
		VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, height, width, CDate, CUser, MDate, MUser, MChange, SChange, 
		DChange, CChange, Action, ColorPlacement, Artwork, License, Colorway, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, 
		MaterialLinked, MaterialTrack, TradePartnerID, TradePartnerVendorID, MaterialBOM , MaterialSizeID, StyleMaterialLinkID,			
		MaterialCoreItemID, Dim1TypeSel, Dim2TypeSel, Dim3TypeSel, MaterialSort)
		OUTPUT INSERTED.StyleMaterialID, INSERTED.MaterialID INTO @INSERTED
		SELECT '00000000-0000-0000-0000-000000000000' as StyleMaterialMasterID, MainMaterial,MaterialLining,Development, MiscColor, @StyleSet, @StyleID, UOM, Qty, MaterialPrice, Ext, 
		MaterialSize, '00000000-0000-0000-0000-000000000000' as MaterialID, @StyleBOMDimensionID, @WorkflowItemId, @WorkflowId, 
		MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
		ComponentTypeID, MaterialType, MaterialNo, MaterialName, Source, Notes, Placement, COALESCE(VendorPrice,'0'), COALESCE(VolumePrice,'0'), VolumePriceMinimum, 
		VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, height, width, 
		@CreatedDate AS CDate, @CreatedBy AS CUser, @CreatedDate AS MDate, @CreatedBy AS MUser, 
		COALESCE(MChange,'0'), SChange, DChange, CChange, Action, ColorPlacement, Artwork, License, Colorway, A, B, C, D, E, F, G, H, I, J, K, 
		L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, 0, 0, TradePartnerID, TradePartnerVendorID, MaterialBOM ,  MaterialSizeID, StyleMaterialLinkID, 			
		MaterialCoreItemID, @Dim1TypeSel, @Dim2TypeSel, @Dim3TypeSel, MaterialSort
		FROM  pStyleBOMTemp WITH (NOLOCK)
		WHERE StyleMaterialID = @StyleMaterialID AND StyleID = @StyleID	AND StyleSet = @StyleSet
		AND WorkflowItemId=@WorkflowItemId AND WorkflowId=@WorkflowId AND StyleBOMDimensionID=@StyleBOMDimensionID AND QuickAdd=2
		
		DELETE FROM pStyleBOMTemp WHERE StyleMaterialID = @StyleMaterialID AND StyleID = @StyleID AND StyleSet = @StyleSet
		AND WorkflowItemId=@WorkflowItemId AND WorkflowId=@WorkflowId AND  StyleBOMDimensionID=@StyleBOMDimensionID 
		AND QuickAdd=2
		
		SELECT @NewStyleMaterialID = StyleMaterialID FROM @INSERTED
		
		INSERT INTO pStyleBOMItem (StyleBOMDimensionId, StyleBOMDimensionItemId, StyleMaterialID, WorkflowID, WorkflowItemID, StyleID, StyleSet
			, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim1ID, ItemDim1Name, ItemDim2ID, ItemDim2Name, ItemDim3ID, ItemDim3Name, CDate, CUser, MDate, MUser)		
		SELECT @StyleBOMDimensionId, StyleBOMDimensionItemId, @NewStyleMaterialID, @WorkflowID, @WorkflowItemID, @StyleID, @StyleSet,
			ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim1Id, ItemDim1Name, ItemDim2Id, ItemDim2Name, ItemDim3Id, ItemDim3Name, @CreatedDate, @CreatedBy, @CreatedDate, @CreatedBy 
		FROM pStyleBOMDimensionItems
		WHERE StyleBOMDimensionId=@StyleBOMDimensionId AND StyleBOMDimensionItemId NOT IN
			(SELECT StyleBOMDimensionItemId FROM pstylebomitem WHERE StyleMaterialID=@NewStyleMaterialID AND StyleBOMDimensionId=@StyleBOMDimensionId)
					
	end

SELECT @NewMaterialID = MaterialID, @NewStyleMaterialID = StyleMaterialID FROM @INSERTED

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07565', GetDate())
GO
