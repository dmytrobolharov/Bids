/****** Object:  StoredProcedure [dbo].[spx_StyleBOMPending_INSERT]    Script Date: 04/09/2013 11:33:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMPending_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMPending_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleBOMPending_INSERT]    Script Date: 04/09/2013 11:33:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE  PROCEDURE [dbo].[spx_StyleBOMPending_INSERT](
	@StyleMaterialID UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@WorkflowItemId UNIQUEIDENTIFIER,
	@WorkflowId UNIQUEIDENTIFIER,
	@StyleBOMDimensionID UNIQUEIDENTIFIER,
	@CreatedDate DATETIME,
	@CreatedBy NVARCHAR(200),
	@NewStyleMaterialID UNIQUEIDENTIFIER = NULL OUTPUT
)
AS 


SET NOCOUNT ON

DECLARE @ChangeLogID UNIQUEIDENTIFIER
DECLARE @ChangeAfterText NVARCHAR(400)

DECLARE @MaterialLink INT, @Colorway INT
DECLARE @MainMaterial INT
DECLARE @MaterialLining INT 
DECLARE @MaterialID  UNIQUEIDENTIFIER 
DECLARE @MaterialSizeID  UNIQUEIDENTIFIER 
DECLARE @MaterialSize NVARCHAR(200)


SELECT 
	@MaterialLink = MaterialLinked,
	@Colorway = Colorway,
	@MaterialSizeID = MaterialSizeID,
	@MaterialID = MaterialID
FROM pStyleBOMTemp WITH (NOLOCK)
WHERE StyleMaterialId = @StyleMaterialID


IF @MaterialSizeID IS NOT NULL 
BEGIN 
	SELECT @MaterialSize = MaterialSize FROM pMaterialSize WITH (NOLOCK) WHERE MaterialSizeID = @MaterialSizeID
END 

--Comment #01
BEGIN
	--Declare variables.
	DECLARE @TotalCount INT
	DECLARE @RowCounter INT
	DECLARE @StyleColorID UNIQUEIDENTIFIER
END

		--Comment #02
		SET @NewStyleMaterialID = NEWID()
		
		SELECT @MainMaterial = MainMaterial,@MaterialLining=MaterialLining,
		@ChangeAfterText = '(' + ISNULL(MaterialNo,'') + ') '  + ISNULL(MaterialName,'')
		FROM pStyleBOMTemp WITH (NOLOCK) 
		WHERE  StyleMaterialID = @StyleMaterialID AND StyleID = @StyleID AND StyleSet = @StyleSet
		and @WorkflowItemId=WorkflowItemId and WorkflowId=@WorkflowId
		
		INSERT INTO pStyleBOM
			(StyleMaterialID, StyleMaterialMasterID, MainMaterial,MaterialLining, Development, MiscColor, StyleSet, StyleID, UOM, Qty, MaterialPrice, Ext, 
			MaterialSize, MaterialID, StyleBOMDimensionID, WorkflowItemId, WorkflowId,
			MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
			ComponentTypeID, MaterialType, MaterialNo, MaterialName, Source, Notes, Placement, VendorPrice, VolumePrice, VolumePriceMinimum, 
			VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, height, width, CDate, CUser, MDate, MUser, MChange, SChange, 
			DChange, CChange, Action, ColorPlacement, Artwork, License, Colorway, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, 
			MaterialLinked, MaterialTrack, TradePartnerID, TradePartnerVendorID, MaterialBOM , MaterialSizeID, StyleMaterialLinkID,			
			MaterialCoreItemID, Dim1TypeSel, Dim2TypeSel, Dim3TypeSel)
		SELECT @NewStyleMaterialID, '{00000000-0000-0000-0000-000000000000}', MainMaterial,MaterialLining,Development, MiscColor, StyleSet, @StyleID, UOM, Qty, VolumePrice, Ext, 
			@MaterialSize, MaterialID, @StyleBOMDimensionID, @WorkflowItemId, @WorkflowId, 
			MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
			ComponentTypeID, MaterialType, MaterialNo, MaterialName, Source, Notes, Placement, VendorPrice, VolumePrice, VolumePriceMinimum, 
			VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, height, width, 
			@CreatedDate AS CDate, @CreatedBy AS CUser, @CreatedDate AS MDate, @CreatedBy AS MUser, 
			MChange, SChange, DChange, CChange, Action, ColorPlacement, Artwork, License, Colorway, A, B, C, D, E, F, G, H, I, J, K, 
			L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, 0, 0, TradePartnerID, TradePartnerVendorID, MaterialBOM , @MaterialSizeID AS MaterialSizeID, StyleMaterialLinkID, 			
			MaterialCoreItemID, 1, 1, 1
		FROM  pStyleBOMTemp WITH (NOLOCK)
		WHERE StyleMaterialID = @StyleMaterialID
			AND StyleID = @StyleID
			AND StyleSet = @StyleSet
			and @WorkflowItemId=WorkflowItemId and WorkflowId=@WorkflowId
		
		IF @MaterialLining = 1 
		BEGIN
			UPDATE  pStyleBOM SET MaterialLining = 0 
			WHERE StyleID = @StyleID AND StyleSet = @StyleSet
			AND StyleMaterialID <> @NewStyleMaterialID
			and @WorkflowItemId=WorkflowItemId and WorkflowId=@WorkflowId
		END 

--Clean Table 
DELETE FROM pStyleBOMTemp  
WHERE StyleMaterialID = @StyleMaterialID 
AND StyleID = @StyleID
AND StyleSet = @StyleSet
and @WorkflowItemId=WorkflowItemId and WorkflowId=@WorkflowId

--Drop temp table.  
--DROP TABLE #tempStyleDevelopmentItem
--DROP TABLE #sm
	

SET NOCOUNT OFF



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES	('DB_Version', '0.5.0000', '05511', GetDate())
GO
