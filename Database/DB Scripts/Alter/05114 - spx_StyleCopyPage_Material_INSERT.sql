IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCopyPage_Material_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCopyPage_Material_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_StyleCopyPage_Material_INSERT](
	@TransactionID UNIQUEIDENTIFIER,
	@StyleID UNIQUEIDENTIFIER,
	@NewStyleID UNIQUEIDENTIFIER,
	@SrcStyleID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
)
AS


CREATE TABLE #tempStyleMaterials (
	RecID INT IDENTITY(1,1)  NOT NULL,
	StyleMaterialID  UNIQUEIDENTIFIER ROWGUIDCOL  NOT NULL ,
	StyleMaterialMasterID UNIQUEIDENTIFIER,
	Colorway NVARCHAR (3),
)


CREATE TABLE #tempCopyStyleMaterials (
	RecID INT IDENTITY(1,1)  NOT NULL,
	StyleMaterialID  UNIQUEIDENTIFIER ROWGUIDCOL  NOT NULL,
	StyleMaterialCopyID UNIQUEIDENTIFIER
)

CREATE TABLE #tempStyleColorway (
	RecID INT IDENTITY(1,1)  NOT NULL,
	StyleColorID  UNIQUEIDENTIFIER ROWGUIDCOL  NOT NULL,
	ColorPaletteID UNIQUEIDENTIFIER
	
) 

CREATE TABLE #tempCopyStyleColorway (
	RecID INT IDENTITY(1,1)  NOT NULL,
	StyleColorID  UNIQUEIDENTIFIER ROWGUIDCOL  NOT NULL ,
	CopyStyleColorID UNIQUEIDENTIFIER 
) 

CREATE TABLE #tempStyleColorwayItem (
	RecID INT IDENTITY(1,1)  NOT NULL,
	StyleColorItemID  UNIQUEIDENTIFIER,
	StyleColorItemMasterID UNIQUEIDENTIFIER, 
	StyleColorID UNIQUEIDENTIFIER,
	StyleID UNIQUEIDENTIFIER,
	StyleSet INT,
	StyleMaterialID UNIQUEIDENTIFIER,
	MaterialID UNIQUEIDENTIFIER,
	MaterialColorID UNIQUEIDENTIFIER
) 

CREATE TABLE #tempCopyStyleColorwayItem (
	RecID INT IDENTITY(1,1)  NOT NULL,
	StyleColorItemID  UNIQUEIDENTIFIER,
	StyleColorItemMasterID UNIQUEIDENTIFIER, 
	StyleColorID UNIQUEIDENTIFIER,
	StyleID UNIQUEIDENTIFIER,
	StyleSet INT,
	StyleMaterialID UNIQUEIDENTIFIER,
	MaterialID UNIQUEIDENTIFIER,
	MaterialColorID UNIQUEIDENTIFIER
) 


DECLARE @Row_Count INT
DECLARE @Row_Loop INT
DECLARE @Row_Color_Count INT
DECLARE @Row_Color_Loop INT
DECLARE @StyleCopyType VARCHAR(50)


--** Include colorways no existing in the style
INSERT INTO #tempStyleColorway(StyleColorID, ColorPaletteID)
SELECT a.StyleColorID, a.ColorPaletteID
FROM pStyleColorway a WITH (NOLOCK)
	INNER JOIN pStyleCopyColorTmp b WITH (NOLOCK) ON a.StyleColorID = b.StyleColorID
WHERE a.StyleID = @StyleID
	AND b.TransactionID = @TransactionID
	--AND a.ColorPaletteID NOT IN (
	--	SELECT ColorPaletteID FROM dbo.pStyleColorway WITH(NOLOCK) WHERE StyleID = @NewStyleID
	--)
	


DECLARE 
	@StyleColorID UNIQUEIDENTIFIER,	
	@NewStyleColorID UNIQUEIDENTIFIER,
	@ColorPaletteID UNIQUEIDENTIFIER

SET @Row_Loop = 1
SET @Row_Count = (SELECT COUNT(*) FROM #tempStyleColorway)

WHILE @Row_Loop <= @Row_Count 
BEGIN
	SELECT @StyleColorID = StyleColorID, @ColorPaletteID = ColorPaletteID 
	FROM  #tempStyleColorway WHERE RecID = @Row_Loop

	-- ** Check if colorway exist?
	SET @NewStyleColorID = NULL
	
	SELECT @NewStyleColorID = StyleColorID  FROM pStyleColorway WITH(NOLOCK) 
	WHERE StyleID = @NewStyleID AND ColorPaletteID = @ColorPaletteID
	
	IF @NewStyleColorID IS NULL
		SET @NewStyleColorID = NEWID()
		
	--** New Colorways, keeping track of original in CopyStyleColorID 
	INSERT INTO #tempCopyStyleColorway(
		StyleColorID, CopyStyleColorID)
	SELECT 
		@NewStyleColorID, a.StyleColorID
	FROM pStyleColorway a WITH (NOLOCK)
	WHERE a.StyleColorID = @StyleColorID 

	SET @Row_Loop = @Row_Loop + 1
END


--** Original Colorway items !!
INSERT INTO #tempStyleColorwayItem(
	StyleColorItemID, StyleColorItemMasterID, StyleColorID, StyleID, StyleSet, StyleMaterialID, MaterialID, 
	MaterialColorID)
SELECT 
	a.StyleColorItemID, a.StyleColorItemMasterID, a.StyleColorID, a.StyleID, a.StyleSet, a.StyleMaterialID, a.MaterialID, 
	a.MaterialColorID
FROM  pStyleColorwayItem a WITH (NOLOCK)
	INNER JOIN pStyleCopyColorTmp b WITH(NOLOCK) ON a.StyleColorID = b.StyleColorID 
	INNER JOIN dbo.pStyleColorway c WITH(NOLOCK) ON c.StyleColorID =  a.StyleColorID
WHERE a.StyleID = @StyleID
	AND  b.TransactionID =  @TransactionID
	--AND c.ColorPaletteID NOT IN (
	--	SELECT ColorPaletteID FROM dbo.pStyleColorway WITH(NOLOCK) WHERE StyleID = @NewStyleID
	--)	

UPDATE #tempStyleColorwayItem
SET StyleColorItemMasterID = NEWID()
WHERE StyleColorItemMasterID IS NULL

		
BEGIN

	INSERT INTO #tempStyleMaterials	(StyleMaterialMasterID, StyleMaterialID, Colorway)
	SELECT StyleMaterialMasterId, StyleMaterialID, Colorway
	FROM pStyleMaterials WITH (NOLOCK)
	WHERE StyleID = @StyleID
		AND MaterialID NOT IN ( SELECT MaterialID FROM dbo.pStyleMaterials WITH(NOLOCK) WHERE StyleID = @NewStyleID) 


	DECLARE @StyleMaterialMasterID UNIQUEIDENTIFIER
	DECLARE @StyleMaterialID UNIQUEIDENTIFIER
	DECLARE @NewStyleMaterialID UNIQUEIDENTIFIER
	DECLARE @Colorway NVARCHAR(3)

	SET @Row_Loop = 1
	SET @Row_Count = (SELECT COUNT(*) FROM #tempStyleMaterials)
	
	WHILE @Row_Loop <= @Row_Count 
	BEGIN
		SELECT @StyleMaterialMasterID = StyleMaterialMasterID, @StyleMaterialID = StyleMaterialID, @Colorway = Colorway 
		FROM #tempStyleMaterials WHERE RecID = @Row_Loop
		
		BEGIN
			-- New StyleMaterial in temp table 
			SET @NewStyleMaterialID = NEWID()
			INSERT INTO #tempCopyStyleMaterials(StyleMaterialID, StyleMaterialCopyID)
			SELECT @NewStyleMaterialID, StyleMaterialID
			FROM pStyleMaterials WITH (NOLOCK)
			WHERE StyleMaterialID = @StyleMaterialID
				
			---Style Colorway--------------------------------------------
			SET @Row_Color_Loop = 1
			SET @Row_Color_Count = (SELECT COUNT(*) FROM #tempStyleColorway)
														
			IF @Colorway = 1
			BEGIN
				WHILE @Row_Color_Loop <= @Row_Color_Count
				BEGIN
							
					SELECT @StyleColorID = StyleColorID FROM  #tempStyleColorway WHERE RecID = @Row_Color_Loop
					SELECT @NewStyleColorID = StyleColorID FROM  #tempCopyStyleColorway WHERE RecID = @Row_Color_Loop
					
					INSERT INTO #tempCopyStyleColorwayItem(
						StyleColorItemID, StyleColorItemMasterID, StyleColorID, StyleID, StyleSet, 
						StyleMaterialID, MaterialID, MaterialColorID)
					SELECT 
						NEWID() AS StyleColorItemID, StyleColorItemMasterID, @NewStyleColorID, @NewStyleID, StyleSet, 
						@NewStyleMaterialID, MaterialID, MaterialColorID
					FROM  #tempStyleColorwayItem
					WHERE StyleColorID = @StyleColorID AND StyleMaterialID = @StyleMaterialID		
							
					SET @Row_Color_Loop = @Row_Color_Loop + 1
				END
			END
		END			
		SET @Row_Loop = @Row_Loop + 1
	END
END


	INSERT INTO pStyleMaterials (
		StyleMaterialID, MainMaterial, StyleSet, StyleID, UOM, Qty, MaterialPrice, Ext, MaterialSize, MaterialID, MaterialImageID, 
		MaterialImageVersion, NoColorMatch, SupplierID, ComponentTypeID, MaterialType, MaterialNo, MaterialName, 
		A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S,  T, U, V, W, X, Y, Z,
		Source, Notes, Placement, VendorPrice, VolumePrice, VolumePriceMinimum, VendorProductionMin, VendorProductionLeadTime, 
		DetailYesNo, ImageType, ColorPlacement, Artwork, License, Colorway, CDate, CUser, MDate, MUser, MChange,  SChange, DChange, 
		CChange, Action, StyleMaterialMasterID, Development, MaterialTrack, MaterialLinked, MaterialSort, MaterialLining, CopyStyleMaterialID, 
		MaterialSizeID, TradePartnerID, TradePartnerVendorID )
	SELECT 
		a.StyleMaterialID, 
		--CASE	
		--	WHEN @SrcStyleID = StyleID THEN ISNULL(MainMaterial,0)
		--	ELSE 0
		--END AS MainMaterial,
		ISNULL(MainMaterial,0) AS MainMaterial, 
		StyleSet, @NewStyleID AS StyleID, UOM, Qty, MaterialPrice, Ext, MaterialSize, MaterialID, MaterialImageID, 
		MaterialImageVersion, NoColorMatch, SupplierID, ComponentTypeID, MaterialType, MaterialNo, MaterialName, 
		A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S,  T, U, V, W, X, Y, Z,
		Source, Notes, Placement, VendorPrice, VolumePrice, VolumePriceMinimum, VendorProductionMin, VendorProductionLeadTime, 
		DetailYesNo, ImageType, ColorPlacement, Artwork, License, Colorway, @CDate, @CUser, @CDate, @CUser, MChange, SChange, DChange, 
		CChange, Action, StyleMaterialMasterID, Development, MaterialTrack, MaterialLinked, MaterialSort, MaterialLining , CopyStyleMaterialID, 
		MaterialSizeID, TradePartnerID, TradePartnerVendorID
	FROM #tempCopyStyleMaterials a
		INNER JOIN pStyleMaterials b ON b.stylematerialID = a.StyleMaterialCopyID


	INSERT INTO dbo.pStyleColorway(
		StyleColorID, StyleID, StyleSet, StyleColorStandardID, StyleColorNo, StyleColorName, MainColor, Sort, Version, 
		CDate, CUser, MDate, MUser , 
		CopyStyleColorID , ColorPaletteID, SAPCode, PLMCode)
	SELECT 
		a.StyleColorID, @NewStyleID AS StyleID, StyleSet, StyleColorStandardID, StyleColorNo, StyleColorName, MainColor, Sort, Version, 
		@CDate, @CUser, @CDate, @CUser, 
		b.CopyStyleColorID, ColorPaletteID, SAPCode, PLMCode
	FROM #tempCopyStyleColorway a
		INNER JOIN dbo.pStyleColorway b WITH (NOLOCK) ON a.CopyStyleColorID = b.StyleColorID
	WHERE a.StyleColorID NOT IN(  
		SELECT StyleColorID FROM pStylecolorway WHERE StyleID =  @NewStyleID 
	)
		
	
	INSERT INTO dbo.pStyleColorwayItem(
		StyleColorItemID, StyleColorItemMasterID, StyleColorID, StyleID, StyleSet, StyleMaterialID, MaterialID, MaterialColorID, 
		CDate, CUser, MDate, MUser)
	SELECT 
		StyleColorItemID, StyleColorItemMasterID, StyleColorID, @NewStyleID AS StyleID, StyleSet, StyleMaterialID, MaterialID, MaterialColorID, 
		@CDate, @CUser, @CDate, @CUser
	FROM  #tempCopyStyleColorwayItem	

	DECLARE @StyleMaterialIDTmp  AS UNIQUEIDENTIFIER   

	SELECT TOP 1 @StyleMaterialIDTmp = StyleMaterialID FROM pStyleMaterials WITH (NOLOCK) 
	WHERE StyleID = @NewStyleID AND MainMaterial = 1 

	UPDATE pStyleHeader SET StyleMaterialID = @StyleMaterialIDTmp
	WHERE StyleID = @NewStyleID


BEGIN
	DROP TABLE #tempStyleMaterials
	DROP TABLE #tempCopyStyleMaterials
	DROP TABLE #tempStyleColorway
	DROP TABLE #tempCopyStyleColorway
	DROP TABLE #tempStyleColorwayItem
	DROP TABLE #tempCopyStyleColorwayItem
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05114', GetDate())
GO
