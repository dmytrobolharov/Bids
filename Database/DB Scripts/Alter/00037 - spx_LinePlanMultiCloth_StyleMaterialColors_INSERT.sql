IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanMultiCloth_StyleMaterialColors_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanMultiCloth_StyleMaterialColors_INSERT]
GO


/***
Comment #01 - Clayton Parker - March 8 2010
Modified the procedure below to correct an issue with a Latin error when creating a multi cloth style.
*/


CREATE PROCEDURE [dbo].[spx_LinePlanMultiCloth_StyleMaterialColors_INSERT](
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
FROM pLinePlanRange a
INNER JOIN pLinePlan b ON a.LinePlanID = b.LinePlanID 
WHERE a.LinePlanRangeID = @LinePlanRangeID	


SELECT @SeasonYearID = SeasonYearID
FROM pSeasonYear
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

INSERT INTO #s(StyleID)
SELECT DISTINCT StyleID FROM pLinePlanMultiClothStyleTemp
WHERE LinePlanColorGroupID = @LinePlanColorGroupID

SELECT @TOTAL = COUNT(*) FROM #s 
SET @ROWID = 1

SELECT * FROM #s 

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
		[Qty] [nvarchar](18) Collate SQL_Latin1_General_CP1_CI_AS NULL, --#01
		[MaterialPrice] [money] NULL,
		[Ext] [money] NULL,
		[MaterialSize] [nvarchar](100) Collate SQL_Latin1_General_CP1_CI_AS NULL, --#01
		[Placement] [nvarchar](4000) Collate SQL_Latin1_General_CP1_CI_AS NULL, --#01
		[Artwork] [int] NULL,
		[License] [int] NULL,
		[Colorway] [int] NULL,
		MultiCloth INT DEFAULT(0)	
	)

	CREATE TABLE #scw(
		StyleColorID UNIQUEIDENTIFIER DEFAULT NEWID(),
		StyleID UNIQUEIDENTIFIER, 
		ColorPaletteID UNIQUEIDENTIFIER,
		MaterialCoreColorID UNIQUEIDENTIFIER 
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
		MaterialCoreColorItemID UNIQUEIDENTIFIER
	)
	
	--***
	--** Insert Style ID 
	--***
	INSERT INTO pStyleHeader (StyleID, StyleLinkID)  VALUES (@NewStyleID, @LinePlanColorGroupID)
	
	--***
	--** Insert Main Style Materials
	--***
	INSERT INTO #sm( StyleMaterialID, StyleID , MaterialID, MainMaterial, MaterialCoreItemID, SeasonYearID, MultiCloth) 
	VALUES (NEWID(), @NewStyleID,@MaterialID, 1 , NULL, @SeasonYearID, 0) 
	
	--*** 
	--**Update pStyleHeader with Main Material, and MaterialGroup 
	--***
	UPDATE pStyleHeader SET 
		MaterialID = pMaterial.MaterialID,
		MaterialNo= pMaterial.MaterialNo,
		MaterialName = pMaterial.MaterialName,
		MaterialImageID = pMaterial.MaterialImageID,
		MaterialImageVersion = pMaterial.MaterialImageVersion,
		MaterialCoreID  = @MaterialCoreID 
	FROM pMaterial WHERE pMaterial.MaterialID = @MaterialID	
		AND pStyleHeader.StyleID = @NewStyleId
		 	
	
	IF @MaterialCoreID IS NOT NULL AND @MaterialCoreID <> '00000000-0000-0000-0000-000000000000'
	BEGIN
		INSERT INTO #sm( StyleID , MaterialID, MainMaterial, MaterialCoreItemID, UOM, Qty, MaterialPrice, Ext, MaterialSize, Placement, Artwork, License, Colorway, SeasonYearID, MultiCloth) 
		SELECT @NewStyleID, MaterialID , 0, MaterialCoreItemID, UOM, Qty, MaterialPrice, Ext, MaterialSize, Placement, Artwork, License, Colorway, @SeasonYearID, 1
		FROM pMaterialCoreItem WHERE MaterialCoreID = @MaterialCoreID
	END 
	
	-- ***
	-- ** Insert Style Colorways
	-- ** LinePlanColorItemID = ColorPaletteID 
	-- ***
	INSERT INTO #scw (StyleID ,ColorPaletteID, MaterialCoreColorID) 
	SELECT DISTINCT @NewStyleID, ColorPaletteID, MaterialGroupColorID 
	FROM  pLinePlanMultiClothColorTemp a
	WHERE a.MaterialID = @MaterialID 
	AND a.LinePlanColorGroupID = @LinePlanColorGroupID

	-- ***
	-- ** Insert Style Colorways Items
	-- ***
	INSERT INTO #scwi ( MainMaterial, StyleMaterialID, StyleColorID, ColorPaletteID, MaterialCoreItemID, MaterialCoreColorID)
	SELECT a.MainMaterial, a.StyleMaterialID, b.StyleColorID, b.ColorPaletteID, a.MaterialCoreItemID, b.MaterialCoreColorID 
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
	
	DECLARE @iTOTAL INT
	DECLARE @iROW INT
	
	SET @iROW = 1 
	SELECT @iTOTAL = COUNT(*) FROM  #scwi
	
	WHILE @iROW <= @iTOTAL 
	BEGIN
		SELECT @MainMaterial = MainMaterial, @StyleMaterialID = StyleMaterialID, @MaterialCoreColorID = MaterialCoreColorID, 
			@StyleColorID = StyleColorID, @ColorPaletteID = ColorPaletteID, @MaterialCoreItemID = MaterialCoreItemID
		FROM #scwi WHERE RowID = @iROW 
		
		SET @MaterialColorID = NULL
		SET @MaterialCoreColorItemID = (SELECT TOP 1 MaterialCoreColorItemID 
			FROM pMaterialCoreColorItem WHERE MaterialCoreColorID = @MaterialCoreColorID 
				AND MaterialCoreItemID = @MaterialCoreItemID)
		
		IF  @MainMaterial = 1 
			SELECT TOP 1 @MaterialColorID = MaterialColorID FROM pLinePlanMultiClothColorTemp 
			WHERE MaterialID = @MaterialID AND ColorPaletteID = @ColorPaletteID 
				AND LinePlanColorGroupID = @LinePlanColorGroupID 
		ELSE
		BEGIN
		
			SET @MaterialGroupColorID = NULL 
		
			SELECT TOP 1 @MaterialGroupColorID = MaterialGroupColorID 
			FROM pLinePlanMultiClothColorTemp
			WHERE  MaterialID = @MaterialID
					AND ColorPaletteID = @ColorPaletteID
					AND LinePlanColorGroupID = @LinePlanColorGroupID 
			
			IF @MaterialGroupColorID IS NOT NULL
				SELECT TOP 1 @MaterialColorID = MaterialColorID FROM pMaterialCoreColorItem 
				WHERE MaterialCoreColorID = @MaterialGroupColorID
				AND MaterialCoreItemID  = @MaterialCoreItemID
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
		MaterialID , MaterialImageID , MaterialImageVersion, MaterialType, MaterialNo, MaterialName, 
		A,B, C, D ,E, F, G,H, I, J , K, L, M , N, O, P, Q, R, S, T, 
		U, V,W, X, Y, Z, Notes, CUser, CDate,MUser,MDate, MChange, Colorway,
		UOM, Qty, MaterialPrice, Ext, MaterialSize, Placement, Artwork, License, StyleMaterialLinkID, MultiCloth, 
		MaterialSizeID)
	SELECT  sm.StyleMaterialID, NEWID() AS StyleMaterialMasterID, sm.MainMaterial, 1 AS StyleSet, sm.StyleID, a.MaterialID, ISNULL(a.MaterialImageID,'00000000-0000-0000-0000-000000000000') AS MaterialImageID, 
	  ISNULL(a.MaterialImageVersion,1) AS MaterialImageVersion, a.MaterialType, a.MaterialNo, a.MaterialName, a.A, a.B, a.C, a.D, a.E, a.F, a.G, a.H, a.I, a.J, a.K, a.L, a.M, a.N, a.O, a.P, a.Q, a.R, a.S, a.T, a.U, 
	  a.V, a.W, a.X, a.Y, a.Z, a.Notes, @CUser AS CreatedBy, @CDate AS CreatedDate, @CUser AS ModifiedBy, @CDate AS ModifiedDate, a.MChange, 1 AS Colorway, 
	  a.UOM, ISNULL(sm.Qty, 0) AS Qty, ISNULL(sm.MaterialPrice, 0) AS MaterialPrice, sm.Ext, sm.MaterialSize, sm.Placement, 
	  ISNULL(sm.Artwork, 0) AS Artwork, ISNULL(sm.License, 0) AS License, sm.MaterialCoreItemID, MultiCloth,
	  b.MaterialSizeID
	FROM #sm sm 
	INNER JOIN pMaterial AS a ON sm.MaterialID = a.MaterialID
	LEFT OUTER JOIN pMaterialSize b ON (b.MaterialID = sm.MaterialID AND b.MaterialSize = sm.MaterialSize)
  
	--***
	--** Insert Stylecolor records
	--***	
	INSERT INTO pStyleColorway ( StyleColorID , StyleID , StyleSet, StyleColorNo, StyleColorName, MainColor, Version, 
	CDate, CUser, MDate, MUser, ColorPaletteID ) 
	SELECT scw.StyleColorID, scw.StyleID , 1, b.ColorCode, b.ColorName, b.ColorName, 1, 
	@CDate ,@CUser,@CDate, @CUser, scw.ColorPaletteID
	FROM #scw scw
	INNER JOIN pColorPalette b ON b.ColorPaletteID =  scw.ColorPaletteID


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
	SELECT @LinePlanStyleAttributeItemID = LinePlanStyleAttributeItemID FROM pLinePlanItem
	WHERE LinePlanItemID = @NewLinePlanItemID 
	IF @LinePlanStyleAttributeItemID = '00000000-0000-0000-0000-000000000000' 
		SET @LinePlanStyleAttributeItemID = NULL
	
	SET @LinePlanItemID =  NULL
	
	IF @LinePlanStyleAttributeItemID IS NULL 
	BEGIN
		SELECT TOP 1 @LinePlanItemID = a.LinePlanItemID 
		FROM pLinePlanItem a
		WHERE a.LinePlanRangeID = @LinePlanRangeID 
		AND a.StyleID = '00000000-0000-0000-0000-000000000000'
		AND a.LinePlanRangeTypeID = '00000000-0000-0000-0000-000000000003'
		AND (a.LinePlanStyleAttributeItemID IS NULL OR a.LinePlanStyleAttributeItemID = '00000000-0000-0000-0000-000000000000')
	END 
	ELSE
	BEGIN
		SELECT TOP 1 @LinePlanItemID = a.LinePlanItemID 
		FROM pLinePlanItem a
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
		FROM pLinePlanRange a
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
	SELECT b.StyleColorID, b.StyleID,
		a.StyleColorDelivery1, a.StyleColorDelivery2, a.StyleColorDelivery3, a.StyleColorDelivery4, a.Units, a.ColorType   
	INTO #SCWsy
	FROM pLinePlanMultiClothColorTemp a
	INNER JOIN #scw b ON a.ColorPaletteID  = b.ColorPaletteID
	WHERE a.MaterialID = @MaterialID AND a.LinePlanColorGroupID = @LinePlanColorGroupID 
	GROUP BY b.StyleColorID, b.StyleID,
		a.StyleColorDelivery1, a.StyleColorDelivery2, a.StyleColorDelivery3, a.StyleColorDelivery4, a.Units, a.ColorType  

	INSERT INTO pStyleColorwaySeasonYear ( StyleColorwaySeasonYearID, StyleSeasonYearID , StyleColorwayID , StyleID , 
		StyleColorDelivery1, StyleColorDelivery2, StyleColorDelivery3, StyleColorDelivery4, Units, ColorType)
	SELECT NEWID(), @StyleSeasonYearID, a.StyleColorID, a.StyleID, a.StyleColorDelivery1, 
		a.StyleColorDelivery2, a.StyleColorDelivery3, a.StyleColorDelivery4, a.Units, a.ColorType    
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
		FROM pMaterialColorSeasonYear 
		WHERE MaterialColorID = @MaterialColorID AND SeasonYearID = @SeasonYearID 
		
		IF  @MaterialColorSeasonYearID IS NULL
		BEGIN
			INSERT INTO pMaterialColorSeasonYear (MaterialColorSeasonYearID, MaterialColorID , MaterialID, 
			SeasonYearID, MaterialSeason, MaterialYear , CUser, CDate ) 
			VALUES (NEWID(), @MaterialColorID , @MaterialID ,  @SeasonYearID , @Season, @Year,'SYSTEM_MC' , GETDATE())   
		END 
		
		SET @iROW = @iROW + 1 
		
	END 
				
		
	
	
	
	
/*	
	
	BEGIN
		--Daniel Pak 2/13/2010
		--Add Material Season Year
		--Add Material Color Season Year
		BEGIN
			CREATE TABLE #tmpMaterialColor (
				RowID INT IDENTITY(1,1),
				MaterialColorID UNIQUEIDENTIFIER,
				MaterialID UNIQUEIDENTIFIER
			)
		END
		
		--Insert available material colors from style material colors by season and year
		BEGIN
			INSERT INTO #tmpMaterialColor(MaterialColorID, MaterialID)			
			SELECT MaterialColorID, MaterialID  
				FROM pStyleColorwayItem WHERE StyleID = @NewStyleID AND StyleColorID IN (	
			SELECT StyleColorID FROM pStyleColorwaySeasonYear 
				WHERE StyleID = @NewStyleID AND StyleSeasonYearID IN	
				(SELECT StyleSeasonYearID FROM pStyleSeasonYear 
				WHERE SeasonYearID = @SeasonYearID))	
		END
			
		--Create Material Season & Year
		DECLARE @StyleMaterialCount INT
		DECLARE @StyleMaterialIndex INT
		DECLARE @SM_SeasonYearID uniqueidentifier
		DECLARE @SM_MaterialID uniqueidentifier
		DECLARE @SM_MaterialSeasonYearID uniqueidentifier
		
			SELECT @StyleMaterialCount  = COUNT(*) FROM #sm 
			SET @StyleMaterialIndex = 1

			--Loop style material to add season year
			WHILE @StyleMaterialIndex <= @StyleMaterialCount
			BEGIN
				SELECT @SM_MaterialID = MaterialID, @SM_SeasonYearID = SeasonYearID
				FROM #sm WHERE RowID = @StyleMaterialIndex
					BEGIN
					IF (SELECT COUNT(*) FROM pMaterialSeasonYear WHERE MaterialID = @SM_MaterialID AND SeasonYearID = @SM_SeasonYearID) = 0				
						BEGIN	
							SET @SM_MaterialSeasonYearID = NEWID()
							INSERT INTO pMaterialSeasonYear(MaterialSeasonYearID, MaterialID, SeasonYearID, CUser, CDate)
							VALUES (@SM_MaterialSeasonYearID, @SM_MaterialID, @SM_SeasonYearID, 'SYSTEM_MC', GETDATE())  
						END
					ELSE
						SET @SM_MaterialSeasonYearID = (SELECT TOP 1 MaterialSeasonYearID FROM pMaterialSeasonYear 
								WHERE MaterialID = @SM_MaterialID AND SeasonYearID = @SM_SeasonYearID)
					END	
								
				SET @StyleMaterialIndex = @StyleMaterialIndex + 1 
			END
			
		--Create Material Color  Season & Year
		DECLARE @MaterialColorCount INT
		DECLARE @MaterialColorIndex INT
		DECLARE @MC_MaterialID uniqueidentifier
		DECLARE @MC_MaterialColorID uniqueidentifier
		
		DECLARE @SeasonName varchar(200)
		DECLARE @SeasonYear varchar(4)
		
			--Get Season and Year Names
			SELECT @SeasonName = [Season], @SeasonYear = [Year] FROM pSeasonYear 
			WHERE SeasonYearID = @SeasonYearID 
		
			--Get a total count of available temp material color
			SELECT @MaterialColorCount  = COUNT(*) FROM #tmpMaterialColor 
			SET @MaterialColorIndex = 1

			--Loop style material color to add season year
			WHILE @MaterialColorIndex <= @MaterialColorCount
			BEGIN
				SELECT @MC_MaterialID = MaterialID, @MC_MaterialColorID = MaterialColorID
				FROM #tmpMaterialColor  WHERE RowID = @MaterialColorIndex
					BEGIN
					IF (SELECT COUNT(*) FROM pMaterialColorSeasonYear 
							WHERE SeasonYearID = @SeasonYearID AND MaterialID = @MC_MaterialID 
							AND MaterialColorID = @MC_MaterialColorID) = 0				
						BEGIN	
							INSERT INTO pMaterialColorSeasonYear(SeasonYearID, MaterialID, MaterialColorID, MaterialSeason, MaterialYear, CUser, CDate)
							VALUES (@SeasonYearID, @MC_MaterialID, @MC_MaterialColorID, @SeasonName, @SeasonYear, 'SYSTEM_MC', GETDATE())  
						END
					END	
								
				SET @MaterialColorIndex = @MaterialColorIndex + 1 
			END
			
			--END Daniel Pak 2/13/2010  	
	END		
	
*/	

	BEGIN
		DROP TABLE #SCWsy	
		DROP TABLE #scwi
		DROP TABLE #scw 
		DROP TABLE #sm
--		DROP TABLE #tmpMaterialColor
		DROP TABLE #m_sy
		DROP TABLE #mc_sy
	END
		
	SET @ROWID = @ROWID + 1
END 

DROP TABLE #s


GO

INSERT INTO [dbo].[sVersion]
    (AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '037', GetDate())

GO



