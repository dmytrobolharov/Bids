IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMPending_INSERTQE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMPending_INSERTQE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
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


SELECT 	
	@MaterialSizeID = MaterialSizeID,
	@MaterialID = MaterialID
FROM pStyleBOMTemp WITH (NOLOCK)
WHERE StyleMaterialId = @StyleMaterialID


IF @MaterialSizeID IS NOT NULL 
BEGIN 
	SELECT @MaterialSize = MaterialSize FROM pMaterialSize WITH (NOLOCK) WHERE MaterialSizeID = @MaterialSizeID
END 

		
INSERT INTO pStyleBOM
	(StyleMaterialMasterID, MainMaterial,MaterialLining, Development, MiscColor, StyleSet, StyleID, UOM, Qty, MaterialPrice, Ext, 
	MaterialSize, MaterialID, StyleBOMDimensionID, WorkflowItemId, WorkflowId,
	MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
	ComponentTypeID, MaterialType, MaterialNo, MaterialName, Source, Notes, Placement, VendorPrice, VolumePrice, VolumePriceMinimum, 
	VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, height, width, CDate, CUser, MDate, MUser, MChange, SChange, 
	DChange, CChange, Action, ColorPlacement, Artwork, License, Colorway, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, 
	MaterialLinked, MaterialTrack, TradePartnerID, TradePartnerVendorID, MaterialBOM , MaterialSizeID, StyleMaterialLinkID,			
	MaterialCoreItemID)
SELECT '00000000-0000-0000-0000-000000000000' as StyleMaterialMasterID, MainMaterial,MaterialLining,Development, MiscColor, @StyleSet, @StyleID, UOM, Qty, MaterialPrice, Ext, 
	@MaterialSize, MaterialID, @StyleBOMDimensionID, @WorkflowItemId, @WorkflowId, 
	MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
	ComponentTypeID, MaterialType, MaterialNo, MaterialName, Source, Notes, Placement, VendorPrice, VolumePrice, VolumePriceMinimum, 
	VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, height, width, 
	@CreatedDate AS CDate, @CreatedBy AS CUser, @CreatedDate AS MDate, @CreatedBy AS MUser, 
	MChange, SChange, DChange, CChange, Action, ColorPlacement, Artwork, License, Colorway, A, B, C, D, E, F, G, H, I, J, K, 
	L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, 0, 0, TradePartnerID, TradePartnerVendorID, MaterialBOM , @MaterialSizeID AS MaterialSizeID, StyleMaterialLinkID, 			
	MaterialCoreItemID
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




GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03094'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03094', GetDate())

END

GO