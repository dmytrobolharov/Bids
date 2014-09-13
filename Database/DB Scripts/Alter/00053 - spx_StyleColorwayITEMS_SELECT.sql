IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorwayITEMS_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleColorwayITEMS_SELECT]
GO


/*
Comments:

#01 - Ryan Cabanas (for Artemio Gomez) - September 10, 2009
	There is sometimes a problem with the 'MaterialID' values stored in the 'pStyleColorWayItem' table.
To ensure that the proper 'MaterialID' is retrieved, need to make sure that the 'MaterialID' value is
grabbed from the 'pMaterial' and 'pMaterialColor' tables in the JOINS used below.

#02 - Artemio Gomez -  For Colorways, it doesn't matter what's the StyleSet. In a style with 2 sets, set 1 and 2 have the 
	same colorways.
*/


CREATE PROCEDURE [dbo].[spx_StyleColorwayITEMS_SELECT] (
@StyleID UNIQUEIDENTIFIER ,
@StyleSet INT,
@SeasonYearID NVARCHAR(50)= NULL
)
AS 

DECLARE @TOTAL INT
DECLARE @ROW1 INT 
DECLARE @ROW2 INT 

CREATE TABLE #tmpStyleColorway (
Rec_ID INT IDENTITY (1,1) ,
StyleColorID UNIQUEIDENTIFIER , 
StyleColorNo NVARCHAR(50) , 
StyleColorName NVARCHAR(200) ,
MainColor NVARCHAR(100),
SAPCode NVARCHAR(50) , 
PLMCode NVARCHAR(200)
)



IF @SeasonYearID IS NOT NULL AND LEN(@SeasonYearID) > 0
BEGIN 

	DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER 

	SELECT @StyleSeasonYearID  = StyleSeasonYearID 
	FROM pStyleSeasonYear
	WHERE SeasonYearID = @SeasonYearID AND StyleID = @StyleID 

	INSERT INTO #tmpStyleColorway (StyleColorID , StyleColorNo, StyleColorName, MainColor, SAPCode , PLMCode)
	
	SELECT b.StyleColorID , b.StyleColorNo, c.ColorName, c.ColorName, b.SAPCode, b.PLMCode 
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

	INSERT INTO #tmpStyleColorway (StyleColorID , StyleColorNo, StyleColorName, MainColor, SAPCode , PLMCode)
	SELECT StyleColorID , StyleColorNo, b.ColorName AS StyleColorName, b.ColorName AS MainColor, SAPCode, PLMCode 
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

DECLARE @StyleColorID1 UNIQUEIDENTIFIER 
DECLARE @StyleColorID2 UNIQUEIDENTIFIER 
DECLARE @StyleColorID3 UNIQUEIDENTIFIER 

SELECT * FROM #tmpStyleColorway


DECLARE @SQL NVARCHAR(4000)

WHILE @ROW1 <= @TOTAL
BEGIN

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
		SELECT d.MaterialNo, d.MaterialName , d.MainMaterial, e.MultiDimension , d.StyleMaterialID, d.MaterialType, d.Placement, 
		e.MaterialID AS MaterialID1, a.StyleColorItemID AS StyleColorItemID1, a.StyleMaterialID AS StyleMaterialID1 , a.MaterialColorID  AS MaterialColorID1 ,		--Comment #01
		b.MaterialColorImageID AS MaterialColorImageID1 , b.MaterialColorImageVersion AS MaterialColorImageVersion1, b.ColorFolderId AS ColorFolderId1,  b.ColorPaletteID AS ColorPaletteID1, 
		CASE 
			WHEN b.ColorCode IS NULL THEN ''
			ELSE b.ColorCode 
		END 
		AS ColorCode1, b.ColorName AS ColorName1,
		b.MaterialColorNote AS MaterialColorNote1 , d.MaterialSort, f.ComponentOrder
		INTO #tmp1
		FROM pStyleColorWayItem  a LEFT OUTER  JOIN  pMaterialColor b ON a.MaterialColorID = b.MaterialColorID 
		INNER JOIN pStyleMaterials d ON d.StyleMaterialID  =  a.StyleMaterialID  
		INNER JOIN pMaterial e ON d.MaterialID = e.MaterialID 
		INNER JOIN pComponentType f ON d.MaterialType = f.ComponentTypeID 
		WHERE a.StyleColorID = @StyleColorID1
		AND a.StyleSet = @StyleSet 
	END


	IF	@StyleColorID2 IS NOT NULL 
	BEGIN
		SELECT b.MaterialID AS MaterialID2, a.StyleColorItemID AS StyleColorItemID2, a.StyleMaterialID AS StyleMaterialID2 , a.MaterialColorID  AS MaterialColorID2 ,	--Comment #01
		b.MaterialColorImageID AS MaterialColorImageID2 , b.MaterialColorImageVersion AS MaterialColorImageVersion2, b.ColorFolderId AS ColorFolderId2,  b.ColorPaletteID AS ColorPaletteID2, 
		CASE 
			WHEN b.ColorCode IS NULL THEN ''
			ELSE b.ColorCode 
		END 
		AS ColorCode2, b.ColorName AS ColorName2, 
		b.MaterialColorNote AS MaterialColorNote2
		INTO #tmp2
		FROM pStyleColorWayItem  a LEFT OUTER  JOIN  pMaterialColor b ON a.MaterialColorID = b.MaterialColorID 
		WHERE a.StyleColorID = @StyleColorID2
		AND a.StyleSet = @StyleSet 
	END 


	IF @StyleColorID3 IS NOT NULL
	BEGIN 
		SELECT b.MaterialID AS MaterialID3, a.StyleColorItemID AS StyleColorItemID3, a.StyleMaterialID AS StyleMaterialID3 , a.MaterialColorID  AS MaterialColorID3 ,		--Comment #01
		b.MaterialColorImageID AS MaterialColorImageID3 , b.MaterialColorImageVersion AS MaterialColorImageVersion3, b.ColorFolderId AS ColorFolderId3,  b.ColorPaletteID AS ColorPaletteID3, 
		CASE 
			WHEN b.ColorCode IS NULL THEN ''
			ELSE b.ColorCode 
		END 
		AS ColorCode3, b.ColorName AS ColorName3, 
		b.MaterialColorNote AS MaterialColorNote3
		INTO #tmp3
		FROM pStyleColorWayItem  a LEFT OUTER  JOIN  pMaterialColor b ON a.MaterialColorID = b.MaterialColorID 
		WHERE a.StyleColorID = @StyleColorID3	
		AND a.StyleSet = @StyleSet 
	END


	IF @StyleColorID3 IS NOT NULL 
	BEGIN 
			select a.*, b.*, c.*
			from #tmp1 a INNER JOIN #tmp2  b ON a.StyleMaterialID1 = b.StyleMaterialID2  
			INNER JOIN #tmp3 c ON a.StyleMaterialID1 = c.StyleMaterialID3  
			ORDER BY a.MainMaterial DESC, a.ComponentOrder, 
			a.MaterialSort, a.MaterialNo, a.MaterialName, a.StyleMaterialId  

			DROP TABLE  #tmp1
			DROP TABLE  #tmp2
			DROP TABLE  #tmp3
	END
	ELSE 
	BEGIN 

		IF ( @StyleColorID1 IS NOT NULL ) AND ( @StyleColorID2 IS NOT NULL  ) 
		BEGIN
			select a.*, b.*
			from #tmp1 a INNER JOIN #tmp2  b ON a.StyleMaterialID1 = b.StyleMaterialID2  
			ORDER BY a.MainMaterial DESC, a.ComponentOrder, 
			a.MaterialSort, a.MaterialNo, a.MaterialName, a.StyleMaterialId  

			DROP TABLE  #tmp1
			DROP TABLE  #tmp2
		END 
		ELSE
		BEGIN 
			select a.* 
			from #tmp1 a 
			ORDER BY a.MainMaterial DESC, a.ComponentOrder, 
			a.MaterialSort, a.MaterialNo, a.MaterialName, a.StyleMaterialId  

			DROP TABLE  #tmp1
		END
	END
	SET @ROW1  = @ROW2 + 1 
END 

DROP TABLE #tmpStyleColorway




GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '2.6.9999', '053', GetDate())
GO
