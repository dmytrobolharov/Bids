IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_LineFolder_MainMaterial20_Image_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_LineFolder_MainMaterial20_Image_SELECT]
GO

CREATE           PROCEDURE [dbo].[rpx_LineFolder_MainMaterial20_Image_SELECT]
( 
	@LineFolderID nvarchar(50),
	@StyleID nvarchar(50)
)
AS

DECLARE @TotalCount int
DECLARE @RowCounter int
DECLARE @StyleColorID nvarchar(50)
DECLARE @StyleColorName nvarchar(200)
DECLARE @StyleColorNo nvarchar(10)


CREATE TABLE #tempStyleColorways
(
	TableRow int identity(1,1),
	StyleColorID nvarchar(50),
	StyleID nvarchar(50),
	StyleColorName nvarchar(200),
	StyleColorNo nvarchar(10)
)

CREATE TABLE #tempMainMaterialImages
(
	TableRow int identity(0,1),
	FilePath nvarchar(255),
	StyleID nvarchar(50),
	ColorName nvarchar(150),
	ColorCode nvarchar(50),
	ColorFolderID nvarchar(50),
	ColorPaletteID nvarchar(50),
	MainColor nvarchar(50),
	MainColorNo nvarchar(10),
	NoImage int
)

/*Get the colorways that are active for the style.*/
INSERT INTO #tempStyleColorways (StyleColorID, StyleID, StyleColorNo, StyleColorName)
SELECT a.StyleColorID, a.StyleID, a.StyleColorNo, a.StyleColorName
FROM pStyleColorway a INNER JOIN pLineFolderItemColor b ON
a.StyleID = b.StyleID AND a.StyleColorID = b.StyleColorID AND
(b.LineFolderItemColorDrop = 0 OR b.LineFolderItemColorDrop IS NULL)
WHERE b.LineFolderID = @LineFolderID AND b.StyleID = @StyleID
ORDER BY a.Sort, a.StyleColorName, a.StyleColorID

/*Get the count and set the counter.*/
SELECT @TotalCount = COUNT(*) FROM #tempStyleColorways
SET @RowCounter = 1

/*Begin loop to get final record data one at a time in order to capture blanks, as well.*/
WHILE (@RowCounter <= @TotalCount)
	BEGIN
		/*Get the active colorways one at a time.*/
		SELECT
			@StyleColorID = StyleColorID,
			@StyleColorName = StyleColorName,
			@StyleColorNo = StyleColorNo
		FROM #tempStyleColorways
		WHERE TableRow = @RowCounter

		/*Put a real, or bogus, record into the temp table.*/
		IF (SELECT COUNT(*)
			FROM pStyleColorwayItem INNER JOIN pMaterialColor ON
				pStyleColorwayItem.MaterialColorID = pMaterialColor.MaterialColorID INNER JOIN pStyleColorway ON
				pStyleColorwayItem.StyleColorID = pStyleColorway.StyleColorID INNER JOIN pLineFolderItemColor ON
				pStyleColorway.StyleColorID = pLineFolderItemColor.StyleColorID INNER JOIN pStyleMaterials ON
				pStyleColorwayItem.StyleMaterialID = pStyleMaterials.StyleMaterialID LEFT OUTER JOIN pLineFolderItem ON
				pLineFolderItemColor.LineFolderItemID = pLineFolderItem.LineFolderItemID
			WHERE	(pStyleMaterials.MainMaterial = 1) AND (pLineFolderItemColor.LineFolderID = @LineFolderID) AND
					(pLineFolderItemColor.StyleID = @StyleID) AND (pLineFolderItemColor.StyleColorID = @StyleColorID)
		   ) = 0
			BEGIN
				/*Put a blank in for Styles that have no images.*/
				INSERT INTO #tempMainMaterialImages (StyleID, ColorName, ColorCode,	ColorFolderID, ColorPaletteID, MainColor, MainColorNo, NoImage)
				VALUES (@StyleID, NULL, NULL, NULL, NULL, @StyleColorName, @StyleColorNo, 1)
		
			END
		ELSE
			BEGIN
				/*Put records in for Main Materials with chips.*/
				INSERT INTO #tempMainMaterialImages (StyleID, ColorName, ColorCode,	ColorFolderID, ColorPaletteID, MainColor, MainColorNo, NoImage)
				SELECT
					pLineFolderItemColor.StyleID, 
					pMaterialColor.ColorName,
					pMaterialColor.ColorCode,
					pMaterialColor.ColorFolderID,
					pMaterialColor.ColorPaletteID,
					pStyleColorway.MainColor,
					pStyleColorway.StyleColorNo,
					0 AS NoImage
				FROM pStyleColorwayItem INNER JOIN
					pMaterialColor ON pStyleColorwayItem.MaterialColorID = pMaterialColor.MaterialColorID INNER JOIN
					pStyleColorway ON pStyleColorwayItem.StyleColorID = pStyleColorway.StyleColorID INNER JOIN
					pLineFolderItemColor ON pStyleColorway.StyleColorID = pLineFolderItemColor.StyleColorID INNER JOIN
					pStyleMaterials ON pStyleColorwayItem.StyleMaterialID = pStyleMaterials.StyleMaterialID LEFT OUTER JOIN
					pLineFolderItem ON pLineFolderItemColor.LineFolderItemID = pLineFolderItem.LineFolderItemID
				WHERE	(pStyleMaterials.MainMaterial = 1) AND (pLineFolderItemColor.LineFolderID = @LineFolderID) AND
						(pLineFolderItemColor.StyleID = @StyleID) AND (pLineFolderItemColor.StyleColorID = @StyleColorID)

			END

		SET @RowCounter = @RowCounter + 1
	END

/*Create the URL for the Images.*/
UPDATE #tempMainMaterialImages
SET FilePath = dbo.fnx_GetStreamingColorImagePath(ColorFolderID, ColorPaletteID, '100')	
FROM #tempMainMaterialImages

SELECT 
	TableRow % 5 AS [Column],
	FilePath,
	StyleID,
	ColorName,
	ColorCode,
	MainColor,
	MainColorNo,
	NoImage
FROM #tempMainMaterialImages

DROP TABLE #tempStyleColorways
DROP TABLE #tempMainMaterialImages


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10117', GetUTCDate())
GO