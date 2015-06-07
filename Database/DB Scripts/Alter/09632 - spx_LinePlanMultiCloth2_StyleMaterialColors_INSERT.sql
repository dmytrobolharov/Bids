IF OBJECT_ID(N'[dbo].[spx_LinePlanMultiCloth2_StyleMaterialColors_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_LinePlanMultiCloth2_StyleMaterialColors_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_LinePlanMultiCloth2_StyleMaterialColors_INSERT](
	@LinePlanColorGroupID UNIQUEIDENTIFIER, 
	@LinePlanRangeID  UNIQUEIDENTIFIER, 
	@MaterialCoreID UNIQUEIDENTIFIER, 
	@CUser NVARCHAR(200),
	@CDate DATETIME,
	@NewLinePlanItemID UNIQUEIDENTIFIER 
)
AS 

---DECLARE @StyleID UNIQUEIDENTIFIER 
DECLARE @MaterialID UNIQUEIDENTIFIER 
DECLARE @NewStyleID UNIQUEIDENTIFIER 
DECLARE @TOTAL INT
DECLARE @ROWID INT 


-- ***
-- ** Insert styles to Lineplan
-- ***
DECLARE @LinePlanItemID UNIQUEIDENTIFIER 
DECLARE @LinePlanID UNIQUEIDENTIFIER 
DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER 
DECLARE @Season NVARCHAR(200)
DECLARE @Year NVARCHAR(200)
DECLARE @SeasonYearID UNIQUEIDENTIFIER 

--***
--** Get SeasonYear ID
--***
SELECT @LinePlanID = a.LinePlanID, @Season = RTRIM(LTRIM(b.Season)), @Year = RTRIM(LTRIM(b.Year))
FROM pLinePlanRange a WITH(NOLOCK)
	INNER JOIN pLinePlan b WITH(NOLOCK) ON a.LinePlanID = b.LinePlanID 
WHERE a.LinePlanRangeID = @LinePlanRangeID	


SELECT @SeasonYearID = SeasonYearID
FROM pSeasonYear WITH(NOLOCK)
WHERE Season = @Season AND Year = @Year 

IF @SeasonYearID IS NULL 
BEGIN
	SET @SeasonYearID  =  NEWID() 

	INSERT INTO pSeasonYear ( SeasonYearID, Season, Year )
	VALUES (@SeasonYearID, @Season, @Year )
END 


--***
--** Get Styles
--***
CREATE TABLE  #s(
RowID INT IDENTITY (1,1),
StyleID UNIQUEIDENTIFIER, 
NewStyleID UNIQUEIDENTIFIER DEFAULT NEWID()
)


IF (SELECT  COUNT(*) FROM pLinePlanMultiCloth2ColorTemp WITH(NOLOCK)WHERE LinePlanColorGroupID = @LinePlanColorGroupID AND MaterialCoreColorID  IS NOT NULL) = 0
	BEGIN
		INSERT INTO #s(StyleID)
		SELECT DISTINCT MaterialID 
		FROM pLinePlanMultiCloth2MaterialTemp WITH(NOLOCK)
		WHERE LinePlanColorGroupID = @LinePlanColorGroupID
	END
ELSE
	BEGIN
		INSERT INTO #s(StyleID)
		SELECT DISTINCT MaterialID 
		FROM pLinePlanMultiCloth2ColorTemp WITH(NOLOCK)
		WHERE LinePlanColorGroupID = @LinePlanColorGroupID
			AND MaterialCoreColorID  IS NOT NULL
			--AND MaterialCoreColorID <> '00000000-0000-0000-0000-000000000000' 
	END



SELECT @TOTAL = COUNT(*) FROM #s 
SET @ROWID = 1

--SELECT * FROM #s 

WHILE @ROWID <= @TOTAL
BEGIN
	SELECT @MaterialID = StyleID , @NewStyleID = NewStyleID 
	FROM #s WHERE RowID = @ROWID


	CREATE TABLE #sm ( 
		RowID INT IDENTITY(1,1),
		StyleMaterialID UNIQUEIDENTIFIER DEFAULT NEWID(),
		StyleID UNIQUEIDENTIFIER,
		SeasonYearID UNIQUEIDENTIFIER,
		MaterialID UNIQUEIDENTIFIER,
		MainMaterial INT, 
		MaterialCoreItemID UNIQUEIDENTIFIER, 
		[UOM] [nvarchar](50) Collate SQL_Latin1_General_CP1_CI_AS NULL, --#01
		[Qty] [decimal](18,2), 
		[MaterialPrice] [money] NULL,
		[Ext] [money] NULL,
		[MaterialSize] [nvarchar](100) Collate SQL_Latin1_General_CP1_CI_AS NULL, --#01
		[Placement] [nvarchar](4000) Collate SQL_Latin1_General_CP1_CI_AS NULL, --#01
		[Artwork] [int] NULL,
		[License] [int] NULL,
		[Colorway] [int] NULL,
		MultiCloth INT DEFAULT(0),		-- #01
		MaterialSwing INT,		-- #01
		SecondaryMain INT,		-- #01
		SecondaryLining INT,		-- #01
		Branding INT,		-- #01
		Lining INT,		-- #01
		BBUsage NVARCHAR(200)
	)

	CREATE TABLE #scw(
		StyleColorID UNIQUEIDENTIFIER DEFAULT NEWID(),
		StyleID UNIQUEIDENTIFIER, 
		ColorPaletteID UNIQUEIDENTIFIER,
		MaterialCoreColorID UNIQUEIDENTIFIER ,
		LinePlanMultiCloth2ColorTempID UNIQUEIDENTIFIER 
	) 

	CREATE TABLE #scwi (
		RowID INT IDENTITY(1,1),
		MainMaterial INT ,
		StyleColorID UNIQUEIDENTIFIER,
		StyleMaterialID UNIQUEIDENTIFIER,
		MaterialColorID UNIQUEIDENTIFIER,
		ColorPaletteID UNIQUEIDENTIFIER,
		MaterialCoreItemID UNIQUEIDENTIFIER,
		MaterialCoreColorID UNIQUEIDENTIFIER, 
		MaterialCoreColorItemID UNIQUEIDENTIFIER,
		LinePlanMultiCloth2ColorTempID UNIQUEIDENTIFIER 
	)


	CREATE TABLE #SCWsy (
		RowID INT IDENTITY(1,1),
		StyleColorID UNIQUEIDENTIFIER,
		StyleID UNIQUEIDENTIFIER,
		StyleColorDelivery1 INT, 
		StyleColorDelivery2 INT, 
		StyleColorDelivery3 INT, 
		StyleColorDelivery4 INT,
		StyleColorDelivery5 INT, 
		Units INT,
		ColorType NVARCHAR(5) 
	)



	--***	
	--** Get SizeRange , SizeClass from body
	--***
	DECLARE @SizeClass NVARCHAR(400)
	DECLARE @SizeClassId UNIQUEIDENTIFIER
	DECLARE @SizeRange NVARCHAR(200)
	DECLARE @SizeRangeId UNIQUEIDENTIFIER

	SELECT TOP 1 @SizeClass = c.SizeClass, @SizeClassId = sc.CustomID,
	             @SizeRange = c.SizeRange, @SizeRangeId = sr.CustomId
	FROM pLinePlanMultiCloth2BodyTemp a WITH(NOLOCK)
		INNER JOIN pLinePlanBodyItem b WITH(NOLOCK) ON  a.LinePlanBodyItemID = b.LinePlanBodyItemID
		INNER JOIN pBody c WITH(NOLOCK) ON c.BodyID = b.BodyID 
		LEFT JOIN pSizeClass sc ON sc.Custom = c.SizeClass
		LEFT JOIN pSizeRange sr ON sr.SizeRangeCode = c.SizeRange
	WHERE LinePlanColorGroupID = @LinePlanColorGroupID


	--***
	--** Insert Style ID 
	--***
	INSERT INTO pStyleHeader (StyleID, StyleLinkID)  VALUES (@NewStyleID, @LinePlanColorGroupID)

	--***
	--** Insert Main Style Materials
	--***
	INSERT INTO #sm( StyleMaterialID, StyleID , MaterialID, MainMaterial, MaterialCoreItemID, SeasonYearID, MultiCloth, BBUsage) 
	VALUES (NEWID(), @NewStyleID,@MaterialID, 1 , NULL, @SeasonYearID, 0, '900') --MainMaterial Usage
	
	--*** 
	--**Update pStyleHeader with Main Material, and MaterialGroup 
	--***
	UPDATE pStyleHeader SET 
		MaterialID = pMaterial.MaterialID,
		MaterialNo= pMaterial.MaterialNo,
		MaterialName = pMaterial.MaterialName,
		MaterialImageID = pMaterial.MaterialImageID,
		MaterialImageVersion = pMaterial.MaterialImageVersion,
		MaterialCoreID  = @MaterialCoreID,
		SizeClass = @SizeClass,
		SizeClassId = @SizeClassId,
		SizeRange = @SizeRange,
		SizeRangeId = @SizeRangeId
	FROM pMaterial WHERE pMaterial.MaterialID = @MaterialID	
		AND pStyleHeader.StyleID = @NewStyleId


	IF @MaterialCoreID IS NOT NULL AND @MaterialCoreID <> '00000000-0000-0000-0000-000000000000'
	BEGIN
		INSERT INTO #sm( StyleID , MaterialID, MainMaterial, MaterialCoreItemID, UOM, Qty, MaterialPrice, Ext, MaterialSize, Placement, Artwork, License, Colorway, SeasonYearID, MultiCloth )
		--, MaterialSwing, SecondaryMain, SecondaryLining, Branding, Lining, BBUsage) 		-- #01
		SELECT @NewStyleID, MaterialID , 0, MaterialCoreItemID, UOM, 
		CASE 
			WHEN QTY IS NULL OR LTRIM(RTRIM(QTY)) = '' THEN  NULL
			ELSE 
				QTY
		END as qty
		, 
		MaterialPrice, Ext, MaterialSize, Placement, Artwork, License, Colorway, @SeasonYearID, 1
		--, MaterialSwing, SecondaryMain, SecondaryLining, Branding, Lining, BBUsage 		-- #01
		FROM pMaterialCoreItem WITH(NOLOCK) WHERE MaterialCoreID = @MaterialCoreID
		
		
		
	END 


	-- ***
	-- ** Insert Style Colorways
	-- ** LinePlanColorItemID = ColorPaletteID 
	-- ***
	INSERT INTO #scw (StyleID ,ColorPaletteID, MaterialCoreColorID, LinePlanMultiCloth2ColorTempID) 
	SELECT DISTINCT @NewStyleID, ColorPaletteID, MaterialCoreColorID, LinePlanMultiCloth2ColorTempID
	FROM pLinePlanMultiCloth2ColorTemp WITH(NOLOCK)	
	WHERE MaterialID = @MaterialID 
		AND LinePlanColorGroupID = @LinePlanColorGroupID
		AND MaterialCoreColorID IS NOT NULL 
		AND MaterialCoreColorID <> '00000000-0000-0000-0000-000000000000' 


	-- ***
	-- ** Insert Style Colorways Items
	-- ***
	INSERT INTO #scwi ( MainMaterial, StyleMaterialID, StyleColorID, ColorPaletteID, MaterialCoreItemID, MaterialCoreColorID, LinePlanMultiCloth2ColorTempID )
	SELECT a.MainMaterial, a.StyleMaterialID, b.StyleColorID, b.ColorPaletteID, a.MaterialCoreItemID, b.MaterialCoreColorID , b.LinePlanMultiCloth2ColorTempID
	FROM #sm a
	CROSS JOIN #scw b

	DECLARE @MainMaterial INT 
	DECLARE @StyleMaterialID UNIQUEIDENTIFIER 
	DECLARE @StyleColorID UNIQUEIDENTIFIER 
	DECLARE @ColorPaletteID UNIQUEIDENTIFIER 
	DECLARE @MaterialCoreItemID  UNIQUEIDENTIFIER 
	DECLARE @MaterialGroupColorID UNIQUEIDENTIFIER
	DECLARE @MaterialColorID  UNIQUEIDENTIFIER
	DECLARE @MaterialCoreColorID  UNIQUEIDENTIFIER
	DECLARE @MaterialCoreColorItemID  UNIQUEIDENTIFIER
	DECLARE @LinePlanMultiCloth2ColorTempID UNIQUEIDENTIFIER

	DECLARE @iTOTAL INT
	DECLARE @iROW INT

	SET @iROW = 1 
	SELECT @iTOTAL = COUNT(*) FROM  #scwi

	WHILE @iROW <= @iTOTAL 
	BEGIN
		SELECT @MainMaterial = MainMaterial, @StyleMaterialID = StyleMaterialID, @MaterialCoreColorID = MaterialCoreColorID, 
			@StyleColorID = StyleColorID, @ColorPaletteID = ColorPaletteID, @MaterialCoreItemID = MaterialCoreItemID,
			@LinePlanMultiCloth2ColorTempID = LinePlanMultiCloth2ColorTempID
		FROM #scwi WHERE RowID = @iROW 


		SET @MaterialColorID = NULL
		SET @MaterialCoreColorItemID = (SELECT TOP 1 MaterialCoreColorItemID 
			FROM pMaterialCoreColorItem WITH(NOLOCK) WHERE MaterialCoreColorID = @MaterialCoreColorID 
				AND MaterialCoreItemID = @MaterialCoreItemID)

		IF  @MainMaterial = 1 
			SELECT TOP 1 @MaterialColorID = MaterialColorID FROM pLinePlanMultiCloth2ColorTemp  WITH(NOLOCK)
			WHERE MaterialID = @MaterialID AND ColorPaletteID = @ColorPaletteID 
				AND LinePlanColorGroupID = @LinePlanColorGroupID 
		ELSE
		BEGIN
			--*** Get Materialcolor from pLinePlanMultiCloth2MaterialGroupItemTemp
			SELECT TOP 1 @MaterialColorID = MaterialColorID FROM pLinePlanMultiCloth2MaterialGroupItemTemp WITH(NOLOCK)
			WHERE LinePlanColorGroupID = @LinePlanColorGroupID
				AND LinePlanMultiCloth2ColorTempID = @LinePlanMultiCloth2ColorTempID
				AND MaterialCoreItemID = @MaterialCoreItemID

		END 


		BEGIN
			UPDATE #scwi SET 
				MaterialColorID = @MaterialColorID, 
				MaterialCoreColorItemID = @MaterialCoreColorItemID 
			WHERE RowID = @iROW
		END
		SET @iROW = @iROW + 1 
	END 

	--Insert StyleMaterial from MaterialGroup
	--pStylematerials.MaterialCoreItemId will group style material
	--IF Conversion failed when converting from a character string to uniqueidentifier. Check the MaterialSizeID
	INSERT INTO pStyleMaterials ( StyleMaterialID , StyleMaterialMasterID, MainMaterial,StyleSet, StyleID, 
		MaterialID , MaterialImageID , 
		MaterialImageVersion, MaterialType, MaterialNo, MaterialName, 
		A,B, C, D ,E, F, G,H, I, J , K, L, M , N, O, P, Q, R, S, T, 
		U, V,W, X, Y, Z, Notes, CUser, CDate,MUser,
		MDate, MChange, Colorway,
		UOM, Qty, MaterialPrice, Ext, 
		MaterialSize, Placement, Artwork, License, 
		StyleMaterialLinkID, MultiCloth, 
		MaterialSizeID
		, MaterialSwing,
		-- SecondaryMain, SecondaryLining, Branding,
		  MaterialLining, 
		 -- BBUsage, 
		 MaterialCoreItemID)		-- #01
	SELECT  sm.StyleMaterialID, NEWID() AS StyleMaterialMasterID, sm.MainMaterial, 1 AS StyleSet, sm.StyleID, 
	a.MaterialID, ISNULL(a.MaterialImageID,'00000000-0000-0000-0000-000000000000') AS MaterialImageID, 
	  ISNULL(a.MaterialImageVersion,1) AS MaterialImageVersion, a.MaterialType, a.MaterialNo, a.MaterialName, 
	  a.A, a.B, a.C, a.D, a.E, a.F, a.G, a.H, a.I, a.J, a.K, a.L, a.M, a.N, a.O, a.P, a.Q, a.R, a.S, a.T, 
	  a.U, a.V, a.W, a.X, a.Y, a.Z, a.Notes, @CUser AS CUser, @CDate AS CDate, @CUser AS MUser, 
	  @CDate AS MDate, a.MChange, 1 AS Colorway, 
	  a.UOM, ISNULL(sm.Qty, 0) AS Qty, ISNULL(sm.MaterialPrice, 0) AS MaterialPrice, sm.Ext, 
	  sm.MaterialSize, sm.Placement,  ISNULL(sm.Artwork, 0) AS Artwork, ISNULL(sm.License, 0) AS License, 
	  sm.MaterialCoreItemID, MultiCloth,
	  b.MaterialSizeID
		, sm.MaterialSwing, 
		--sm.SecondaryMain, sm.SecondaryLining, sm.Branding, 
		sm.Lining, 
		--sm.BBUsage, 
		sm.MaterialCoreItemID --BBUsage		-- #01
	FROM #sm sm 
		INNER JOIN pMaterial AS a WITH(NOLOCK) ON sm.MaterialID = a.MaterialID
		LEFT OUTER JOIN pMaterialSize b WITH(NOLOCK) ON (b.MaterialID = sm.MaterialID AND b.MaterialSize = sm.MaterialSize)

	--***
	--** Insert Stylecolor records
	--***	
	INSERT INTO pStyleColorway ( StyleColorID , StyleID , StyleSet, StyleColorNo, StyleColorName, MainColor, Version, 
	CDate, CUser, MDate, MUser, ColorPaletteID ) 
	SELECT scw.StyleColorID, scw.StyleID , 1, b.ColorCode, b.ColorName, b.ColorName, 1, 
	@CDate ,@CUser,@CDate, @CUser, scw.ColorPaletteID
	FROM #scw scw
	INNER JOIN pColorPalette b WITH(NOLOCK) ON b.ColorPaletteID =  scw.ColorPaletteID


	INSERT INTO pStyleColorwayItem ( StyleColorItemID, StyleColorID , StyleID , StyleSet, StyleMaterialID, MaterialID, 
	MaterialColorID, CDate, CUser, MDate, MUser, MaterialCoreColorItemID) 
	SELECT NEWID() , a.StyleColorID, b.StyleID , 1, a.StyleMaterialID , c.MaterialID, 
	a.MaterialColorID ,@CDate, @CUser, @CDate, @CUser, a.MaterialCoreColorItemID 
	FROM #scwi a
		INNER JOIN #scw b ON a.StyleColorID = b.StyleColorID 
		INNER JOIN #sm c ON c.StyleMaterialID = a.StyleMaterialID 


	--***
	--** Get Lineplanitem
	--***
	DECLARE @LinePlanStyleAttributeItemID UNIQUEIDENTIFIER 
	SELECT @LinePlanStyleAttributeItemID = LinePlanStyleAttributeItemID 
	FROM pLinePlanItem WITH(NOLOCK)
	WHERE LinePlanItemID = @NewLinePlanItemID 

	IF @LinePlanStyleAttributeItemID = '00000000-0000-0000-0000-000000000000' 
		SET @LinePlanStyleAttributeItemID = NULL

	SET @LinePlanItemID =  NULL

	IF @LinePlanStyleAttributeItemID IS NULL 
	BEGIN
		SELECT TOP 1 @LinePlanItemID = a.LinePlanItemID 
		FROM pLinePlanItem a WITH(NOLOCK)
		WHERE a.LinePlanRangeID = @LinePlanRangeID 
			AND a.StyleID = '00000000-0000-0000-0000-000000000000'
			AND a.LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003'
			AND (a.LinePlanStyleAttributeItemID IS NULL OR a.LinePlanStyleAttributeItemID = '00000000-0000-0000-0000-000000000000')
	END 
	ELSE
	BEGIN
		SELECT TOP 1 @LinePlanItemID = a.LinePlanItemID 
		FROM pLinePlanItem a WITH(NOLOCK)
		WHERE a.LinePlanRangeID = @LinePlanRangeID 
			AND a.StyleID = '00000000-0000-0000-0000-000000000000'
			AND a.LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003'		
			AND a.LinePlanStyleAttributeItemID = @LinePlanStyleAttributeItemID
	END 



	IF @LinePlanItemID IS NULL 
	BEGIN
		SET @LinePlanItemID  = NEWID()

		INSERT INTO  pLinePlanItem (StyleID, LinePlanItemID , LinePlanRangeID , LinePlanRangeTypeID, LinePlanID,  CUser, CDate, MUser, MDate, LinePlanStyleAttributeItemID )
		SELECT  @NewStyleID, @LinePlanItemID , a.LinePlanRangeID , '00000000-0000-0000-0000-000000000003', a.LinePlanID, @CUser, @CDate, @CUser, @CDate, @LinePlanStyleAttributeItemID
		FROM pLinePlanRange a WITH(NOLOCK)
		WHERE A.LinePlanRangeID = @LinePlanRangeID 
	END 
	ELSE
	BEGIN 
		UPDATE pLinePlanItem SET StyleID = @NewStyleID, MUser =@CUser, MDate = @CDate 
		WHERE LinePlanItemID = @LinePlanItemID 	
	END 


	--***
	--** Insert Style SeasonYear 
	--***
	SET @StyleSeasonYearID = NEWID() 

	INSERT INTO pStyleSeasonYear (StyleSeasonYearID , StyleID , StyleSeason, StyleYear, 
		CUser, CDate, MUser, MDate, SeasonYearID,LinePlanID, LinePlanItemID )
	VALUES ( @StyleSeasonYearID , @NewStyleID, @Season, @Year, 
		@CUser, @CDate, @CUser, @CDate, @SeasonYearID, @LinePlanID , @LinePlanItemID )  

	--***
	--** Insert StyleColorway / SeasonYear 
	--***	
	INSERT INTO #SCWsy ( StyleColorID, StyleID, StyleColorDelivery1, StyleColorDelivery2, StyleColorDelivery3,
	StyleColorDelivery4, --StyleColorDelivery5, 
	Units, ColorType )
	SELECT b.StyleColorID, b.StyleID
	,a.StyleColorDelivery1, a.StyleColorDelivery2, a.StyleColorDelivery3, a.StyleColorDelivery4,--a.StyleColorDelivery5, 
	a.Units, a.ColorType   
	FROM pLinePlanMultiCloth2ColorTemp a WITH(NOLOCK)
		INNER JOIN #scw b ON a.ColorPaletteID  = b.ColorPaletteID
	WHERE a.MaterialID = @MaterialID AND a.LinePlanColorGroupID = @LinePlanColorGroupID 
	GROUP BY b.StyleColorID, b.StyleID
	,a.StyleColorDelivery1, a.StyleColorDelivery2, a.StyleColorDelivery3, a.StyleColorDelivery4,--a.StyleColorDelivery5,
	a.Units, a.ColorType  

	--***
	--** StyleColorway / SeasonYear / Logic Update
	--***		
	--DECLARE @SCWSY_ROW INT
	--DECLARE @SCWSY_TOTAL INT
	--DECLARE @D1 INT
	--DECLARE @D2 INT
	--DECLARE @D3 INT
	--DECLARE @D4 INT
	--DECLARE @D5 INT

	--SET @SCWSY_ROW = 1 
	--SELECT @SCWSY_TOTAL = COUNT(*) FROM #SCWsy 


	--WHILE @SCWSY_ROW <= @SCWSY_TOTAL
	--BEGIN
	--	SELECT @D1=StylecolorDelivery1, @D2=StylecolorDelivery2, @D3=StylecolorDelivery3,
	--	@D4=StylecolorDelivery4,@D5=StylecolorDelivery5
	--	FROM #SCWsy WHERE RowID = @SCWSY_ROW

	--	IF @D5 = 1
	--		SELECT @D1=1, @D2=1, @D3=1, @D4=0, @D5=0
	--	ELSE IF @D4 = 1
	--		SELECT @D1=0, @D2=0, @D3=0, @D5=0
	--	ELSE IF @D1 = 1 
	--		SELECT @D2=1, @D3=1 , @D4 = 0, @D5 = 0
	--	ELSE IF @D2 = 1 
	--		SELECT @D1 = 0, @D3 = 1, @D4 = 0, @D5 = 0
	--	ELSE IF @D3 = 1
	--		SELECT @D1 = 0, @D2 = 0, @D4 = 0, @D5 = 0

	--	UPDATE #SCWsy SET StyleColorDelivery1 = @D1, StyleColorDelivery2 = @D2, StyleColorDelivery3 = @D3,		
	--	StyleColorDelivery4 = @D4, StyleColorDelivery5 = @D5
	--	WHERE RowID = @SCWSY_ROW

	--	SET @SCWSY_ROW = @SCWSY_ROW + 1
	--END 
	--***


	INSERT INTO pStyleColorwaySeasonYear ( StyleColorwaySeasonYearID, StyleSeasonYearID , StyleColorwayID , StyleID
		,StyleColorDelivery1, StyleColorDelivery2, StyleColorDelivery3, StyleColorDelivery4, StyleColorDelivery5, Units, ColorType)
	SELECT NEWID(), @StyleSeasonYearID, a.StyleColorID, a.StyleID
		,a.StyleColorDelivery1,a.StyleColorDelivery2, a.StyleColorDelivery3, a.StyleColorDelivery4, a.StyleColorDelivery5, a.Units, a.ColorType    
	FROM #SCWsy a


	--***
	--**  ADD Material / SeasonYear 
	--***
	DECLARE @MaterialSeasonYearID UNIQUEIDENTIFIER 
	DECLARE @MaterialColorSeasonYearID UNIQUEIDENTIFIER 

	CREATE TABLE #m_sy (
		RowID INT IDENTITY(1,1),
		MaterialID UNIQUEIDENTIFIER 
	)

	INSERT INTO #m_sy ( MaterialID ) 
	SELECT DISTINCT MaterialID FROM #sm 
	WHERE MaterialID IS NOT NULL 


	SELECT @iTOTAL = COUNT(*) FROM  #m_sy
	SET @iROW  = 1 
	WHILE @iROW <= @iTOTAL
	BEGIN 
		SELECT @MaterialID  = MaterialID from  #m_sy WHERE  RowID = @iROW 
		SET @MaterialSeasonYearID = NULL

		SELECT @MaterialSeasonYearID = MaterialSeasonYearID 
		FROM pMaterialSeasonYear WHERE MaterialID = @MaterialID AND SeasonYearID = @SeasonYearID 

		IF @MaterialSeasonYearID IS NULL
		BEGIN
			SET @MaterialSeasonYearID = NEWID()
			INSERT INTO pMaterialSeasonYear (MaterialSeasonYearID,SeasonYearID, MaterialID, CUser,CDate)
			VALUES (@MaterialSeasonYearID,@SeasonYearID, @MaterialID, 'SYSTEM_MC',GETDATE())
		END 

		SET @iROW  = @iROW + 1 
	END 

	--***
	--** ADD MaterialColors /SeasonYear 
	--***
	CREATE TABLE #mc_sy(
		RowID INT IDENTITY (1,1),
		MaterialColorID UNIQUEIDENTIFIER, 
		MaterialID UNIQUEIDENTIFIER
	)

	INSERT INTO #mc_sy ( MaterialColorID, MaterialID ) 
	SELECT DISTINCT a.MaterialColorID, b.MaterialID 
	FROM #scwi a
	INNER JOIN pMaterialColor b ON a.MaterialColorID =  b.MaterialColorID

	SELECT @iTOTAL = COUNT(*) FROM #mc_sy 
	SET @iROW = 1 

	WHILE @iROW <= @iTOTAL 
	BEGIN

		SELECT @MaterialColorID = MaterialColorID, @MaterialID = MaterialID 
		FROM #mc_sy WHERE RowID = @iROW

		SET @MaterialColorSeasonYearID = NULL

		SELECT @MaterialColorSeasonYearID = MaterialColorSeasonYearID
		FROM pMaterialColorSeasonYear WITH(NOLOCK)
		WHERE MaterialColorID = @MaterialColorID AND SeasonYearID = @SeasonYearID 

		IF  @MaterialColorSeasonYearID IS NULL
		BEGIN
			INSERT INTO pMaterialColorSeasonYear (MaterialColorSeasonYearID, MaterialColorID , MaterialID, 
			SeasonYearID, MaterialSeason, MaterialYear , CUser, CDate ) 
			VALUES (NEWID(), @MaterialColorID , @MaterialID ,  @SeasonYearID , @Season, @Year,'SYSTEM_MC' , GETDATE())   
		END 

		SET @iROW = @iROW + 1 

	END 



	BEGIN
		DROP TABLE #SCWsy	
		DROP TABLE #scwi
		DROP TABLE #scw 
		DROP TABLE #sm
		DROP TABLE #m_sy
		DROP TABLE #mc_sy
	END

	SET @ROWID = @ROWID + 1
END 

DROP TABLE #s



DELETE FROM dbo.pLinePlanMultiCloth2BodyTemp WHERE LinePlanColorGroupID = @LinePlanColorGroupID
DELETE FROM dbo.pLinePlanMultiCloth2ColorTemp  WHERE LinePlanColorGroupID = @LinePlanColorGroupID
DELETE FROM dbo.pLinePlanMultiCloth2MaterialGroupItemTemp  WHERE LinePlanColorGroupID = @LinePlanColorGroupID
DELETE FROM dbo.pLinePlanMultiCloth2MaterialGroupTemp WHERE LinePlanColorGroupID = @LinePlanColorGroupID
DELETE FROM dbo.pLinePlanMultiCloth2MaterialTemp WHERE LinePlanColorGroupID = @LinePlanColorGroupID



--** Get LinePlanColorRangeID AND MaterialRangeID
DECLARE @LinePlanMaterialRangeID UNIQUEIDENTIFIER 
DECLARE @LinePlanColorRangeID UNIQUEIDENTIFIER 
DECLARE @Index INT 

SELECT @Index =COUNT(*)
FROM dbo.pLinePlanRange a WITH(NOLOCK)
	INNER JOIN pLinePlan b WITH(NOLOCK) ON a.LinePlanID = b.LinePlanID 
	INNER JOIN dbo.pLinePlanTemplateItem c WITH(NOLOCK) ON b.LinePlanTemplateID = c.LinePlanTemplateID 

IF  @Index = 4
BEGIN 
	SELECT @LinePlanColorRangeID = b.LinePlanRangeID  
	FROM dbo.pLinePlanRange a	WITH(NOLOCK)
		INNER JOIN dbo.pLinePlanRange b WITH(NOLOCK) ON 
			a.LinePlanAttributeItemID1 = b.LinePlanAttributeItemID1 	
		AND a.LinePlanAttributeItemID2 = b.LinePlanAttributeItemID2 
		AND a.LinePlanAttributeItemID3 = b.LinePlanAttributeItemID3 
		AND a.LinePlanAttributeItemID4 = b.LinePlanAttributeItemID4 
	WHERE a.LinePlanRangeID = @LinePlanRangeID
		AND b.LinePlanFinancialID = '10000000-0000-0000-0000-000000000002'

	SELECT @LinePlanMaterialRangeID = b.LinePlanRangeID  
	FROM dbo.pLinePlanRange a	WITH(NOLOCK)
		INNER JOIN dbo.pLinePlanRange b WITH(NOLOCK) ON 
			a.LinePlanAttributeItemID1 = b.LinePlanAttributeItemID1 	
		AND a.LinePlanAttributeItemID2 = b.LinePlanAttributeItemID2 
		AND a.LinePlanAttributeItemID3 = b.LinePlanAttributeItemID3 
		AND a.LinePlanAttributeItemID4 = b.LinePlanAttributeItemID4 
	WHERE a.LinePlanRangeID = @LinePlanRangeID
		AND b.LinePlanFinancialID = '10000000-0000-0000-0000-000000000001'		
END		
ELSE 		
BEGIN 
	SELECT @LinePlanColorRangeID = b.LinePlanRangeID  
	FROM dbo.pLinePlanRange a WITH(NOLOCK)
		INNER JOIN dbo.pLinePlanRange b WITH(NOLOCK) ON 
			a.LinePlanAttributeItemID1 = b.LinePlanAttributeItemID1 	
		AND a.LinePlanAttributeItemID2 = b.LinePlanAttributeItemID2 
		AND a.LinePlanAttributeItemID3 = b.LinePlanAttributeItemID3 
	WHERE a.LinePlanRangeID = @LinePlanRangeID
		AND b.LinePlanFinancialID = '10000000-0000-0000-0000-000000000002'

	SELECT @LinePlanMaterialRangeID = b.LinePlanRangeID  
	FROM dbo.pLinePlanRange a WITH(NOLOCK)	
		INNER JOIN dbo.pLinePlanRange b WITH(NOLOCK) ON 
			a.LinePlanAttributeItemID1 = b.LinePlanAttributeItemID1 	
		AND a.LinePlanAttributeItemID2 = b.LinePlanAttributeItemID2 
		AND a.LinePlanAttributeItemID3 = b.LinePlanAttributeItemID3 
	WHERE a.LinePlanRangeID = @LinePlanRangeID
		AND b.LinePlanFinancialID = '10000000-0000-0000-0000-000000000001'						
END 




--****
--** Add colors in use to the lineplan
--*** 
CREATE TABLE #color(
ROWID INT IDENTITY (1,1),
ColorPaletteID UNIQUEIDENTIFIER,
ColorFolderID UNIQUEIDENTIFIER,
ColorCode NVARCHAR(200), 
ColorName NVARCHAR(200)
)

DECLARE @ColorCode NVARCHAR(200)
DECLARE @ColorName NVARCHAR(200)
DEClARE @LinePlanColorID UNIQUEIDENTIFIER
DEClARE @ColorFolderID UNIQUEIDENTIFIER 

INSERT INTO #color (ColorPaletteID, ColorFolderID, ColorCode, ColorName) 
SELECT DISTINCT a.ColorPaletteID, c.ColorFolderID, c.ColorCode, c.ColorName
FROM pStyleColorway a WITH(NOLOCK)
	INNER JOIN pStyleHeader b WITH(NOLOCK) ON a.StyleID = b.StyleID
	INNER JOIN pColorPalette c WITH(NOLOCK) ON c.ColorPaletteID = a.ColorPaletteID 
WHERE b.StyleLinkID = @LinePlanColorGroupID


SET @ROWID = 1
SELECT @TOTAL = COUNT(*) FROM #color 


WHILE @ROWID <= @TOTAL 
BEGIN

	SELECT @ColorPaletteID = ColorPaletteID, @ColorFolderID  = ColorFolderID, 
	@ColorCode = ColorCode, @ColorName = ColorName 
	FROM #color WHERE ROWID = @ROWID 

	SELECT @LinePlanColorID = a.LinePlanColorID 
	FROM pLinePlanColor a WITH(NOLOCK)
		INNER JOIN pColorPalette b WITH(NOLOCK) On a.ColorPaletteID =  b.ColorPaletteID 
	WHERE a.LinePlanID = @LinePlanID 
	AND b.ColorCode = @ColorCode 

	IF @LinePlanColorID IS NULL
	BEGIN
		SET @LinePlanColorID =  NEWID()
		INSERT INTO pLinePlanColor ( LinePlanColorID, LinePlanID, ColorFolderID , ColorPaletteID , CUser, CDate ,MUser, MDate ) 
		VALUES (@LinePlanColorID , @LinePlanID, @ColorFolderID, @ColorPaletteID , @CUser, @CDate, @CUser, @CDate ) 

	END 

	IF @LinePlanColorRangeID IS NOT NULL 
	BEGIN 
		IF NOT EXISTS ( SELECT * FROM pLinePlanColorItem a WITH(NOLOCK)
				INNER JOIN pColorPalette b WITH(NOLOCK) ON a.ColorPaletteID =  b.ColorPaletteID 
		WHERE LinePlanRangeID = @LinePlanColorRangeID
			AND b.ColorCode = @ColorCode ) 
		BEGIN 
			INSERT INTO pLinePlanColorItem  (LinePlanColorItemID, LinePlanRangeID , LinePlanID , ColorPaletteID, CUser, CDate, MUser, MDate, Change, Active ) 
			VALUES (NEWID(), @LinePlanColorRangeID , @LinePlanID , @ColorPaletteID, @CUser, @CDate, @CUser, @CDate, 1, 1) 		
		END 
	END 

	SET @ROWID = @ROWID + 1 
END


--** allocate Materials
DECLARE @LinePlanMaterialID UNIQUEIDENTIFIER 

CREATE TABLE #mat(
	ROWID INT IDENTITY (1,1),
	MaterialID UNIQUEIDENTIFIER
)

INSERT INTO  #mat( MaterialID )
SELECT DISTINCT b.MaterialID  
FROM dbo.pStyleHeader a WITH(NOLOCK)
	INNER JOIN dbo.pStyleMaterials b WITH(NOLOCK) ON a.StyleID = b.StyleID 
		AND b.MainMaterial = 1 
WHERE a.StyleLinkID = @LinePlanColorGroupID

SET @ROWID = 1
SELECT @TOTAL = COUNT(*) FROM #mat

WHILE @ROWID <= @TOTAL 
BEGIN 
	SELECT @MaterialID = MaterialID FROM #mat WHERE ROWID = @ROWID

	SELECT @LinePlanMaterialID = LinePlanMaterialID FROM dbo.pLinePlanMaterial WITH(NOLOCK)
	WHERE MaterialID =@MaterialID AND LinePlanID = @LinePlanID

	IF @LinePlanMaterialID IS NULL
	BEGIN
		SET @LinePlanMaterialID =  NEWID()
		INSERT INTO pLinePlanMaterial ( LinePlanMaterialID, LinePlanID, MaterialID, CUser, CDate ,MUser, MDate ) 
		VALUES ( @LinePlanMaterialID, @LinePlanID, @MaterialID, @CUser, @CDate, @CUser, @CDate ) 
	END 

	IF @LinePlanMaterialRangeID IS NOT NULL 
	BEGIN 
		IF NOT EXISTS ( SELECT * FROM pLinePlanMaterialItem a WITH(NOLOCK)
			WHERE a.LinePlanRangeID = @LinePlanMaterialRangeID AND a.MaterialID = @MaterialID ) 
		BEGIN 
			INSERT INTO pLinePlanMaterialItem(LinePlanMaterialItemID, LinePlanRangeID, LinePlanID ,MaterialID, CUser, CDate, MUser, MDate) 
			VALUES (NEWID(), @LinePlanMaterialRangeID , @LinePlanID , @MaterialID, @CUser, @CDate, @CUser, @CDate) 		
		END 
	END 

	SET @ROWID = @ROWID  +  1
END 


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09632', GetDate())
GO
