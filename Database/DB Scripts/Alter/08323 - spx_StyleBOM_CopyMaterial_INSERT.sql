IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOM_CopyMaterial_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOM_CopyMaterial_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleBOM_CopyMaterial_INSERT](
	@StyleMaterialID UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@WorkflowItemId UNIQUEIDENTIFIER,
	@WorkflowId UNIQUEIDENTIFIER,
	@CopyStyleID UNIQUEIDENTIFIER,
	@CopyStyleSet INT,
	@CopyWorkflowItemId UNIQUEIDENTIFIER,
	@CopyWorkflowId UNIQUEIDENTIFIER,
	@StyleBOMDimensionID UNIQUEIDENTIFIER,
	@CreatedDate DATETIME,
	@CreatedBy NVARCHAR(200)
)
AS 


BEGIN 

	DECLARE @NewStyleMaterialID UNIQUEIDENTIFIER
	SET @NewStyleMaterialID = NEWID()
	
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
		MaterialCoreItemID, Dim1TypeSel, Dim2TypeSel, Dim3TypeSel)
	SELECT @NewStyleMaterialID, '{00000000-0000-0000-0000-000000000000}', MainMaterial, MaterialLining, Development, MiscColor, StyleSet, @StyleID, UOM, Qty, VolumePrice, Ext, 
		MaterialSize, MaterialID, @StyleBOMDimensionID, @WorkflowItemId, @WorkflowId, 
		MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
		ComponentTypeID, MaterialType, MaterialNo, MaterialName, Source, Notes, Placement, VendorPrice, VolumePrice, VolumePriceMinimum, 
		VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, height, width, 
		@CreatedDate AS CDate, @CreatedBy AS CUser, @CreatedDate AS MDate, @CreatedBy AS MUser, 
		MChange, SChange, DChange, CChange, Action, ColorPlacement, Artwork, License, Colorway, A, B, C, D, E, F, G, H, I, J, K, 
		L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, 0, MaterialTrack, TradePartnerID, TradePartnerVendorID, TradePartnerRelationshipLevelID, MaterialBOM , MaterialSizeID, StyleMaterialLinkID, 			
		MaterialCoreItemID, @Dim1TypeSel, @Dim2TypeSel, @Dim3TypeSel
	FROM  pStyleBOM WITH (NOLOCK)
	WHERE StyleMaterialID = @StyleMaterialID
		AND StyleID = @CopyStyleID
		AND StyleSet = @CopyStyleSet
		and @CopyWorkflowItemId=WorkflowItemId and WorkflowId=@CopyWorkflowId		
END 


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08323', GetDate())
GO
