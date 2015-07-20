/****** Object:  StoredProcedure [dbo].[spx_StyleColorwayITEMS_SELECT]    Script Date: 11/28/2011 17:47:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorwayITEMS_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleColorwayITEMS_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_StyleColorwayITEMS_SELECT] (
@StyleID UNIQUEIDENTIFIER ,
@StyleSet INT,
@SeasonYearID NVARCHAR(50)= NULL
)
AS 


DECLARE 
	@TOTAL INT,
	@ROW1 INT,
	@ROW2 INT, 
	@StyleColorID1 UNIQUEIDENTIFIER, 
	@StyleColorID2 UNIQUEIDENTIFIER, 
	@StyleColorID3 UNIQUEIDENTIFIER,
	@MaterialID UNIQUEIDENTIFIER,
	@MaterialColorID1 UNIQUEIDENTIFIER,
	@MaterialColorID2 UNIQUEIDENTIFIER,
	@MaterialColorID3 UNIQUEIDENTIFIER,
	@ItemID INT,
	@mmTOTAL INT,
	@mmROWID INT,
	@smTOTAL INT,
	@smROWID INT,
	@SubComponentID UNIQUEIDENTIFIER,
	@SubComponentItem INT,
	@MaterialColorID UNIQUEIDENTIFIER,
	@ColorPaletteID UNIQUEIDENTIFIER,
	@ColorFolderID UNIQUEIDENTIFIER,
	@ColorCode NVARCHAR(200), 
	@ColorName NVARCHAR(200),
	@MaterialLinkColorID UNIQUEIDENTIFIER,
	@MaterialLinkColorItemID UNIQUEIDENTIFIER

CREATE TABLE #tmpStyleColorway (
Rec_ID INT IDENTITY (1,1),
StyleColorID UNIQUEIDENTIFIER, 
StyleColorNo NVARCHAR(200), 
StyleColorName NVARCHAR(200),
MainColor NVARCHAR(100),
SAPCode NVARCHAR(200), 
PLMCode NVARCHAR(200),
ColorFolderId UNIQUEIDENTIFIER,
ColorPaletteID UNIQUEIDENTIFIER 
)



IF @SeasonYearID IS NOT NULL AND LEN(@SeasonYearID) > 0
BEGIN 

	DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER 

	SELECT @StyleSeasonYearID  = StyleSeasonYearID 
	FROM pStyleSeasonYear
	WHERE SeasonYearID = @SeasonYearID AND StyleID = @StyleID 

	INSERT INTO #tmpStyleColorway (StyleColorID , StyleColorNo, StyleColorName, MainColor, SAPCode , PLMCode,ColorFolderId,ColorPaletteID)

	SELECT b.StyleColorID , b.StyleColorNo, c.ColorName, c.ColorName, b.SAPCode, b.PLMCode,c.ColorFolderID,c.ColorPaletteID  
	FROM pStyleColorwaySeasonYear a 
	INNER JOIN pStyleColorway b ON a.StyleColorwayID = b.StyleColorID
	INNER JOIN pColorPalette c ON c.ColorPaletteID = b.ColorPaletteID 
	WHERE  a.StyleID = @StyleID
	AND a.StyleSeasonYearID = @StyleSeasonYearID
	--AND b.StyleSet = @StyleSet  #02
	ORDER BY b.Sort, b.MainColor

END
ELSE 
BEGIN

	INSERT INTO #tmpStyleColorway (StyleColorID , StyleColorNo, StyleColorName, MainColor, SAPCode , PLMCode,ColorFolderId,ColorPaletteID)
	SELECT StyleColorID , StyleColorNo, b.ColorName AS StyleColorName, b.ColorName AS MainColor, SAPCode, PLMCode,b.ColorFolderID,b.ColorPaletteID 
	FROM pStyleColorway a 
	INNER JOIN pColorPalette b ON a.ColorPaletteID = b.ColorPaletteID 
	WHERE StyleID = @StyleID 
	--AND StyleSet = @StyleSet #02
	ORDER BY a.Sort, a.MainColor

END



SELECT @TOTAL  = COUNT(*) FROM #tmpStyleColorway 
SET @ROW1 = 1

DECLARE @NUMBER_COLUMNS INT
SET @NUMBER_COLUMNS = 3 


SELECT * FROM #tmpStyleColorway
DECLARE @SQL NVARCHAR(4000)


CREATE TABLE  #tmp1 ( 
	ROWID INT IDENTITY (1,1),
	MaterialNo NVARCHAR(50), 
	MaterialName NVARCHAR(200), 
	MainMaterial int,
	MultiDimension INT, 
	StyleMaterialID UNIQUEIDENTIFIER, 
	MaterialType INT, 
	Placement NVARCHAR(4000),
	MaterialID1 UNIQUEIDENTIFIER, 
	StyleColorItemID1 UNIQUEIDENTIFIER, 
	StyleMaterialID1 UNIQUEIDENTIFIER, 
	MaterialColorID1 UNIQUEIDENTIFIER,		
	MaterialColorImageID1 UNIQUEIDENTIFIER, 
	MaterialColorImageVersion1 int, 
	ColorFolderId1 UNIQUEIDENTIFIER, 
	ColorPaletteID1 UNIQUEIDENTIFIER, 
	ColorCode1 NVARCHAR(200),
	ColorName1 NVARCHAR(200),
	MaterialColorNote1 NVARCHAR(4000), 
	MaterialSort NVARCHAR(5), 
	ComponentOrder NVARCHAR(5)
)

CREATE TABLE #tmp2 (
	ROWID INT IDENTITY(1,1),
	MaterialID2 UNIQUEIDENTIFIER, 
	StyleColorItemID2 UNIQUEIDENTIFIER, 
	StyleMaterialID2 UNIQUEIDENTIFIER, 
	MaterialColorID2 UNIQUEIDENTIFIER,		
	MaterialColorImageID2 UNIQUEIDENTIFIER, 
	MaterialColorImageVersion2 int, 
	ColorFolderId2 UNIQUEIDENTIFIER, 
	ColorPaletteID2 UNIQUEIDENTIFIER, 
	ColorCode2 NVARCHAR(200),
	ColorName2 NVARCHAR(200),
	MaterialColorNote2 NVARCHAR(4000)
)
CREATE TABLE #tmp3 (
	ROWID INT IDENTITY(1,1),
	MaterialID3 UNIQUEIDENTIFIER, 
	StyleColorItemID3 UNIQUEIDENTIFIER, 
	StyleMaterialID3 UNIQUEIDENTIFIER, 
	MaterialColorID3 UNIQUEIDENTIFIER,		
	MaterialColorImageID3 UNIQUEIDENTIFIER, 
	MaterialColorImageVersion3 int, 
	ColorFolderId3 UNIQUEIDENTIFIER, 
	ColorPaletteID3 UNIQUEIDENTIFIER, 
	ColorCode3 NVARCHAR(200),
	ColorName3 NVARCHAR(200),
	MaterialColorNote3 NVARCHAR(4000)
)


CREATE TABLE  #output ( 
	ROWID INT IDENTITY(1,1),
	SubComponent INT,
	SubComponentName NVARCHAR(200),
	SubComponentID UNIQUEIDENTIFIER,
	SubComponentItem INT DEFAULT(0),
	MaterialNo NVARCHAR(50), 
	MaterialName NVARCHAR(200), 
	MainMaterial int,
	MultiDimension INT, 
	StyleMaterialID UNIQUEIDENTIFIER, 
	MaterialType INT, 
	Placement NVARCHAR(4000),
	MaterialID1 UNIQUEIDENTIFIER, 
	StyleColorItemID1 UNIQUEIDENTIFIER, 
	StyleMaterialID1 UNIQUEIDENTIFIER, 
	MaterialColorID1 UNIQUEIDENTIFIER,		
	MaterialColorImageID1 UNIQUEIDENTIFIER, 
	MaterialColorImageVersion1 int, 
	ColorFolderId1 UNIQUEIDENTIFIER, 
	ColorPaletteID1 UNIQUEIDENTIFIER, 
	ColorCode1 NVARCHAR(200),
	ColorName1 NVARCHAR(200),
	MaterialColorNote1 NVARCHAR(200),
	
	MaterialID2 UNIQUEIDENTIFIER, 
	StyleColorItemID2 UNIQUEIDENTIFIER, 
	StyleMaterialID2 UNIQUEIDENTIFIER, 
	MaterialColorID2 UNIQUEIDENTIFIER,		
	MaterialColorImageID2 UNIQUEIDENTIFIER, 
	MaterialColorImageVersion2 int, 
	ColorFolderId2 UNIQUEIDENTIFIER, 
	ColorPaletteID2 UNIQUEIDENTIFIER, 
	ColorCode2 NVARCHAR(200),
	ColorName2 NVARCHAR(200),
	MaterialColorNote2 NVARCHAR(200),
	
	MaterialID3 UNIQUEIDENTIFIER, 
	StyleColorItemID3 UNIQUEIDENTIFIER, 
	StyleMaterialID3 UNIQUEIDENTIFIER, 
	MaterialColorID3 UNIQUEIDENTIFIER,		
	MaterialColorImageID3 UNIQUEIDENTIFIER, 
	MaterialColorImageVersion3 int, 
	ColorFolderId3 UNIQUEIDENTIFIER, 
	ColorPaletteID3 UNIQUEIDENTIFIER, 
	ColorCode3 NVARCHAR(200),
	ColorName3 NVARCHAR(200),
	MaterialColorNote3 NVARCHAR(200)
)

CREATE TABLE #MultiMaterial(
	ROWID INT IDENTITY(1,1),
	ItemID INT,
	MaterialID UNIQUEIDENTIFIER,
	MaterialColorID1 UNIQUEIDENTIFIER,
	MaterialColorID2 UNIQUEIDENTIFIER,
	MaterialColorID3 UNIQUEIDENTIFIER
)


WHILE @ROW1 <= @TOTAL
BEGIN

	DELETE FROM #tmp1
	DELETE FROM #tmp2
	DELETE FROM #tmp3
	DELETE FROM #output
	DELETE FROM #MultiMaterial

	IF @ROW1 + @NUMBER_COLUMNS - 1  >  @TOTAL 
		SET @ROW2  = @TOTAL		
	ELSE
		SET @ROW2 = @ROW1 + @NUMBER_COLUMNS - 1


	SET @StyleColorID1 =  NULL
	SET @StyleColorID2 =  NULL
	SET @StyleColorID3 =  NULL


	SELECT @StyleColorID1 = StyleColorID FROM #tmpStyleColorway WHERE Rec_ID = @Row1
	SELECT @StyleColorID2 = StyleColorID FROM #tmpStyleColorway WHERE Rec_ID = @Row1 + 1 
	SELECT @StyleColorID3 = StyleColorID FROM #tmpStyleColorway WHERE Rec_ID = @Row1 + 2 
	
	IF	@StyleColorID1 IS NOT NULL 
	BEGIN
		
		INSERT INTO #tmp1 ( 
			MaterialNo, MaterialName, MainMaterial, MultiDimension, StyleMaterialID, 
			MaterialType, Placement, MaterialID1, StyleColorItemID1,StyleMaterialID1, 
			MaterialColorID1, MaterialColorImageID1, MaterialColorImageVersion1, 
			ColorFolderId1,ColorPaletteID1, ColorCode1, ColorName1,
			MaterialColorNote1, MaterialSort, ComponentOrder )
		SELECT d.MaterialNo, d.MaterialName , d.MainMaterial, e.MultiDimension , d.StyleMaterialID, 
			d.MaterialType, d.Placement, e.MaterialID AS MaterialID1, a.StyleColorItemID AS StyleColorItemID1, a.StyleMaterialID AS StyleMaterialID1, 
			a.MaterialColorID  AS MaterialColorID1,b.MaterialColorImageID AS MaterialColorImageID1 , b.MaterialColorImageVersion AS MaterialColorImageVersion1, 
			b.ColorFolderId AS ColorFolderId1,  b.ColorPaletteID AS ColorPaletteID1, 
			CASE 
				WHEN b.ColorCode IS NULL THEN ''
				ELSE b.ColorCode 
			END AS ColorCode1, b.ColorName AS ColorName1,
			b.MaterialColorNote AS MaterialColorNote1 , d.MaterialSort, f.ComponentOrder
		FROM pStyleColorWayItem  a LEFT OUTER  JOIN  pMaterialColor b ON a.MaterialColorID = b.MaterialColorID 
		INNER JOIN pStyleMaterials d ON d.StyleMaterialID  =  a.StyleMaterialID  
		INNER JOIN pMaterial e ON d.MaterialID = e.MaterialID 
		INNER JOIN pComponentType f ON d.MaterialType = f.ComponentTypeID 
		WHERE a.StyleColorID = @StyleColorID1
		AND a.StyleSet = @StyleSet 		
		
	END

      
	IF	@StyleColorID2 IS NOT NULL 
	BEGIN
	
		INSERT INTO #tmp2 ( 
			MaterialID2, StyleColorItemID2,StyleMaterialID2, 
			MaterialColorID2, MaterialColorImageID2, MaterialColorImageVersion2, 
			ColorFolderId2,ColorPaletteID2, ColorCode2, ColorName2,
			MaterialColorNote2)
		SELECT b.MaterialID AS MaterialID2, a.StyleColorItemID AS StyleColorItemID2, a.StyleMaterialID AS StyleMaterialID2 , a.MaterialColorID  AS MaterialColorID2 ,	--Comment #01
		b.MaterialColorImageID AS MaterialColorImageID2 , b.MaterialColorImageVersion AS MaterialColorImageVersion2, b.ColorFolderId AS ColorFolderId2,  b.ColorPaletteID AS ColorPaletteID2, 
		CASE 
			WHEN b.ColorCode IS NULL THEN ''
			ELSE b.ColorCode 
		END 
			AS ColorCode2, b.ColorName AS ColorName2, 
			b.MaterialColorNote AS MaterialColorNote2
		FROM pStyleColorWayItem  a LEFT OUTER  JOIN  pMaterialColor b ON a.MaterialColorID = b.MaterialColorID 
		WHERE a.StyleColorID = @StyleColorID2
		AND a.StyleSet = @StyleSet 
		
		
	END 

	
    
	IF @StyleColorID3 IS NOT NULL
	BEGIN 
	
		INSERT INTO #tmp3 ( 
			MaterialID3, StyleColorItemID3,StyleMaterialID3, 
			MaterialColorID3, MaterialColorImageID3, MaterialColorImageVersion3, 
			ColorFolderId3,ColorPaletteID3, ColorCode3, ColorName3,
			MaterialColorNote3)	
		SELECT b.MaterialID AS MaterialID3, a.StyleColorItemID AS StyleColorItemID3, a.StyleMaterialID AS StyleMaterialID3 , a.MaterialColorID  AS MaterialColorID3 ,		--Comment #01
		b.MaterialColorImageID AS MaterialColorImageID3 , b.MaterialColorImageVersion AS MaterialColorImageVersion3, b.ColorFolderId AS ColorFolderId3,  b.ColorPaletteID AS ColorPaletteID3, 
		CASE 
			WHEN b.ColorCode IS NULL THEN ''
			ELSE b.ColorCode 
		END 
			AS ColorCode3, b.ColorName AS ColorName3, 
			b.MaterialColorNote AS MaterialColorNote3
		FROM pStyleColorWayItem  a LEFT OUTER  JOIN  pMaterialColor b ON a.MaterialColorID = b.MaterialColorID 
		WHERE a.StyleColorID = @StyleColorID3	
		AND a.StyleSet = @StyleSet 
		
		
	END

	   
	IF @StyleColorID3 IS NOT NULL
	BEGIN	
		INSERT INTO  #output ( 
			MaterialNo,MaterialName,MainMaterial, MultiDimension, 
			StyleMaterialID,  MaterialType, Placement, 
			MaterialID1,StyleColorItemID1, StyleMaterialID1, MaterialColorID1,
			MaterialColorImageID1,MaterialColorImageVersion1, ColorFolderId1, 
			ColorPaletteID1, ColorCode1, ColorName1,
			
			MaterialID2,StyleColorItemID2, StyleMaterialID2, MaterialColorID2,
			MaterialColorImageID2,MaterialColorImageVersion2, ColorFolderId2, 
			ColorPaletteID2, ColorCode2, ColorName2,
			
			MaterialID3,StyleColorItemID3, StyleMaterialID3, MaterialColorID3,
			MaterialColorImageID3,MaterialColorImageVersion3, ColorFolderId3, 
			ColorPaletteID3, ColorCode3, ColorName3 ) 
	
		SELECT MaterialNo,MaterialName,MainMaterial, MultiDimension, 
			StyleMaterialID,  MaterialType, Placement, 
			MaterialID1,StyleColorItemID1, StyleMaterialID1, MaterialColorID1,
			MaterialColorImageID1,MaterialColorImageVersion1, ColorFolderId1, 
			ColorPaletteID1, ColorCode1, ColorName1,
			
			MaterialID2,StyleColorItemID2, StyleMaterialID2, MaterialColorID2,
			MaterialColorImageID2,MaterialColorImageVersion2, ColorFolderId2, 
			ColorPaletteID2, ColorCode2, ColorName2,
			
			MaterialID3,StyleColorItemID3, StyleMaterialID3, MaterialColorID3,
			MaterialColorImageID3,MaterialColorImageVersion3, ColorFolderId3, 
			ColorPaletteID3, ColorCode3, ColorName3 
		from #tmp1 a INNER JOIN #tmp2  b ON a.StyleMaterialID1 = b.StyleMaterialID2  
			INNER JOIN #tmp3 c ON a.StyleMaterialID1 = c.StyleMaterialID3  
		ORDER BY a.MainMaterial DESC, a.ComponentOrder, 
			a.MaterialSort, a.MaterialNo, a.MaterialName, a.StyleMaterialId  

			--DROP TABLE  #tmp1
			--DROP TABLE  #tmp2
			--DROP TABLE  #tmp3
			
	END
	ELSE IF ( @StyleColorID1 IS NOT NULL ) AND ( @StyleColorID2 IS NOT NULL  )  
	BEGIN
		
		INSERT INTO  #output ( 
			MaterialNo,MaterialName,MainMaterial, MultiDimension, 
			StyleMaterialID,  MaterialType, Placement, 
			MaterialID1,StyleColorItemID1, StyleMaterialID1, MaterialColorID1,
			MaterialColorImageID1,MaterialColorImageVersion1, ColorFolderId1, 
			ColorPaletteID1, ColorCode1, ColorName1,
			
			MaterialID2,StyleColorItemID2, StyleMaterialID2, MaterialColorID2,
			MaterialColorImageID2,MaterialColorImageVersion2, ColorFolderId2, 
			ColorPaletteID2, ColorCode2, ColorName2 ) 
					
		SELECT 	MaterialNo,MaterialName,MainMaterial, MultiDimension, 
			StyleMaterialID,  MaterialType, Placement, 
			MaterialID1,StyleColorItemID1, StyleMaterialID1, MaterialColorID1,
			MaterialColorImageID1,MaterialColorImageVersion1, ColorFolderId1, 
			ColorPaletteID1, ColorCode1, ColorName1,
			
			MaterialID2,StyleColorItemID2, StyleMaterialID2, MaterialColorID2,
			MaterialColorImageID2,MaterialColorImageVersion2, ColorFolderId2, 
			ColorPaletteID2, ColorCode2, ColorName2 
		
		FROM #tmp1 a INNER JOIN #tmp2  b ON a.StyleMaterialID1 = b.StyleMaterialID2  
			ORDER BY a.MainMaterial DESC, a.ComponentOrder, 
			a.MaterialSort, a.MaterialNo, a.MaterialName, a.StyleMaterialId  

			--DROP TABLE  #tmp1
			--DROP TABLE  #tmp2
			
	END 
	ELSE
	BEGIN 
	
		INSERT INTO  #output ( 
			MaterialNo,MaterialName,MainMaterial, MultiDimension, 
			StyleMaterialID,  MaterialType, Placement, 
			MaterialID1,StyleColorItemID1, StyleMaterialID1, MaterialColorID1,
			MaterialColorImageID1,MaterialColorImageVersion1, ColorFolderId1, 
			ColorPaletteID1, ColorCode1, ColorName1 ) 
					
		SELECT MaterialNo,MaterialName,MainMaterial, MultiDimension, 
			StyleMaterialID,  MaterialType, Placement, 
			MaterialID1,StyleColorItemID1, StyleMaterialID1, MaterialColorID1,
			MaterialColorImageID1,MaterialColorImageVersion1, ColorFolderId1, 
			ColorPaletteID1, ColorCode1, ColorName1
		FROM #tmp1 a 
			ORDER BY a.MainMaterial DESC, a.ComponentOrder, 
			a.MaterialSort, a.MaterialNo, a.MaterialName, a.StyleMaterialId  

			--DROP TABLE  #tmp1
			
	END
	
	
	UPDATE #output SET SubComponent = ROWID		
	
	
	--***
	--** Get multi materials
	--***
	
	
	INSERT INTO #MultiMaterial ( ItemID, MaterialID,MaterialColorID1,MaterialColorID2,MaterialColorID3 )
	SELECT ROWID, MaterialID1,MaterialColorID1,MaterialColorID2,MaterialColorID3
	FROM #output a
	WHERE a.MultiDimension = 1 
		
	
	
	SELECT @mmROWID = ISNULL(MIN(ROWID),1)  FROM #MultiMaterial 
	SELECT @mmTOTAL = COUNT(*) FROM #MultiMaterial 
	
	SET @mmTOTAL = @mmTOTAL + @mmROWID - 1

	WHILE @mmROWID <= @mmTOTAL 
	BEGIN 
	
		SELECT @MaterialID = MaterialID, @MaterialColorID1 = MaterialColorID1,
			@MaterialColorID2 = MaterialColorID2, @MaterialColorID3 = MaterialColorID3,
			@ItemID = ItemID
		FROM #MultiMaterial WHERE ROWID	= @mmROWID
		
		
		CREATE TABLE #subComponent (
			ROWID INT IDENTITY (1,1),
			SubComponentID UNIQUEIDENTIFIER
		)
	
		--** Get sub Components	
		INSERT INTO #subComponent (SubComponentID)
		SELECT b.MaterialID
		FROM dbo.pMaterialLink a 
			INNER JOIN dbo.pMaterial b  ON a.MaterialID = b.MaterialID
		WHERE a.MaterialGroupID = @MaterialID
		

		-- ** Insert subComponents
		INSERT INTO #output ( SubComponentName, SubComponentID, SubComponent, SubComponentItem, MaterialID1 ) 
		SELECT b.MaterialName, b.MaterialID, @ItemID, 1, @MaterialID
		FROM dbo.pMaterialLink a 
			INNER JOIN dbo.pMaterial b  ON a.MaterialID = b.MaterialID
		WHERE a.MaterialGroupID = @MaterialID
		
		
		SELECT @smTOTAL = COUNT(*) FROM #subComponent
		SET @smROWID  = 1 
		
		WHILE @smROWID <= @smTOTAL
		BEGIN
		
			SELECT @SubComponentID = SubComponentID
			FROM #subComponent WHERE ROWID = @smROWID
		
			/*
			-- Insert subcomponents
			INSERT INTO #output (SubComponentName, SubComponentID, SubComponent ) 
			SELECT a.MaterialName, a.MaterialID, @ItemID
			FROM dbo.pMaterial a  
			WHERE a.MaterialID = @SubComponentID
			*/
			
			IF @MaterialColorID1 IS NOT NULL
			BEGIN
				SELECT @MaterialColorID = NULL, @ColorPaletteID = NULL, @ColorFolderID = NULL, @ColorCode =NULL, @ColorName =NULL,
				@MaterialLinkColorID = NULL, @MaterialLinkColorItemID = NULL
				
				
				SELECT @MaterialColorID = a.MaterialColorID, @ColorPaletteID= c.ColorPaletteID, @ColorFolderID = c.ColorFolderID,
					@ColorCode = d.ColorCode, @ColorName = d.ColorName,
					@MaterialLinkColorID= b.MaterialLinkColorwayID, @MaterialLinkColorItemID = a.MaterialLinkColorwayItemID
				FROM dbo.pMaterialLinkColorwayItem a 
					INNER JOIN pMaterialLinkColorway b ON a.MaterialLinkColorwayID =  b.MaterialLinkColorwayID
					LEFT OUTER JOIN dbo.pMaterialColor c ON c.MaterialColorId =  a.MaterialColorID
					LEFT OUTER JOIN dbo.pColorPalette d ON d.ColorPaletteID =  c.ColorPaletteID
				WHERE a.MaterialID = @SubComponentID
				AND b.MaterialGroupID  = @MaterialID
				AND b.MaterialColorID = @MaterialColorID1

				
				UPDATE #output 
				SET MaterialColorID1 = @MaterialColorID, ColorPaletteID1 = @ColorPaletteID, ColorFolderID1 = @ColorFolderID,
				ColorCode1 = @ColorCode, ColorName1 = @ColorName,
				StyleMaterialID1 =@MaterialLinkColorID, StyleColorItemID1 = @MaterialLinkColorItemID
				WHERE SubComponentID  = @SubComponentID AND SubComponent = @ItemID
			END 

			IF @MaterialColorID2 IS NOT NULL
			BEGIN
				SELECT @MaterialColorID = NULL, @ColorPaletteID = NULL, @ColorFolderID = NULL, @ColorCode =NULL, @ColorName =NULL,
				@MaterialLinkColorID = NULL, @MaterialLinkColorItemID = NULL
				
				
				SELECT @MaterialColorID = a.MaterialColorID, @ColorPaletteID= c.ColorPaletteID, @ColorFolderID = c.ColorFolderID,
					@ColorCode = d.ColorCode, @ColorName = d.ColorName,
					@MaterialLinkColorID= b.MaterialLinkColorwayID, @MaterialLinkColorItemID = a.MaterialLinkColorwayItemID
				FROM dbo.pMaterialLinkColorwayItem a 
					INNER JOIN pMaterialLinkColorway b ON a.MaterialLinkColorwayID =  b.MaterialLinkColorwayID
					LEFT OUTER JOIN dbo.pMaterialColor c ON c.MaterialColorId =  a.MaterialColorID
					LEFT OUTER JOIN dbo.pColorPalette d ON d.ColorPaletteID =  c.ColorPaletteID
				WHERE a.MaterialID = @SubComponentID
				AND b.MaterialGroupID  = @MaterialID
				AND b.MaterialColorID = @MaterialColorID2
				
				
				UPDATE #output 
				SET MaterialColorID2= @MaterialColorID, ColorPaletteID2= @ColorPaletteID, ColorFolderID2= @ColorFolderID,
				ColorCode2= @ColorCode, ColorName2= @ColorName,
				StyleMaterialID2 =@MaterialLinkColorID, StyleColorItemID2 = @MaterialLinkColorItemID
				WHERE SubComponentID  = @SubComponentID AND SubComponent = @ItemID
			END 
			
			IF @MaterialColorID3 IS NOT NULL
			BEGIN
				SELECT @MaterialColorID = NULL, @ColorPaletteID = NULL, @ColorFolderID = NULL, @ColorCode =NULL, @ColorName =NULL,
				@MaterialLinkColorID = NULL, @MaterialLinkColorItemID = NULL

				SELECT @MaterialColorID = a.MaterialColorID, @ColorPaletteID= c.ColorPaletteID, @ColorFolderID = c.ColorFolderID,
					@ColorCode = d.ColorCode, @ColorName = d.ColorName,
					@MaterialLinkColorID= b.MaterialLinkColorwayID, @MaterialLinkColorItemID = a.MaterialLinkColorwayItemID
				FROM dbo.pMaterialLinkColorwayItem a 
					INNER JOIN pMaterialLinkColorway b ON a.MaterialLinkColorwayID =  b.MaterialLinkColorwayID
					LEFT OUTER JOIN dbo.pMaterialColor c ON c.MaterialColorId =  a.MaterialColorID
					LEFT OUTER JOIN dbo.pColorPalette d ON d.ColorPaletteID =  c.ColorPaletteID
				WHERE a.MaterialID = @SubComponentID
				AND b.MaterialGroupID  = @MaterialID
				AND b.MaterialColorID = @MaterialColorID3

				
				UPDATE #output 
				SET MaterialColorID3= @MaterialColorID, ColorPaletteID3= @ColorPaletteID, ColorFolderID3= @ColorFolderID,
				ColorCode3= @ColorCode, ColorName3= @ColorName,
				StyleMaterialID3 =@MaterialLinkColorID, StyleColorItemID3 = @MaterialLinkColorItemID
				WHERE SubComponentID  = @SubComponentID AND SubComponent = @ItemID
			END 

			
			SET @smROWID = @smROWID + 1 
		END  -- WHILE @smROWID <= @smTOTAL
		DROP TABLE #subComponent
	
		SET @mmROWID = @mmROWID + 1
	END 
	
	
	SELECT * FROM #output
	ORDER BY SubComponent, ROWID
		
	SET @ROW1  = @ROW2 + 1 
END 

DROP TABLE #tmpStyleColorway

DROP TABLE  #tmp1
DROP TABLE  #tmp2
DROP TABLE  #tmp3
DROP TABLE  #MultiMaterial
DROP TABLE  #output

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02211'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02211', GetDate())
END
GO
