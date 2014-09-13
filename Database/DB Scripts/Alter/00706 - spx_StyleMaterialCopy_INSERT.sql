IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMaterialCopy_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleMaterialCopy_INSERT]
GO



CREATE PROCEDURE [dbo].[spx_StyleMaterialCopy_INSERT](
@StyleID NVARCHAR(50),
@StyleSet NVARCHAR(5),
@CopyStyleID NVARCHAR(50),
@CopyStyleSet NVARCHAR(5),
@NewStyleMaterialID NVARCHAR(50),
@StyleMaterialID NVARCHAR(50),
@MainMaterial INT,
@Colorway INT,
@Artwork INT,
@License INT,
@Placement NVARCHAR(2000) = '',
@MaterialPrice MONEY,
@MaterialSize NVARCHAR(200),
@Qty NVARCHAR(50),
@UOM NVARCHAR(50),
@CreatedDate DATETIME,
@CreatedBy NVARCHAR(200),
@ChangeTransID UNIQUEIDENTIFIER,
@ChangeTransUserID UNIQUEIDENTIFIER
)
AS 


--**Variables needed to loop through all size classes.
DECLARE @StyleMasterID UNIQUEIDENTIFIER
DECLARE @StyleMaterialMasterID UNIQUEIDENTIFIER
DECLARE @TotalCount INT
DECLARE @RowCounter INT
DECLARE @StyleType NVARCHAR (5) 
DECLARE @ChangeLogID UNIQUEIDENTIFIER
DECLARE @ChangeAfterText NVARCHAR(400)

SET @StyleMaterialMasterID = @NewStyleMaterialID

DECLARE @StyleColorID UNIQUEIDENTIFIER
SET @StyleColorID = NEWID()

--**Temp table to hold StyleIDs for all size classes.
CREATE TABLE #tempStyleIDs
(
	TableRow INT IDENTITY(1, 1),
	StyleID UNIQUEIDENTIFIER
)

SET NoCount ON

BEGIN TRANSACTION

	--** Get the StyleMasterId of the Style to find out if there are any other size classes with this Style.
	SELECT @StyleMasterID = StyleMasterID FROM pStyleHeader WITH (NOLOCK) WHERE StyleID = @StyleID

	--**Get all the other StyleIDs in care there are any other size classes for the Style.
	INSERT INTO #tempStyleIDs (StyleID)
	SELECT StyleID FROM pStyleHeader WITH (NOLOCK) WHERE StyleMasterID = @StyleMasterID

	SELECT @TotalCount = COUNT(*) FROM #tempStyleIDs
	SET @RowCounter = 1

	--** Check if there is a main material already 
	SELECT @MainMaterial = MainMaterial, @ChangeAfterText = '(' + ISNULL(MaterialNo,'') + ') '  + ISNULL(MaterialName,'')
	FROM pStyleMaterials WITH (NOLOCK) 
	WHERE StyleMaterialID = @StyleMaterialID
	
	IF EXISTS ( SELECT * FROM pStyleMaterials WITH (NOLOCK) WHERE StyleID = @StyleID AND MainMaterial = 1 )
		SET @MainMaterial = 0

	WHILE (@RowCounter <= @TotalCount)
		BEGIN
			--** Create a new StyleMaterialID for each of the size classes.
			SET @NewStyleMaterialID = NEWID()


			--** Get each StyleID from the list for each size class.
			SELECT @StyleID = StyleID FROM #tempStyleIDs WHERE TableRow = @RowCounter


			INSERT INTO dbo.pStyleMaterials(
				StyleMaterialID, StyleMaterialMasterID, CopyStyleMaterialID, MainMaterial, StyleSet, StyleID, UOM, Qty, MaterialPrice, Ext, MaterialSize, MaterialID, MaterialImageID, MaterialImageVersion, 
				NoColorMatch, SupplierID, ComponentTypeID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z ,  Source, 
				Notes, Placement, VendorPrice, VolumePrice, VolumePriceMinimum, VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, 
				ColorPlacement, Artwork, License, Colorway, CDate, CUser, MDate, MUser, MChange)
			SELECT @NewStyleMaterialID AS NewStyleMaterialID, @StyleMaterialMasterID AS StyleMaterialMasterID, StyleMaterialID, @MainMaterial AS MainMaterial, @StyleSet AS StyleSet, @StyleID AS StyleID, @UOM AS UOM, 
				@Qty AS Qty, @MaterialPrice AS MaterialPrice, Ext, MaterialSize, MaterialID, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
				ComponentTypeID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T , U,  V, W, X, Y , Z , Source, Notes, @Placement AS Placement, 
				VendorPrice, VolumePrice, VolumePriceMinimum, VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, ColorPlacement, 
				@Artwork AS Artwork, @License AS License, @Colorway AS Colorway, @CreatedDate AS CDate, @CreatedBy AS CUser, @CreatedDate AS MDate, 
				@CreatedBy AS MUser, MChange 
			FROM dbo.pStyleMaterials WITH (NOLOCK)
			WHERE StyleMaterialID = @StyleMaterialID
			
			IF @@ERROR <> 0
			BEGIN
				ROLLBACK TRANSACTION
				RETURN
			END		
			
			
			--** Log Insert
			SET @ChangeLogID = NULL
				
			EXECUTE spx_ChangeLog_INSERTID
				@changeTableId = '036F8B4C-C1CC-DF11-AF06-005056C00008', --pStyleMaterials
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
				@ChangeBeforeText = NULL,
				@ChangeAfterText = @ChangeAfterText,
				@ChangeSort = '0001'
							


			SET @RowCounter = @RowCounter + 1
		END

				
COMMIT TRANSACTION



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '706', GetDate())
GO
