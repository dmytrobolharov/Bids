/****** Object:  StoredProcedure [dbo].[spx_StyleMaterialLink_SeasonYear_INSERT]    Script Date: 03/18/2014 13:28:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMaterialLink_SeasonYear_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMaterialLink_SeasonYear_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleMaterialLink_SeasonYear_INSERT]    Script Date: 03/18/2014 13:28:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[spx_StyleMaterialLink_SeasonYear_INSERT](
@StyleID UNIQUEIDENTIFIER,
@NewStyleID UNIQUEIDENTIFIER,
@SeasonYearID UNIQUEIDENTIFIER,
@CUser NVARCHAR(200),
@CDate DATETIME
)
AS

DECLARE @NewStyleSeasonYearID UNIQUEIDENTIFIER 
DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER 

SELECT @NewStyleSeasonYearID = StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @NewStyleID AND SeasonYearID = @SeasonYearID 
SELECT @StyleSeasonYearID = StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID 

IF @NewStyleSeasonYearID IS NULL 
	RETURN ;
	
CREATE TABLE [dbo].[#tempStyleMaterials] (
	[RecID] int IDENTITY(1,1)  NOT NULL,
	[StyleMaterialID]  uniqueidentifier ROWGUIDCOL  NOT NULL ,
	[StyleMaterialMasterID] [uniqueidentifier],
	[Colorway] INT,
)

CREATE TABLE [dbo].[#tempCopyStyleMaterials] (
	[RecID] int IDENTITY(1,1)  NOT NULL,
	[StyleMaterialID]  uniqueidentifier ROWGUIDCOL  NOT NULL ,
	[StyleMaterialMasterID] [uniqueidentifier],
	[CopyStyleMaterialID] [uniqueidentifier],
	[MainMaterial] [int],
	[Development] [bit],
	[StyleSet] [int],
	[StyleID] [uniqueidentifier],
	[UOM] [nvarchar] (50),
	[Qty] [nvarchar] (18),
	[MaterialPrice] [money],
	[Ext] [money],
	[MaterialSize] [nvarchar] (200),
	[MaterialID] [uniqueidentifier],
	[MaterialPlacement] [bit],
	[MaterialPlacementCode] [nvarchar] (4),
	[MaterialPlacementDetail] [nvarchar] (200),
	[MaterialImageID] [uniqueidentifier],
	[MaterialImageVersion] [int],
	[NoColorMatch] [int],
	[SupplierID] [nvarchar] (50),
	[ComponentTypeID] [int],
	[MaterialType] [int],
	[MaterialNo] [nvarchar] (50),
	[MaterialName] [nvarchar] (200),
	[A] [nvarchar] (100),
	[B] [nvarchar] (100),
	[C] [nvarchar] (100),
	[D] [nvarchar] (100),
	[E] [nvarchar] (100),
	[F] [nvarchar] (100),
	[G] [nvarchar] (100),
	[H] [nvarchar] (100),
	[I] [nvarchar] (100),
	[J] [nvarchar] (100),
	[K] [nvarchar] (100),
	[L] [nvarchar] (100),
	[M] [nvarchar] (100),
	[N] [nvarchar] (100),
	[O] [nvarchar] (100),
	[P] [nvarchar] (100),
	[Q] [nvarchar] (100),
	[R] [nvarchar] (100),
	[S] [nvarchar] (100),
	[T] [nvarchar] (100),
	[U] [nvarchar] (100),
	[V] [nvarchar] (100),
	[W] [nvarchar] (100),
	[X] [nvarchar] (100),
	[Y] [nvarchar] (100),
	[Z] [nvarchar] (100),
	[Source] [nvarchar] (200),
	[Notes] [nvarchar] (4000),
	[Placement] [nvarchar] (4000),
	[VendorPrice] [decimal](19, 3),
	[VolumePrice] [decimal](19, 3),
	[VolumePriceMinimum] [nvarchar] (50),
	[VendorProductionMin] [nvarchar] (50),
	[VendorProductionLeadTime] [nvarchar] (50),
	[DetailYesNo] [int],
	[ImageType] [nvarchar] (50),
	[height] [nvarchar] (18),
	[width] [nvarchar] (18),
	[CDate] [datetime],
	[CUser] [nvarchar] (200),
	[MDate] [datetime],
	[MUser] [nvarchar] (200),
	[MChange] [int],
	[SChange] [int],
	[DChange] [int],
	[CChange] [int],
	[Action] [nvarchar] (50),
	[ColorPlacement] [nvarchar] (4000),
	[Artwork] INT,
	[License] INT,
	[Colorway] INT,
	[MaterialSort] [nvarchar] (5),
	[MaterialTrack] [int],
	[MaterialLinked] [int],
	[MaterialLining] [int]
)

CREATE TABLE [dbo].[#tempStyleColorway] (
	[RecID] int IDENTITY(1,1)  NOT NULL,
	[StyleColorID]  uniqueidentifier ROWGUIDCOL  NOT NULL ,
) 

CREATE TABLE [dbo].[#tempCopyStyleColorway] (
	[RecID] int IDENTITY(1,1)  NOT NULL,
	[StyleColorID]  uniqueidentifier ROWGUIDCOL  NOT NULL ,
	[StyleID] [uniqueidentifier],
	[StyleSet] [int],
	[StyleColorStandardID] [uniqueidentifier],
	[StyleColorNo] [nvarchar] (200) ,		
	[StyleColorName] [nvarchar] (200) ,
	[MainColor] [nvarchar] (100) ,
	[Sort] [nvarchar] (10) ,
	[Version] [int],
	[CDate] [datetime],
	[CUser] [nvarchar] (200),
	[MDate] [datetime],
	[MUser] [nvarchar] (200) ,
	CopyStyleColorID UNIQUEIDENTIFIER , 
	ColorPaletteID UNIQUEIDENTIFIER
) 

CREATE TABLE [dbo].[#tempStyleColorwayItem] (
	[RecID] int IDENTITY(1,1)  NOT NULL,
	[StyleColorItemID]  uniqueidentifier,
	[StyleColorItemMasterID] [uniqueidentifier], 
	[StyleColorID] [uniqueidentifier],
	[StyleID] [uniqueidentifier],
	[StyleSet] [int],
	[StyleMaterialID] [uniqueidentifier],
	[MaterialID] [uniqueidentifier],
	[MaterialColorID] [uniqueidentifier],
	[CDate] [datetime],
	[CUser] [nvarchar] (200),
	[MDate] [datetime],
	[MUser] [nvarchar] (200)
) 

CREATE TABLE [dbo].[#tempCopyStyleColorwayItem] (
	[RecID] int IDENTITY(1,1)  NOT NULL,
	[StyleColorItemID]  uniqueidentifier,
	[StyleColorItemMasterID] [uniqueidentifier], 
	[StyleColorID] [uniqueidentifier],
	[StyleID] [uniqueidentifier],
	[StyleSet] [int],
	[StyleMaterialID] [uniqueidentifier],
	[MaterialID] [uniqueidentifier],
	[MaterialColorID] [uniqueidentifier],
	[CDate] [datetime],
	[CUser] [nvarchar] (200),
	[MDate] [datetime],
	[MUser] [nvarchar] (200)
) 

DECLARE @Row_Count int
DECLARE @Row_Loop int
DECLARE @Row_Color_Count int
DECLARE @Row_Color_Loop int

BEGIN

	INSERT INTO dbo.#tempStyleColorway( StyleColorID )
	SELECT StyleColorwayID
	FROM dbo.pStyleColorwaySeasonYear
	WHERE StyleSeasonYearID = @StyleSeasonYearID 
	AND StyleColorwayID IS NOT NULL -- old colorways (not from dim bom)
	
	
	DECLARE @StyleColorID uniqueidentifier 	
	DECLARE @NewStyleColorID uniqueidentifier 	
		
	SET @Row_Loop = 1
	SET @Row_Count = (SELECT COUNT(*) FROM #tempStyleColorway)

	WHILE @Row_Loop <= @Row_Count 
	BEGIN
		
		SELECT @StyleColorID = StyleColorID FROM  #tempStyleColorway WHERE RecID = @Row_Loop
		SET @NewStyleColorID = newid()
	
		INSERT INTO dbo.#tempCopyStyleColorway
		(StyleColorID, StyleID, StyleSet, StyleColorStandardID, StyleColorNo, StyleColorName, MainColor, Sort, Version, CDate, CUser, MDate, MUser , CopyStyleColorID, ColorPaletteID)
		SELECT @NewStyleColorID, @NewStyleID, StyleSet, StyleColorStandardID, StyleColorNo, StyleColorName, MainColor, Sort, Version, @CDate AS CDate, @CUser AS CUser, 
		@CDate AS MDate, @CUser AS MUser , CopyStyleColorID, ColorPaletteID
		FROM dbo.pStyleColorway
		WHERE (StyleColorID = @StyleColorID)
		
		SET @Row_Loop = @Row_Loop + 1
	END
	
END	
	
-- FIX StyleColorItemMasterID	
BEGIN	
	INSERT INTO dbo.#tempStyleColorwayItem
	(StyleColorItemID, StyleColorItemMasterID, StyleColorID, StyleID, StyleSet, StyleMaterialID, MaterialID, MaterialColorID, CDate, CUser, MDate, MUser)
	SELECT StyleColorItemID, StyleColorItemMasterID, StyleColorID, StyleID, StyleSet, StyleMaterialID, MaterialID, MaterialColorID, CDate, CUser, MDate, MUser
	FROM  dbo.pStyleColorwayItem
	WHERE StyleID = @StyleID
	
	--SET @Row_Loop = 1
	--SET @Row_Count = (SELECT COUNT(*) FROM #tempStyleColorwayItem)
	
	--DECLARE @StyleColorItemID uniqueidentifier 	
	--DECLARE @StyleColorItemMasterID  uniqueidentifier 	

	--WHILE @Row_Loop <= @Row_Count 
	--BEGIN
	--	SELECT @StyleColorItemMasterID = StyleColorItemMasterID, @StyleColorItemID = StyleColorItemID 
	--	FROM  #tempStyleColorwayItem WHERE RecID = @Row_Loop
		
	--	IF @StyleColorItemMasterID IS NULL
	--	BEGIN
	--		UPDATE pStyleColorwayItem SET StyleColorItemMasterID = newid() WHERE StyleColorItemID = @StyleColorItemID
	--	END	
	--	SET @Row_Loop = @Row_Loop + 1
	--END
	
	UPDATE  pStyleColorwayItem SET StyleColorItemMasterID = NEWID() 
	WHERE StyleID = @StyleID AND StyleColorItemMasterID IS NULL 
		
END	

		

---Style Material--------------------------------------------
BEGIN

	INSERT INTO dbo.#tempStyleMaterials( StyleMaterialID, StyleMaterialMasterID, Colorway)
	SELECT StyleMaterialID, StyleMaterialMasterID, Colorway
	FROM dbo.pStyleMaterials
	WHERE StyleID = @StyleID

	DECLARE @StyleMaterialMasterID uniqueidentifier
	DECLARE @StyleMaterialID uniqueidentifier
	DECLARE @NewStyleMaterialID uniqueidentifier
	DECLARE @Colorway INT

	SET @Row_Loop = 1
	SELECT @Row_Count  = COUNT(*) FROM #tempStyleMaterials
	
	WHILE @Row_Loop <= @Row_Count 
	BEGIN
		
		SELECT @StyleMaterialMasterID = StyleMaterialMasterID, @StyleMaterialID = StyleMaterialID, @Colorway = Colorway 
		FROM #tempStyleMaterials WHERE RecID = @Row_Loop
			
		IF @StyleMaterialMasterID IS NULL
		BEGIN
			UPDATE pStyleMaterials SET StyleMaterialMasterID = NEWID() WHERE StyleMaterialID = @StyleMaterialID
		END
			
		BEGIN
		
			SET @NewStyleMaterialID = NEWID()
	
			INSERT INTO dbo.#tempCopyStyleMaterials
			(StyleMaterialID, MainMaterial, StyleSet, StyleID, UOM, Qty, MaterialPrice, Ext, MaterialSize, MaterialID, MaterialImageID, 
			MaterialImageVersion, NoColorMatch, SupplierID, ComponentTypeID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O,
			P, Q, R, S, T, U, V, W, X, Y, Z,Source, Notes, Placement, VendorPrice, VolumePrice, VolumePriceMinimum, VendorProductionMin, VendorProductionLeadTime, 
			DetailYesNo, ImageType, ColorPlacement, Artwork, License, Colorway, CDate, CUser, MDate, MUser, MChange,  SChange, DChange, 
			CChange, Action, StyleMaterialMasterID, Development, MaterialTrack, MaterialLinked, MaterialSort, MaterialLining)
			SELECT @NewStyleMaterialID, MainMaterial, StyleSet, @NewStyleID AS StyleID, UOM, 
			Qty, MaterialPrice, Ext, MaterialSize, MaterialID, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
			ComponentTypeID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S,  T, U, V, W, X, Y, Z,Source, Notes, 
			Placement AS Placement, VendorPrice, VolumePrice, VolumePriceMinimum, VendorProductionMin, VendorProductionLeadTime, DetailYesNo, 
			ImageType, ColorPlacement, Artwork, License, Colorway, @CDate AS CDate, @CUser AS CUser, 
			@CDate AS MDate, @CUser AS MUser, MChange, SChange, DChange, CChange, Action, StyleMaterialMasterID, 
			Development, MaterialTrack, MaterialLinked, MaterialSort, MaterialLining
			FROM dbo.pStyleMaterials
			WHERE StyleMaterialID = @StyleMaterialID
				
			
			SET @Row_Color_Loop = 1
			SET @Row_Color_Count = (SELECT COUNT(*) FROM #tempStyleColorway)
															
			IF @Colorway = 1
			BEGIN
				WHILE @Row_Color_Loop <= @Row_Color_Count
				BEGIN
					
					SELECT @StyleColorID = StyleColorID FROM  #tempStyleColorway WHERE RecID = @Row_Color_Loop
					SELECT @NewStyleColorID = StyleColorID FROM  #tempCopyStyleColorway WHERE RecID = @Row_Color_Loop

					INSERT INTO dbo.#tempCopyStyleColorwayItem
					(StyleColorItemID, StyleColorItemMasterID, StyleColorID, StyleID, StyleSet, StyleMaterialID, MaterialID, MaterialColorID, CDate, CUser, MDate, MUser)
					SELECT newid() AS StyleColorItemID, StyleColorItemMasterID, @NewStyleColorID, @NewStyleID, StyleSet, @NewStyleMaterialID, MaterialID, MaterialColorID, CDate, CUser, MDate, MUser
					FROM  #tempStyleColorwayItem
					WHERE StyleColorID = @StyleColorID AND StyleMaterialID = @StyleMaterialID		
							
					SET @Row_Color_Loop = @Row_Color_Loop + 1
					
				END
			END

		END			
			
		SET @Row_Loop = @Row_Loop + 1
	END -- while
END



BEGIN

	INSERT INTO dbo.pStyleMaterials
	(StyleMaterialID, MainMaterial, StyleSet, StyleID, UOM, Qty, MaterialPrice, Ext, MaterialSize, MaterialID, MaterialImageID, 
	MaterialImageVersion, NoColorMatch, SupplierID, ComponentTypeID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O,
	P, Q, R, S,  T, U, V, W, X, Y, Z,Source, Notes, Placement, VendorPrice, VolumePrice, VolumePriceMinimum, VendorProductionMin, VendorProductionLeadTime, 
	DetailYesNo, ImageType, ColorPlacement, Artwork, License, Colorway, CDate, CUser, MDate, MUser, MChange,  SChange, DChange, 
	CChange, Action, StyleMaterialMasterID, Development, MaterialTrack, MaterialLinked, MaterialSort, MaterialLining)
	SELECT StyleMaterialID, MainMaterial, StyleSet, StyleID, UOM, 
	Qty, MaterialPrice, Ext, MaterialSize, MaterialID, MaterialImageID, MaterialImageVersion, NoColorMatch, SupplierID, 
	ComponentTypeID, MaterialType, MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S,  T, U, V, W, X, Y, Z,Source, Notes, 
	Placement AS Placement, VendorPrice, VolumePrice, VolumePriceMinimum, VendorProductionMin, VendorProductionLeadTime, DetailYesNo, 
	ImageType, ColorPlacement, Artwork, License, Colorway, CDate, CUser, 
	MDate, MUser, MChange, SChange, DChange, CChange, Action, StyleMaterialMasterID, 
	Development, MaterialTrack, MaterialLinked, MaterialSort, MaterialLining
	FROM dbo.#tempCopyStyleMaterials WHERE MaterialLinked = 1
	
	INSERT INTO dbo.pStyleColorway
	(StyleColorID, StyleID, StyleSet, StyleColorStandardID, StyleColorNo, StyleColorName, MainColor, Sort, Version, CDate, CUser, MDate, MUser , CopyStyleColorID, ColorPaletteID)
	SELECT StyleColorID, StyleID, StyleSet, StyleColorStandardID, StyleColorNo, StyleColorName, MainColor, Sort, Version, CDate, CUser, MDate, MUser , CopyStyleColorID, ColorPaletteID
	FROM dbo.#tempCopyStyleColorway
	
	INSERT INTO dbo.pStyleColorwayItem
	(StyleColorItemID, StyleColorItemMasterID, StyleColorID, StyleID, StyleSet, StyleMaterialID, MaterialID, MaterialColorID, CDate, CUser, MDate, MUser)
	SELECT StyleColorItemID, StyleColorItemMasterID, StyleColorID, StyleID, StyleSet, StyleMaterialID, MaterialID, MaterialColorID, CDate, CUser, MDate, MUser
	FROM  dbo.#tempCopyStyleColorwayItem	
	
	
	DECLARE @LinePlanItemID UNIQUEIDENTIFIER
	DECLARE @ColorStatus INT
	
	SELECT @LinePlanItemID = LinePlanItemID FROM pStyleSeasonYear
	WHERE StyleID = @NewStyleID AND SeasonYearID = @SeasonYearID

	IF @LinePlanItemID IS NULL 
	BEGIN
		SET @ColorStatus = 800
	END 
	ELSE 
	BEGIN
		SET @ColorStatus = 100
	END 
	
	INSERT INTO pStyleColorwaySeasonYear( StyleColorwaySeasonYearID , StyleSeasonYearID , StyleColorwayID , StyleID,  
	MUser, MDate, StyleColorDelivery1, StyleColorDelivery2, StyleColorDelivery3, StyleColorDelivery4, StyleColorDelivery5,
	SampleStatus, StyleColorStatus)
	SELECT  NEWID() AS StyleColorwaySeasonYearID, @NewStyleSeasonYearID, StyleColorID , StyleID , 
	@CUser, @CDate, 1, 1, 1, 1, 1, @ColorStatus, @ColorStatus
	FROM  #tempCopyStyleColorway 

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07266', GetDate())
GO
