IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMPending_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleBOMPending_INSERT]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleBOMPending_INSERT]    Script Date: 09/06/2011 11:46:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create   PROCEDURE [dbo].[spx_StyleBOMPending_INSERT](
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


SET NOCOUNT ON

CREATE TABLE [#tempStyleDevelopmentItem] ( 
	[RecID]						INT IDENTITY(1,1)  NOT NULL,
    [StyleDevelopmentItemID]	UNIQUEIDENTIFIER NULL,
    [StyleDevelopmentID]    	UNIQUEIDENTIFIER NULL,
    [StyleID]               	UNIQUEIDENTIFIER NULL,
    [SizeRange]             	NVARCHAR(50) NULL,
    [Variation]             	INT NULL,
    [CUser]                 	NVARCHAR(200) NULL,
    [CDate]                 	DATETIME NULL,
    [MUser]                 	NVARCHAR(200) NULL,
    [MDate]                 	DATETIME NULL,
)


CREATE TABLE #sm(
	ROWID INT IDENTITY(1,1),
	StyleMaterialID UNIQUEIDENTIFIER,
	MaterialCoreItemID UNIQUEIDENTIFIER
)

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


--Comment #02
DECLARE @NewStyleMaterialID UNIQUEIDENTIFIER


--Comment #01
BEGIN
	--Declare variables.  
	--DECLARE @MaterialID uniqueidentifier
	DECLARE @TotalCount INT
	DECLARE @RowCounter INT
	DECLARE @StyleColorID UNIQUEIDENTIFIER
END


IF @MaterialLink = 0
	--If Material is not linked then remove styleMaterialMasterId  
	BEGIN
		
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
			MaterialCoreItemID)
		SELECT @NewStyleMaterialID, '{00000000-0000-0000-0000-000000000000}', MainMaterial,MaterialLining,Development, MiscColor, StyleSet, @StyleID, UOM, Qty, MaterialPrice, Ext, 
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
		
		INSERT INTO #sm(StyleMaterialID, MaterialCoreItemID) 
		SELECT @NewStyleMaterialID, MaterialCoreItemID
		FROM  pStyleBOMTemp WITH (NOLOCK)
		WHERE StyleMaterialID = @StyleMaterialID
			AND StyleID = @StyleID
			AND StyleSet = @StyleSet
			and @WorkflowItemId=WorkflowItemId and WorkflowId=@WorkflowId

		
		--**
		--** Only 1 MainMaterial
		--**  
		IF @MainMaterial = 1 
		BEGIN
			UPDATE  pStyleBOM SET MainMaterial = 0 
			WHERE StyleID = @StyleID AND StyleSet = @StyleSet
			AND StyleMaterialID <> @NewStyleMaterialID
			and @WorkflowItemId=WorkflowItemId and WorkflowId=@WorkflowId
		END 
		
		IF @MaterialLining = 1 
		BEGIN
			UPDATE  pStyleBOM SET MaterialLining = 0 
			WHERE StyleID = @StyleID AND StyleSet = @StyleSet
			AND StyleMaterialID <> @NewStyleMaterialID
			and @WorkflowItemId=WorkflowItemId and WorkflowId=@WorkflowId
		END 
	END
ELSE
	--If Material is linked then insert material to all size class
	BEGIN
		
		DECLARE @StyleDevelopmentId UNIQUEIDENTIFIER
		DECLARE @StyleVariation INT

		SELECT @StyleDevelopmentId = StyleDevelopmentId, @StyleVariation = Variation 
		FROM pStyleDevelopmentItem WITH (NOLOCK) 
		WHERE StyleId = @StyleId

		BEGIN
			INSERT INTO #tempStyleDevelopmentItem(StyleDevelopmentItemID, StyleDevelopmentID, StyleID, SizeRange, Variation)
			SELECT StyleDevelopmentItemID, StyleDevelopmentID, StyleID, SizeRange, Variation 
			FROM pStyleDevelopmentItem WITH (NOLOCK) 
			WHERE StyleDevelopmentID = @StyleDevelopmentID AND Variation = @StyleVariation
		END

		DECLARE @StyleMaterialMasterId UNIQUEIDENTIFIER
		SET @StyleMaterialMasterId = NEWID()

		DECLARE @tmpStyleId UNIQUEIDENTIFIER

		DECLARE @Row_Count INT
		DECLARE @Row_Loop INT

		SET @Row_Loop = 1
		SET @Row_Count = (SELECT COUNT(*) FROM #tempStyleDevelopmentItem)
		
		WHILE @Row_Loop <= @Row_Count 
			BEGIN
				--Comment #02
				SET @NewStyleMaterialID = NEWID()
			
				SELECT @tmpStyleID = StyleID FROM #tempStyleDevelopmentItem WHERE RecID = @Row_Loop
				
				SELECT @MainMaterial = MainMaterial,@MaterialLining=MaterialLining,
				@ChangeAfterText = '(' + ISNULL(MaterialNo,'') + ') '  + ISNULL(MaterialName,'')
				FROM pStyleBOMTemp WITH (NOLOCK)
				WHERE  StyleMaterialID = @StyleMaterialID AND StyleID = @StyleID AND StyleSet = @StyleSet
				and @WorkflowItemId=WorkflowItemId and WorkflowId=@WorkflowId
						
				INSERT INTO dbo.pStyleBOM
					(StyleMaterialID, StyleMaterialMasterID, MainMaterial,MaterialLining, Development, MiscColor, StyleSet, StyleID, UOM, Qty, MaterialPrice, Ext, 
					MaterialSize, MaterialID, StyleBOMDimensionID, WorkflowItemId, WorkflowId,
					MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
					ComponentTypeID, MaterialType, MaterialNo, MaterialName, Source, Notes, Placement, VendorPrice, VolumePrice, VolumePriceMinimum, 
					VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, height, width, CDate, CUser, MDate, MUser, MChange, SChange, 
					DChange, CChange, Action, ColorPlacement, Artwork, License, Colorway, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z,
					MaterialLinked, MaterialTrack , MaterialPackLabelGroupID, TradePartnerID, TradePartnerVendorID, MaterialBOM , MaterialSizeID, StyleMaterialLinkID,
					--SecondaryMain, SecondaryLining, Branding, MaterialSwing, MaterialLining,  --** Custom Fields
					MaterialCoreItemID)
				SELECT @NewStyleMaterialID, @StyleMaterialMasterId AS StyleMaterialMasterID, MainMaterial,MaterialLining, Development, MiscColor, StyleSet, @tmpStyleID, UOM, Qty, MaterialPrice, Ext, 
					@MaterialSize, MaterialID, @StyleBOMDimensionID, @WorkflowItemId, @WorkflowId,
					MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
					ComponentTypeID, MaterialType, MaterialNo, MaterialName, Source, Notes, Placement, VendorPrice, VolumePrice, VolumePriceMinimum, 
					VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, height, width, 
					@CreatedDate AS CDate, @CreatedBy AS CUser, @CreatedDate AS MDate, @CreatedBy AS MUser, 
					MChange, SChange, DChange, CChange, Action, ColorPlacement, Artwork, License, Colorway, A, B, C, D, E, F, G, H, I, J, K, 
					L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, 1, 0 , MaterialPackLabelGroupID, TradePartnerID, TradePartnerVendorID, MaterialBOM, @MaterialSizeID AS MaterialSizeID, StyleMaterialLinkID,
					--SecondaryMain,  SecondaryLining, Branding, MaterialSwing, MaterialLining,  --** Custom Fields
					MaterialCoreItemID
				FROM  pStyleBOMTemp WITH (NOLOCK)
				WHERE StyleMaterialID = @StyleMaterialID
					AND StyleID = @StyleID
					AND StyleSet = @StyleSet
					and @WorkflowItemId=WorkflowItemId and WorkflowId=@WorkflowId
									
				INSERT INTO #sm(StyleMaterialID, MaterialCoreItemID) 
				SELECT @NewStyleMaterialID, MaterialCoreItemID
				FROM  pStyleBOMTemp WITH (NOLOCK)
				WHERE StyleMaterialID = @StyleMaterialID
					AND StyleID = @StyleID
					AND StyleSet = @StyleSet
					and @WorkflowItemId=WorkflowItemId and WorkflowId=@WorkflowId
				
				--**
				--** Only 1 MainMaterial
				IF @MainMaterial = 1 
				BEGIN
					UPDATE  pStyleBOM SET MainMaterial = 0 
					WHERE StyleID = @tmpStyleID AND StyleSet = @StyleSet
					AND StyleMaterialID <> @NewStyleMaterialID
					and @WorkflowItemId=WorkflowItemId and WorkflowId=@WorkflowId
				END
				
				IF @MaterialLining = 1 
				BEGIN
					UPDATE  pStyleBOM SET MaterialLining = 0 
					WHERE StyleID = @tmpStyleID AND StyleSet = @StyleSet
					AND StyleMaterialID <> @NewStyleMaterialID
					and @WorkflowItemId=WorkflowItemId and WorkflowId=@WorkflowId
				END				
				SET @Row_Loop = @Row_Loop + 1
			END
	END


--Clean Table 
DELETE FROM pStyleBOMTemp  
WHERE StyleMaterialID = @StyleMaterialID 
AND StyleID = @StyleID
AND StyleSet = @StyleSet
and @WorkflowItemId=WorkflowItemId and WorkflowId=@WorkflowId

--Drop temp table.  
DROP TABLE #tempStyleDevelopmentItem
DROP TABLE #sm
	

SET NOCOUNT OFF

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01862'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01862', GetDate())
END

GO