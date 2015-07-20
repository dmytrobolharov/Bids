IF EXISTS (select * from sysobjects where id = object_id('spx_StyleMaterialPending_INSERT') and sysstat & 0xf = 4)
    drop procedure spx_StyleMaterialPending_INSERT
GO

/*
Comments:

#01 - Ryan Cabanas - 2/12/2009
	Added functionality to the procedure so that when a Material is added to the Style, if the 'Colorway' box is checked, a record is added
to the 'pStyleColorwayItem' table for each colorway found in 'pStyleColorway'.  If the Material added is linked, add the same for each
Size Class in the Style.

#02 - Ryan Cabanas - 2/16/2009
	Need to create a new StyleMaterialID for each Material so that the Colorway Item INSERT can use this ID, as well.
	
#03 - Daniel Pak - 2/14/2010
	Added fielld StyleMaterialLinkID on pStyleMaterials to link styles and batch update on linked IDs	
*/


CREATE  PROCEDURE [dbo].[spx_StyleMaterialPending_INSERT]
(
@StyleMaterialID uniqueidentifier,
@StyleID uniqueidentifier,
@StyleSet int,
@CreatedDate datetime,
@CreatedBy nvarchar(200)
)
AS 


SET NOCOUNT ON

CREATE TABLE [#tempStyleDevelopmentItem] ( 
	[RecID]						int IDENTITY(1,1)  NOT NULL,
    [StyleDevelopmentItemID]	uniqueidentifier NULL,
    [StyleDevelopmentID]    	uniqueidentifier NULL,
    [StyleID]               	uniqueidentifier NULL,
    [SizeRange]             	nvarchar(50) NULL,
    [Variation]             	int NULL,
    [CUser]                 	nvarchar(200) NULL,
    [CDate]                 	datetime NULL,
    [MUser]                 	nvarchar(200) NULL,
    [MDate]                 	datetime NULL,
)

DECLARE @MaterialLink int, @Colorway int
DECLARE @MainMaterial INT 
DECLARE @MaterialID  UNIQUEIDENTIFIER 
DECLARE @MaterialSizeID  UNIQUEIDENTIFIER 
DECLARE @MaterialSize NVARCHAR(200)
DECLARE @MaterialNo NVARCHAR(200)


SELECT 
@MaterialLink = MaterialLinked,
@Colorway = Colorway,
@MaterialSizeID = MaterialSizeID,
@MaterialID = MaterialID
FROM pStyleMaterialTemp 
WHERE StyleMaterialId = @StyleMaterialID


IF @MaterialSizeID IS NOT NULL 
BEGIN 
	SELECT @MaterialSize = MaterialSize FROM pMaterialSize WHERE MaterialSizeID = @MaterialSizeID
END 


--Comment #02
DECLARE @NewStyleMaterialID uniqueidentifier


--Comment #01
BEGIN
	/*Declare variables.*/
	--DECLARE @MaterialID uniqueidentifier
	DECLARE @TotalCount int
	DECLARE @RowCounter int
	DECLARE @StyleColorID uniqueidentifier

/*
	/*Get some additional variable values.*/
	SELECT @MaterialID = MaterialID
	FROM pStyleMaterialTemp 
	WHERE StyleMaterialId = @StyleMaterialID
*/
END


IF @MaterialLink = 0
	--If Material is not linked then remove styleMaterialMasterId  
	BEGIN
		--Comment #02
		SET @NewStyleMaterialID = NEWID()
		
		
		SELECT @MainMaterial = MainMaterial FROM pStyleMaterialTemp WHERE  StyleMaterialID = @StyleMaterialID AND StyleID = @StyleID AND StyleSet = @StyleSet

		INSERT INTO pStyleMaterials
			(StyleMaterialID, StyleMaterialMasterID, MainMaterial, Development, MiscColor, StyleSet, StyleID, UOM, Qty, MaterialPrice, Ext, 
			MaterialSize, MaterialID, 
			MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
			ComponentTypeID, MaterialType, MaterialNo, MaterialName, Source, Notes, Placement, VendorPrice, VolumePrice, VolumePriceMinimum, 
			VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, height, width, CDate, CUser, MDate, MUser, MChange, SChange, 
			DChange, CChange, Action, ColorPlacement, Artwork, License, Colorway, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, 
			MaterialLinked, MaterialTrack, TradePartnerID, TradePartnerVendorID, MaterialBOM , MaterialSizeID, StyleMaterialLinkID)
		SELECT @NewStyleMaterialID, '{00000000-0000-0000-0000-000000000000}', MainMaterial, Development, MiscColor, StyleSet, @StyleID, UOM, Qty, MaterialPrice, Ext, 
			@MaterialSize, 
			MaterialID, MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
			ComponentTypeID, MaterialType, MaterialNo, MaterialName, Source, Notes, Placement, VendorPrice, VolumePrice, VolumePriceMinimum, 
			VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, height, width, 
			@CreatedDate AS CDate, @CreatedBy AS CUser, @CreatedDate AS MDate, @CreatedBy AS MUser, 
			MChange, SChange, DChange, CChange, Action, ColorPlacement, Artwork, License, Colorway, A, B, C, D, E, F, G, H, I, J, K, 
			L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, 0, 0, TradePartnerID, TradePartnerVendorID, MaterialBOM , @MaterialSizeID AS MaterialSizeID, StyleMaterialLinkID
		FROM  pStyleMaterialTemp WITH (NOLOCK)
		WHERE (StyleMaterialID = @StyleMaterialID) AND (StyleID = @StyleID) AND (StyleSet = @StyleSet)
		
		
		SELECT @MaterialNo = MaterialNo FROM dbo.pStyleMaterials WHERE StyleMaterialID = @NewStyleMaterialID
		
		EXEC spx_StyleMaterial_Log_INSERT @StyleID = @StyleID, @StyleChangeType = 'Insert',
		@MaterialNo = @MaterialNo, @StyleSet  = @StyleSet, @CUser = @CreatedBy, @CDate = @CreatedDate
				
		/***
		** Only 1 MainMaterial
		***/
		IF @MainMaterial = 1 
		BEGIN
			UPDATE  pStyleMaterials SET MainMaterial = 0 
			WHERE StyleID = @StyleID AND StyleSet = @StyleSet
			AND StyleMaterialID <> @NewStyleMaterialID
		END 


		--Comment #01
		/********************************************************************************/
		/*Add the records for the Material into 'pStyleColorwayItem' for each Colorway.	*/
		/********************************************************************************/
		IF(@Colorway = 1)	--The colorway check box has been marked off for the Material.
			BEGIN
				/*Create temp table to hold 'StyleID' values and Colorway ('StyleColorID') values.*/
				CREATE TABLE #tempStyleColorways
				(
					TableRow int identity(1,1)
					,StyleID uniqueidentifier
					,StyleColorID uniqueidentifier
				)

				/*Get the Colorway IDs and StyleID for the Size Class.*/
				INSERT INTO #tempStyleColorways(StyleID, StyleColorID)
				SELECT StyleID, StyleColorID
				FROM pStyleColorway
				WHERE StyleID = @StyleID

				/*Set counter variables.*/
				SELECT @TotalCount = COUNT(*) FROM #tempStyleColorways
				SET @RowCounter = 1

				/*Loop to add the 'pStyleColorwayItem' records.*/
				WHILE(@RowCounter <= @TotalCount)
				BEGIN
					/*Get variables to check and make sure that the record doesn't already exist before entering it into 'pStyleColorwayItem'.*/
					SELECT @StyleColorID = StyleColorID
					FROM #tempStyleColorways
					WHERE TableRow = @RowCounter		

					/*Make sure that the record doesn't already exist.*/
					IF((SELECT COUNT(*) FROM pStyleColorwayItem 
						WHERE StyleColorID = @StyleColorID AND StyleID = @StyleID 
						AND StyleSet = @StyleSet AND StyleMaterialID = @NewStyleMaterialID AND MaterialID = @MaterialID) = 0)
					BEGIN
						/*Add the record to 'pStyleColorwayItem'.*/
						INSERT INTO pStyleColorwayItem(StyleColorItemID,StyleColorID,StyleID,
						StyleSet,StyleMaterialID,MaterialID, CUser,CDate, MUser, MDate )
						VALUES ( NEWID(), @StyleColorID, @StyleID, 
						@StyleSet,@NewStyleMaterialID,@MaterialID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate) 
					END

					/*Up row counter.*/
					SET @RowCounter = @RowCounter + 1
				END

				/*Drop the temp table.*/
				DROP TABLE #tempStyleColorways
			END

	END
ELSE
	--If Material is linked then insert material to all size class
	BEGIN
		DECLARE @StyleDevelopmentId uniqueidentifier
		DECLARE @StyleVariation int

		SELECT @StyleDevelopmentId = StyleDevelopmentId, @StyleVariation = Variation 
		FROM pStyleDevelopmentItem WITH (NOLOCK) 
		WHERE StyleId = @StyleId

		BEGIN
			INSERT INTO #tempStyleDevelopmentItem
			(StyleDevelopmentItemID, StyleDevelopmentID, StyleID, SizeRange, Variation)
			SELECT StyleDevelopmentItemID, StyleDevelopmentID, StyleID, SizeRange, Variation FROM pStyleDevelopmentItem WITH (NOLOCK) 
			WHERE StyleDevelopmentID = @StyleDevelopmentID AND Variation = @StyleVariation
		END

		--SELECT * FROM #tempStyleDevelopmentItem

		DECLARE @StyleMaterialMasterId uniqueidentifier
		SET @StyleMaterialMasterId = newid()

		DECLARE @tmpStyleId uniqueidentifier

		DECLARE @Row_Count int
		DECLARE @Row_Loop int

		SET @Row_Loop = 1
		SET @Row_Count = (SELECT COUNT(*) FROM #tempStyleDevelopmentItem)
		
		WHILE @Row_Loop <= @Row_Count 
			BEGIN
				--Comment #02
				SET @NewStyleMaterialID = NEWID()
			
				SELECT @tmpStyleID = StyleID FROM #tempStyleDevelopmentItem WHERE RecID = @Row_Loop
				
				SELECT @MainMaterial = MainMaterial FROM pStyleMaterialTemp 
				WHERE  StyleMaterialID = @StyleMaterialID AND StyleID = @StyleID AND StyleSet = @StyleSet
						
				INSERT INTO dbo.pStyleMaterials
					(StyleMaterialID, StyleMaterialMasterID, MainMaterial, Development, MiscColor, StyleSet, StyleID, UOM, Qty, MaterialPrice, Ext, 
					MaterialSize, MaterialID, 
					MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
					ComponentTypeID, MaterialType, MaterialNo, MaterialName, Source, Notes, Placement, VendorPrice, VolumePrice, VolumePriceMinimum, 
					VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, height, width, CDate, CUser, MDate, MUser, MChange, SChange, 
					DChange, CChange, Action, ColorPlacement, Artwork, License, Colorway, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z,
					MaterialLinked, MaterialTrack , MaterialPackLabelGroupID, TradePartnerID, TradePartnerVendorID, MaterialBOM , MaterialSizeID, StyleMaterialLinkID)
				SELECT @NewStyleMaterialID, @StyleMaterialMasterId AS StyleMaterialMasterID, MainMaterial, Development, MiscColor, StyleSet, @tmpStyleID, UOM, Qty, MaterialPrice, Ext, 
					@MaterialSize, 
					MaterialID, MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
					ComponentTypeID, MaterialType, MaterialNo, MaterialName, Source, Notes, Placement, VendorPrice, VolumePrice, VolumePriceMinimum, 
					VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, height, width, 
					@CreatedDate AS CDate, @CreatedBy AS CUser, @CreatedDate AS MDate, @CreatedBy AS MUser, 
					MChange, SChange, DChange, CChange, Action, ColorPlacement, Artwork, License, Colorway, A, B, C, D, E, F, G, H, I, J, K, 
					L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, 1, 0 , MaterialPackLabelGroupID, TradePartnerID, TradePartnerVendorID, MaterialBOM, @MaterialSizeID AS MaterialSizeID, StyleMaterialLinkID
				FROM  pStyleMaterialTemp WITH (NOLOCK)
				WHERE (StyleMaterialID = @StyleMaterialID) AND (StyleID = @StyleID) AND (StyleSet = @StyleSet)
				
				
				
				SELECT @MaterialNo = MaterialNo FROM dbo.pStyleMaterials WHERE StyleMaterialID = @NewStyleMaterialID
				
				EXEC spx_StyleMaterial_Log_INSERT @StyleID = @StyleID, @StyleChangeType = 'Insert',
				@MaterialNo = @MaterialNo, @StyleSet  = @StyleSet, @CUser = @CreatedBy, @CDate = @CreatedDate

				
				/***
				** Only 1 MainMaterial
				***/
				IF @MainMaterial = 1 
				BEGIN
					UPDATE  pStyleMaterials SET MainMaterial = 0 
					WHERE StyleID = @tmpStyleID AND StyleSet = @StyleSet
					AND StyleMaterialID <> @NewStyleMaterialID
				END 					

				--Comment #01
				/********************************************************************************/
				/*Add the records for the Material into 'pStyleColorwayItem' for each Colorway.	*/
				/********************************************************************************/
				IF(@Colorway = 1)	--The colorway check box has been marked off for the Material.
					BEGIN
						/*Create temp table to hold 'StyleID' values and Colorway ('StyleColorID') values.*/
						CREATE TABLE #tempStyleColorwaysLinked
						(
							TableRow int identity(1,1)
							,StyleID uniqueidentifier
							,StyleColorID uniqueidentifier
						)

						/*Get the Colorway IDs and StyleID for the Size Class.*/
						INSERT INTO #tempStyleColorwaysLinked(StyleID,StyleColorID)
						SELECT StyleID, StyleColorID
						FROM pStyleColorway
						WHERE StyleID = @tmpStyleID

						/*Set counter variables.*/
						SELECT @TotalCount = COUNT(*) FROM #tempStyleColorwaysLinked
						SET @RowCounter = 1

						/*Loop to add the 'pStyleColorwayItem' records.*/
						WHILE(@RowCounter <= @TotalCount)
						BEGIN
							/*Get variables to check and make sure that the record doesn't already exist before entering it into 'pStyleColorwayItem'.*/
							SELECT @StyleColorID = StyleColorID
							FROM #tempStyleColorwaysLinked
							WHERE TableRow = @RowCounter		

							/*Make sure that the record doesn't already exist.*/
							IF((SELECT COUNT(*) FROM pStyleColorwayItem 
							WHERE StyleColorID = @StyleColorID AND StyleID = @tmpStyleID AND StyleSet = @StyleSet AND StyleMaterialID = @NewStyleMaterialID AND MaterialID = @MaterialID) = 0)
							BEGIN

								/*Add the record to 'pStyleColorwayItem'.*/
								INSERT INTO pStyleColorwayItem(StyleColorItemID, StyleColorID, StyleID,StyleSet,
								StyleMaterialID,MaterialID, CUser,CDate, MUser, MDate )
								VALUES ( NEWID(), @StyleColorID, @tmpStyleId, @StyleSet, 
								@NewStyleMaterialID, @MaterialID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate ) 
								
							END

							/*Up row counter.*/
							SET @RowCounter = @RowCounter + 1
						END

						/*Drop the temp table.*/
						DROP TABLE #tempStyleColorwaysLinked
					END
				
				SET @Row_Loop = @Row_Loop + 1
			END
	END




--Clean Table 
DELETE FROM pStyleMaterialTemp  WHERE (StyleMaterialID = @StyleMaterialID) AND (StyleID = @StyleID) AND (StyleSet = @StyleSet)


/*Drop temp table.*/
DROP TABLE #tempStyleDevelopmentItem


GO