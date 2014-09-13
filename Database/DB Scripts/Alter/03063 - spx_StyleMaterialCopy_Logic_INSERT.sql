/****** Object:  StoredProcedure [dbo].[spx_StyleMaterialCopy_Logic_INSERT]    Script Date: 01/31/2012 15:15:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMaterialCopy_Logic_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMaterialCopy_Logic_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleMaterialCopy_Logic_INSERT]    Script Date: 01/31/2012 15:15:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_StyleMaterialCopy_Logic_INSERT](
	@StyleMaterialID UNIQUEIDENTIFIER, 
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@CUser NVARCHAR(200),
	@CDate DATETIME,
	@TeamID UNIQUEIDENTIFIER,
	@SQLUpdate NVARCHAR(MAX)
)
AS


SET NoCount ON

--**Variables needed to loop through all size classes.
DECLARE 
	@StyleMasterID UNIQUEIDENTIFIER,
	@StyleMaterialMasterID UNIQUEIDENTIFIER,
	@TotalCount INT,
	@RowCounter INT,
	@ChangeLogID UNIQUEIDENTIFIER,
	@ChangeAfterText NVARCHAR(400),
	@tmpStyleID UNIQUEIDENTIFIER,
	@tmpStyleMaterialID UNIQUEIDENTIFIER,
	@SQL NVARCHAR(MAX),
	@MainMaterial INT,
	@NewChangeTransID UNIQUEIDENTIFIER,
	@MaterialNo NVARCHAR(200),
	@MaterialName NVARCHAR(200)

SET @StyleMaterialMasterID = NEWID()

--**Temp table to hold StyleIDs for all size classes.
CREATE TABLE #tempStyleIDs(
	TableRow INT IDENTITY(1, 1),
	StyleID UNIQUEIDENTIFIER,
	StyleMaterialID UNIQUEIDENTIFIER DEFAULT NEWID()
)

--** Get the StyleMasterId of the Style to find out if there are any other size classes with this Style.
SELECT @StyleMasterID = StyleMasterID FROM pStyleHeader WITH (NOLOCK) WHERE StyleID = @StyleID

IF @StyleMasterID IS NULL 
BEGIN 
	SET @StyleMasterID =  NEWID()
	UPDATE dbo.pStyleHeader SET StyleMasterID = @StyleMasterID WHERE StyleID = @StyleID
END


--**Get all the other StyleIDs in care there are any other size classes for the Style.
INSERT INTO #tempStyleIDs (StyleID)
SELECT StyleID FROM pStyleHeader WITH (NOLOCK) WHERE StyleMasterID = @StyleMasterID

SELECT @TotalCount = COUNT(*) FROM #tempStyleIDs
SET @RowCounter = 1

SELECT @MaterialName = ISNULL(MaterialName,'') , @MaterialNo = ISNULL(MaterialNo ,'')
FROM dbo.pStyleMaterials WITH(NOLOCK) WHERE StyleMaterialID = @StyleMaterialID 

SET @ChangeAfterText = '(' + @MaterialNo + ') '  + @MaterialName

WHILE (@RowCounter <= @TotalCount)
BEGIN

	--** Get each StyleID from the list for each size class.
	SELECT @tmpStyleID = StyleID, @tmpStyleMaterialID = StyleMaterialID FROM #tempStyleIDs WHERE TableRow = @RowCounter
			
	--** Check if there is a main material already 
	SELECT @MainMaterial = ISNULL(MainMaterial,0)
	FROM pStyleMaterials WITH (NOLOCK) 
	WHERE StyleID = @tmpStyleID
		AND MainMaterial = 1 
		
	IF(LEN(@SQLUpdate)<>0 OR @SQLUpdate<>'')
	BEGIN	
		SET @SQL = @SQLUpdate + ' WHERE StyleMaterialID = ''' + CAST(@tmpStyleMaterialID AS NVARCHAR(40)) + ''''
	END	
	ELSE
	BEGIN
		SET @SQL = @SQLUpdate 
	END
	
	INSERT INTO dbo.pStyleMaterials( StyleMaterialID, StyleMaterialMasterID, CopyStyleMaterialID, 
		--MainMaterial, DO NOT INCLUDE MAINMATERIAL 
		StyleSet, StyleID, UOM, Qty, MaterialPrice, Ext, MaterialSize, MaterialID, MaterialImageID, MaterialImageVersion, 
		NoColorMatch, SupplierID, ComponentTypeID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z ,  Source, 
		Notes, Placement, VendorPrice, VolumePrice, VolumePriceMinimum, VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, 
		ColorPlacement, Artwork, License, Colorway, CDate, CUser, MDate, MUser, MChange)
	SELECT @tmpStyleMaterialID AS NewStyleMaterialID, @StyleMaterialMasterID AS StyleMaterialMasterID, StyleMaterialID, 
		--@MainMaterial AS MainMaterial, 
		@StyleSet AS StyleSet, @StyleID AS StyleID, UOM, 
		Qty, MaterialPrice, Ext, MaterialSize, MaterialID, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
		ComponentTypeID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T , U,  V, W, X, Y , Z , Source, Notes, Placement AS Placement, 
		VendorPrice, VolumePrice, VolumePriceMinimum, VendorProductionMin, VendorProductionLeadTime, DetailYesNo, ImageType, ColorPlacement, 
		Artwork , License, Colorway, @CDate AS CDate, @CUser AS CUser, @CDate AS MDate, 
		@CUser AS MUser, MChange 
	FROM dbo.pStyleMaterials WITH (NOLOCK)
	WHERE StyleMaterialID = @StyleMaterialID
	

	EXECUTE sp_executesql @SQL
	
	
	
	
	-- Add Log,, material COPY
	SET @NewChangeTransID =  NEWID()
	INSERT INTO dbo.pChangeTransaction ( ChangeTransID, ChangeTransPageName, ChangeTransTableID,
		ChangeTransTablePKID,ChangeTransUserID, ChangeTransDate,ChangeTransTypeID)
	VALUES( @NewChangeTransID,'ASP.style_copy_component_aspx' ,  -- Procedure called only from this page
		'D612FAAE-7ACD-DF11-AF06-005056C00008', -- pStyleHeader  ,
		@StyleID,@TeamID,@CDate, 
		3 -- COPY
	)		
	
	EXECUTE spx_ChangeLog_INSERTID
		@changeTableId = '036F8B4C-C1CC-DF11-AF06-005056C00008', --pStyleMaterials
		@changeTransId = @NewChangeTransID,
		@changeTablePKId = @tmpStyleMaterialID,
		@changeUserId = @TeamID, 
		@ChangeUserName = @CUser,
		@changeDate = @CDate,
		@changeSort = '0000',
		@ShowResult = 0,
		@ChangeLogID = @ChangeLogID OUTPUT
			
	EXECUTE spx_ChangeLogItem_INSERT
		@ChangeLogID = @ChangeLogID,
		@ChangeTransID = @NewChangeTransID,
		@ChangeFieldName = 'StyleMaterialID',
		@ChangeFieldAlias = 'StyleMaterialID',
		@ChangeBeforeValue = NULL,
		@ChangeAfterValue = @tmpStyleMaterialID,
		@ChangeBeforeText = NULL,
		@ChangeAfterText = @ChangeAfterText,
		@ChangeSort = '0001'		
		
	
	
	IF @MainMaterial = 1
	BEGIN
		-- There is a main material already and maybe in the update a new main material was selected 
		UPDATE pStyleMaterials SET MainMaterial = 0 WHERE StyleMaterialID = @tmpStyleMaterialID
	END
	ELSE
	BEGIN 

		SELECT @MainMaterial = ISNULL(MainMaterial,0)
		FROM pStyleMaterials WITH (NOLOCK) 
		WHERE StyleMaterialID = @tmpStyleMaterialID

		--IF new mainmaterial was defined in the update 
		IF @MainMaterial = 1 
		BEGIN 
	
			-- Log change when new MainMaterial is specified
			SET @NewChangeTransID =  NEWID()

			INSERT INTO dbo.pChangeTransaction ( ChangeTransID, ChangeTransPageName, ChangeTransTableID,
				ChangeTransTablePKID,ChangeTransUserID, ChangeTransDate,ChangeTransTypeID)
			VALUES( @NewChangeTransID,'ASP.style_copy_component_aspx' ,  -- Procedure called only from this page
				'D612FAAE-7ACD-DF11-AF06-005056C00008', -- pStyleHeader  ,
				@StyleID,@TeamID,@CDate, 
				0 -- UPDATE
			)	
			
			--** Log Insert
			SET @ChangeLogID = NULL
				
			EXECUTE spx_ChangeLog_INSERTID
				@changeTableId = '036F8B4C-C1CC-DF11-AF06-005056C00008', --pStyleMaterials
				@changeTransId = @NewChangeTransID,
				@changeTablePKId = @tmpStyleMaterialID,
				@changeUserId = @TeamID, 
				@ChangeUserName = @CUser,
				@changeDate = @CDate,
				@changeSort = '0000',
				@ShowResult = 0,
				@ChangeLogID = @ChangeLogID OUTPUT
					
			EXECUTE spx_ChangeLogItem_INSERT
				@ChangeLogID = @ChangeLogID,
				@ChangeTransID = @NewChangeTransID,
				@ChangeFieldName = 'StyleMaterialID',
				@ChangeFieldAlias = 'StyleMaterialID',
				@ChangeBeforeValue = NULL,
				@ChangeAfterValue = @tmpStyleMaterialID,
				@ChangeBeforeText = NULL,
				@ChangeAfterText = @ChangeAfterText,
				@ChangeSort = '0001'		
				
		END 
	END
	
	-- Techpack exist ?
	IF EXISTS ( SELECT * FROM pStyleHeader a WITH(NOLOCK) 
			INNER JOIN dbo.pTechPack b WITH(NOLOCK)  ON a.TechPackId = b.TechPackID 
			WHERE a.StyleID = @tmpStyleID  )
	BEGIN 
		DECLARE 
			@ChangeID UNIQUEIDENTIFIER,
			@StyleChangeDescription NVARCHAR(400)
			
		SELECT @ChangeID = NEWID(), @StyleChangeDescription = 'New Material Added ' + @MaterialName
		
		EXECUTE spx_StyleChange_INSERT
			@ActiveID = '00000000-0000-0000-0000-000000000000',
			@ChangeID  = @ChangeID,
			@WorkflowID = '30000000-0000-0000-0000-000000000003',
			@StyleID = @tmpStyleID,
			@StyleSet = @StyleSet, 
			@StyleStatus = 0, -- false
			@StyleChangeNotifyTo = '',
			@StyleChangeType = 'Update',
			@StyleChangeDescription = @StyleChangeDescription,
			@ChangeBy   = @CUser,
			@ChangeDate = @CDate		
	END 
			
	SET @RowCounter = @RowCounter + 1
END


GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03063'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03063', GetDate())
END
GO