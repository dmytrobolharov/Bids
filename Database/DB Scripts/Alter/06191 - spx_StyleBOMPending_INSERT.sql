IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMPending_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMPending_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_StyleBOMPending_INSERT](
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


BEGIN TRY
	BEGIN TRANSACTION

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
					MaterialLinked, MaterialTrack, TradePartnerID, TradePartnerVendorID, MaterialBOM , MaterialSizeID, StyleMaterialLinkID,			
					MaterialCoreItemID, Dim1TypeSel, Dim2TypeSel, Dim3TypeSel)
				SELECT @NewStyleMaterialID, '{00000000-0000-0000-0000-000000000000}', MainMaterial,MaterialLining,Development, MiscColor, StyleSet, @StyleID, UOM, Qty, VolumePrice, Ext, 
					@MaterialSize, MaterialID, @StyleBOMDimensionID, @WorkflowItemId, @WorkflowId, 
					MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
					ComponentTypeID, MaterialType, MaterialNo, MaterialName, Source, Notes, Placement, VendorPrice, VolumePrice, VolumePriceMinimum, 
					VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, height, width, 
					@CreatedDate AS CDate, @CreatedBy AS CUser, @CreatedDate AS MDate, @CreatedBy AS MUser, 
					MChange, SChange, DChange, CChange, Action, ColorPlacement, Artwork, License, Colorway, A, B, C, D, E, F, G, H, I, J, K, 
					L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, 0, MaterialTrack, TradePartnerID, TradePartnerVendorID, MaterialBOM , @MaterialSizeID AS MaterialSizeID, StyleMaterialLinkID, 			
					MaterialCoreItemID, @Dim1TypeSel, @Dim2TypeSel, @Dim3TypeSel
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

COMMIT TRANSACTION
	select 1 as Success
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	select 0 as Success
END CATCH



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06191', GetDate())
GO
