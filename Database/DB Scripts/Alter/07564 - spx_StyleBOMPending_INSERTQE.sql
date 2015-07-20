IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMPending_INSERTQE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMPending_INSERTQE]
GO



CREATE PROCEDURE [dbo].[spx_StyleBOMPending_INSERTQE](
	@StyleMaterialID UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@WorkflowItemId UNIQUEIDENTIFIER,
	@WorkflowId UNIQUEIDENTIFIER,
	@StyleBOMDimensionID UNIQUEIDENTIFIER,
	@CreatedDate DATETIME,
	@CreatedBy NVARCHAR(200)	
)
AS 

DECLARE @MaterialID  UNIQUEIDENTIFIER 
DECLARE @MaterialSizeID  UNIQUEIDENTIFIER 
DECLARE @MaterialSize NVARCHAR(200)

DECLARE @NewStyleMaterialID UNIQUEIDENTIFIER = NEWID()

SELECT 	
	@MaterialSizeID = MaterialSizeID,
	@MaterialID = MaterialID
FROM pStyleBOMTemp WITH (NOLOCK)
WHERE StyleMaterialId = @StyleMaterialID


IF @MaterialSizeID IS NOT NULL 
BEGIN 
	SELECT @MaterialSize = MaterialSize FROM pMaterialSize WITH (NOLOCK) WHERE MaterialSizeID = @MaterialSizeID
END 


-- For added material selecting dimensions, which are selected in BOM header
DECLARE @Dim1TypeSel INT = 0
DECLARE @Dim2TypeSel INT = 0
DECLARE @Dim3TypeSel INT = 0

SELECT @Dim1TypeSel = CASE WHEN ItemDim1TypeId = '00000000-0000-0000-0000-000000000000' THEN 0 ELSE 1 END, 
		@Dim2TypeSel = CASE WHEN ItemDim2TypeId = '00000000-0000-0000-0000-000000000000' THEN 0 ELSE 1 END, 
		@Dim3TypeSel = CASE WHEN ItemDim3TypeId  = '00000000-0000-0000-0000-000000000000' THEN 0 ELSE 1 END
FROM pStyleBOMDimension WHERE StyleBOMDimensionID = @StyleBOMDimensionID

		
INSERT INTO pStyleBOM
	(StyleMaterialID, StyleMaterialMasterID, MainMaterial,MaterialLining, Development, MiscColor, StyleSet, StyleID, UOM, Qty, MaterialPrice, Ext, 
	MaterialSize, MaterialID, StyleBOMDimensionID, WorkflowItemId, WorkflowId,
	MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
	ComponentTypeID, MaterialType, MaterialNo, MaterialName, Source, Notes, Placement, VendorPrice, VolumePrice, VolumePriceMinimum, 
	VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, height, width, CDate, CUser, MDate, MUser, MChange, SChange, 
	DChange, CChange, Action, ColorPlacement, Artwork, License, Colorway, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, 
	MaterialLinked, MaterialTrack, TradePartnerID, TradePartnerVendorID, TradePartnerRelationshipLevelID, MaterialBOM , MaterialSizeID, StyleMaterialLinkID,			
	MaterialCoreItemID, Dim1TypeSel, Dim2TypeSel, Dim3TypeSel, MaterialSort)
SELECT @NewStyleMaterialID, '00000000-0000-0000-0000-000000000000' as StyleMaterialMasterID, MainMaterial,MaterialLining,Development, MiscColor, @StyleSet, @StyleID, UOM, Qty, VolumePrice, Ext, 
	@MaterialSize, MaterialID, @StyleBOMDimensionID, @WorkflowItemId, @WorkflowId, 
	MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
	ComponentTypeID, MaterialType, MaterialNo, MaterialName, Source, Notes, Placement, VendorPrice, VolumePrice, VolumePriceMinimum, 
	VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, height, width, 
	@CreatedDate AS CDate, @CreatedBy AS CUser, @CreatedDate AS MDate, @CreatedBy AS MUser, 
	MChange, SChange, DChange, CChange, Action, ColorPlacement, Artwork, License, Colorway, A, B, C, D, E, F, G, H, I, J, K, 
	L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, 0, MaterialTrack, TradePartnerID, TradePartnerVendorID, TradePartnerRelationshipLevelID, MaterialBOM , @MaterialSizeID AS MaterialSizeID, StyleMaterialLinkID, 			
	MaterialCoreItemID, @Dim1TypeSel, @Dim2TypeSel, @Dim3TypeSel, MaterialSort
FROM  pStyleBOMTemp WITH (NOLOCK)
WHERE StyleMaterialID = @StyleMaterialID
	AND StyleID = @StyleID
	AND StyleSet = @StyleSet
	and @WorkflowItemId=WorkflowItemId and WorkflowId=@WorkflowId
	and  StyleBOMDimensionID=@StyleBOMDimensionID and QuickAdd=1
	

DELETE FROM pStyleBOMTemp  
WHERE StyleMaterialID = @StyleMaterialID 
AND StyleID = @StyleID
AND StyleSet = @StyleSet
and @WorkflowItemId=WorkflowItemId and WorkflowId=@WorkflowId and  StyleBOMDimensionID=@StyleBOMDimensionID and QuickAdd=1


INSERT INTO pStyleBOMItem (StyleBOMDimensionId, StyleBOMDimensionItemId, StyleMaterialID, WorkflowID, WorkflowItemID, StyleID, StyleSet
	, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim1ID, ItemDim1Name, ItemDim2ID, ItemDim2Name, ItemDim3ID, ItemDim3Name, CDate, CUser, MDate, MUser)		
SELECT @StyleBOMDimensionId, StyleBOMDimensionItemId, @NewStyleMaterialID, @WorkflowID, @WorkflowItemID, @StyleID, @StyleSet,
	ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim1Id, ItemDim1Name, ItemDim2Id, ItemDim2Name, ItemDim3Id, ItemDim3Name, @CreatedDate, @CreatedBy, @CreatedDate, @CreatedBy 
FROM pStyleBOMDimensionItems
WHERE StyleBOMDimensionId=@StyleBOMDimensionId AND StyleBOMDimensionItemId NOT IN
	(SELECT StyleBOMDimensionItemId FROM pstylebomitem WHERE StyleMaterialID=@NewStyleMaterialID AND StyleBOMDimensionId=@StyleBOMDimensionId)


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07564', GetDate())
GO
