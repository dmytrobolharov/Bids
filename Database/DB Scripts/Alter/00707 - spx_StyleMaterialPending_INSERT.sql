IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMaterialPending_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleMaterialPending_INSERT]
GO



--Comments:

--#01 - Ryan Cabanas - 2/12/2009
--	Added functionality to the procedure so that when a Material is added to the Style, if the 'Colorway' box is checked, a record is added
--to the 'pStyleColorwayItem' table for each colorway found in 'pStyleColorway'.  If the Material added is linked, add the same for each
--Size Class in the Style.

--#02 - Ryan Cabanas - 2/16/2009
--	Need to create a new StyleMaterialID for each Material so that the Colorway Item INSERT can use this ID, as well.
	
--#03 - Daniel Pak - 2/14/2010
--	Added fielld StyleMaterialLinkID on pStyleMaterials to link styles and batch update on linked IDs	



CREATE PROCEDURE [dbo].[spx_StyleMaterialPending_INSERT](
@StyleMaterialID UNIQUEIDENTIFIER,
@StyleID UNIQUEIDENTIFIER,
@StyleSet INT,
@CreatedDate DATETIME,
@CreatedBy NVARCHAR(200),
@ChangeTransID UNIQUEIDENTIFIER,
@ChangeTransUserID UNIQUEIDENTIFIER
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

DECLARE @ChangeLogID UNIQUEIDENTIFIER
DECLARE @ChangeAfterText NVARCHAR(400)

DECLARE @MaterialLink INT, @Colorway INT
DECLARE @MainMaterial INT 
DECLARE @MaterialID  UNIQUEIDENTIFIER 
DECLARE @MaterialSizeID  UNIQUEIDENTIFIER 
DECLARE @MaterialSize NVARCHAR(200)


SELECT 
@MaterialLink = MaterialLinked,
@Colorway = Colorway,
@MaterialSizeID = MaterialSizeID,
@MaterialID = MaterialID
FROM pStyleMaterialTemp WITH (NOLOCK)
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
		
		
		SELECT @MainMaterial = MainMaterial,
		@ChangeAfterText = '(' + ISNULL(MaterialNo,'') + ') '  + ISNULL(MaterialName,'')
		FROM pStyleMaterialTemp WITH (NOLOCK) 
		WHERE  StyleMaterialID = @StyleMaterialID AND StyleID = @StyleID AND StyleSet = @StyleSet

		INSERT INTO pStyleMaterials
			(StyleMaterialID, StyleMaterialMasterID, MainMaterial, Development, MiscColor, StyleSet, StyleID, UOM, Qty, MaterialPrice, Ext, 
			MaterialSize, MaterialID, 
			MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
			ComponentTypeID, MaterialType, MaterialNo, MaterialName, Source, Notes, Placement, VendorPrice, VolumePrice, VolumePriceMinimum, 
			VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, height, width, CDate, CUser, MDate, MUser, MChange, SChange, 
			DChange, CChange, Action, ColorPlacement, Artwork, License, Colorway, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, 
			MaterialLinked, MaterialTrack, TradePartnerID, TradePartnerVendorID, MaterialBOM , MaterialSizeID, StyleMaterialLinkID
			)
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
		
		
		--**
		--** Only 1 MainMaterial
		--**  
		IF @MainMaterial = 1 
		BEGIN
			UPDATE  pStyleMaterials SET MainMaterial = 0 
			WHERE StyleID = @StyleID AND StyleSet = @StyleSet
			AND StyleMaterialID <> @NewStyleMaterialID
		END 
		
		--** Log Insert
		SET @ChangeLogID = NULL
			
		EXECUTE spx_ChangeLog_INSERTID
			@changeTableId = '036F8B4C-C1CC-DF11-AF06-005056C00008',
			@changeTransId = @ChangeTransID,
			@changeTablePKId = @NewStyleMaterialID,
			@changeUserId = @ChangeTransUserID, 
			@ChangeUserName = @CreatedBy,
			@changeDate = @CreatedDate,
			@changeSort = '0000',
			@ShowResult = 0,
			@ChangeLogID = @ChangeLogID OUTPUT
				
		EXECUTE spx_ChangeLogItem_INSERT
			@ChangeLogID = @ChangeLogID,
			@ChangeTransID = @ChangeTransID,
			@ChangeFieldName = 'StyleMaterialID',
			@ChangeFieldAlias = 'StyleMaterialID',
			@ChangeBeforeValue = NULL,
			@ChangeAfterValue = @NewStyleMaterialID,
			@ChangeBeforeText = @StyleID, --Save StyleId,, used as temporary value
			@ChangeAfterText = @ChangeAfterText,
			@ChangeSort = '0001'



		--Comment #01
		--******************************************************************************  
		--Add the records for the Material into 'pStyleColorwayItem' for each Colorway.	  
		--******************************************************************************  
		IF(@Colorway = 1)	--The colorway check box has been marked off for the Material.
			BEGIN
				--Create temp table to hold 'StyleID' values and Colorway ('StyleColorID') values.  
				CREATE TABLE #tempStyleColorways
				(
					TableRow INT IDENTITY(1,1)
					,StyleID UNIQUEIDENTIFIER
					,StyleColorID UNIQUEIDENTIFIER
				)

				--Get the Colorway IDs and StyleID for the Size Class.  
				INSERT INTO #tempStyleColorways(StyleID, StyleColorID)
				SELECT StyleID, StyleColorID
				FROM pStyleColorway WITH (NOLOCK)
				WHERE StyleID = @StyleID

				--Set counter variables.  
				SELECT @TotalCount = COUNT(*) FROM #tempStyleColorways
				SET @RowCounter = 1

				--Loop to add the 'pStyleColorwayItem' records.  
				WHILE(@RowCounter <= @TotalCount)
				BEGIN
					--Get variables to check and make sure that the record doesn't already exist before entering it into 'pStyleColorwayItem'.  
					SELECT @StyleColorID = StyleColorID
					FROM #tempStyleColorways
					WHERE TableRow = @RowCounter		

					--Make sure that the record doesn't exist.  
					
					
					
					IF NOT EXISTS (SELECT * FROM pStyleColorwayItem WITH (NOLOCK)
						WHERE StyleColorID = @StyleColorID AND StyleID = @StyleID 
						AND StyleSet = @StyleSet AND StyleMaterialID = @NewStyleMaterialID AND MaterialID = @MaterialID) 
					BEGIN
						--Add the record to 'pStyleColorwayItem'.  
						INSERT INTO pStyleColorwayItem(StyleColorItemID,StyleColorID,StyleID,
						StyleSet,StyleMaterialID,MaterialID, CUser,CDate, MUser, MDate )
						VALUES ( NEWID(), @StyleColorID, @StyleID, 
						@StyleSet,@NewStyleMaterialID,@MaterialID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate) 
					END

					--Up row counter.  
					SET @RowCounter = @RowCounter + 1
				END

				--Drop the temp table.  
				DROP TABLE #tempStyleColorways
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
				
				SELECT @MainMaterial = MainMaterial,
				@ChangeAfterText = '(' + ISNULL(MaterialNo,'') + ') '  + ISNULL(MaterialName,'')
				FROM pStyleMaterialTemp WITH (NOLOCK)
				WHERE  StyleMaterialID = @StyleMaterialID AND StyleID = @StyleID AND StyleSet = @StyleSet
						
				INSERT INTO dbo.pStyleMaterials
					(StyleMaterialID, StyleMaterialMasterID, MainMaterial, Development, MiscColor, StyleSet, StyleID, UOM, Qty, MaterialPrice, Ext, 
					MaterialSize, MaterialID, 
					MaterialPlacement, MaterialPlacementCode, MaterialPlacementDetail, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
					ComponentTypeID, MaterialType, MaterialNo, MaterialName, Source, Notes, Placement, VendorPrice, VolumePrice, VolumePriceMinimum, 
					VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, height, width, CDate, CUser, MDate, MUser, MChange, SChange, 
					DChange, CChange, Action, ColorPlacement, Artwork, License, Colorway, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z,
					MaterialLinked, MaterialTrack , MaterialPackLabelGroupID, TradePartnerID, TradePartnerVendorID, MaterialBOM , MaterialSizeID, StyleMaterialLinkID
					)
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
				
				--**
				--** Only 1 MainMaterial
				IF @MainMaterial = 1 
				BEGIN
					UPDATE  pStyleMaterials SET MainMaterial = 0 
					WHERE StyleID = @tmpStyleID AND StyleSet = @StyleSet
					AND StyleMaterialID <> @NewStyleMaterialID
				END 			
				
				--** Log Insert
				SET @ChangeLogID = NULL
					
				EXECUTE spx_ChangeLog_INSERTID
					@changeTableId = '036F8B4C-C1CC-DF11-AF06-005056C00008',
					@changeTransId = @ChangeTransID,
					@changeTablePKId = @NewStyleMaterialID,
					@changeUserId = @ChangeTransUserID, 
					@ChangeUserName = @CreatedBy,
					@changeDate = @CreatedDate,
					@changeSort = '0000',
					@ShowResult = 0,
					@ChangeLogID = @ChangeLogID OUTPUT
						
				EXECUTE spx_ChangeLogItem_INSERT
					@ChangeLogID = @ChangeLogID,
					@ChangeTransID = @ChangeTransID,
					@ChangeFieldName = 'StyleMaterialID',
					@ChangeFieldAlias = 'StyleMaterialID',
					@ChangeBeforeValue = @tmpStyleID,  -- saved as a temp value
					@ChangeAfterValue = @NewStyleMaterialID,
					@ChangeBeforeText = NULL,
					@ChangeAfterText = @ChangeAfterText,
					@ChangeSort = '0001'
						

				--Comment #01
				--******************************************************************************  
				--Add the records for the Material into 'pStyleColorwayItem' for each Colorway.	  
				--******************************************************************************  
				IF(@Colorway = 1)	--The colorway check box has been marked off for the Material.
					BEGIN
						--Create temp table to hold 'StyleID' values and Colorway ('StyleColorID') values.  
						CREATE TABLE #tempStyleColorwaysLinked
						(
							TableRow INT IDENTITY(1,1)
							,StyleID UNIQUEIDENTIFIER
							,StyleColorID UNIQUEIDENTIFIER
						)

						--Get the Colorway IDs and StyleID for the Size Class.  
						INSERT INTO #tempStyleColorwaysLinked(StyleID,StyleColorID)
						SELECT StyleID, StyleColorID
						FROM pStyleColorway WITH (NOLOCK)
						WHERE StyleID = @tmpStyleID

						--Set counter variables.  
						SELECT @TotalCount = COUNT(*) FROM #tempStyleColorwaysLinked
						SET @RowCounter = 1

						--Loop to add the 'pStyleColorwayItem' records.  
						WHILE(@RowCounter <= @TotalCount)
						BEGIN
							--Get variables to check and make sure that the record doesn't already exist before entering it into 'pStyleColorwayItem'.  
							SELECT @StyleColorID = StyleColorID
							FROM #tempStyleColorwaysLinked
							WHERE TableRow = @RowCounter		

							--Make sure that the record doesn't already exist.  
							IF NOT EXISTS (SELECT * FROM pStyleColorwayItem WITH (NOLOCK)
								WHERE StyleColorID = @StyleColorID AND StyleID = @tmpStyleID 
								AND StyleSet = @StyleSet AND StyleMaterialID = @NewStyleMaterialID 
								AND MaterialID = @MaterialID) 
							BEGIN

								--Add the record to 'pStyleColorwayItem'.  
								INSERT INTO pStyleColorwayItem(StyleColorItemID, StyleColorID, StyleID,StyleSet,
								StyleMaterialID,MaterialID, CUser,CDate, MUser, MDate )
								VALUES ( NEWID(), @StyleColorID, @tmpStyleId, @StyleSet, 
								@NewStyleMaterialID, @MaterialID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate ) 
								
							END

							--Up row counter.  
							SET @RowCounter = @RowCounter + 1
						END

						--Drop the temp table.  
						DROP TABLE #tempStyleColorwaysLinked
					END
				
				SET @Row_Loop = @Row_Loop + 1
			END
	END




--Clean Table 
DELETE FROM pStyleMaterialTemp  
WHERE StyleMaterialID = @StyleMaterialID 
AND StyleID = @StyleID
AND StyleSet = @StyleSet


--Drop temp table.  
DROP TABLE #tempStyleDevelopmentItem


SET NOCOUNT OFF


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '707', GetDate())
GO


