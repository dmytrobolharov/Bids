IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_LineFolder_MainMaterial_Image_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_LineFolder_MainMaterial_Image_SELECT]
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE  PROCEDURE [dbo].[rpx_LineFolder_MainMaterial_Image_SELECT]
( 
	@LineFolderID varchar(50),
	@StyleID varchar(50)
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
	StyleColorID varchar(50),
	StyleID varchar(50),
	StyleColorName nvarchar(200),
	StyleColorNo nvarchar(200)
)

CREATE TABLE #tempMainMaterialImages
(
	TableRow int identity(0,1),
	FilePath varchar(255),
	StyleID varchar(50),
	ColorName nvarchar(150),
	ColorCode nvarchar(50),
	ColorFolderID varchar(50),
	ColorPaletteID varchar(50),
	MainColor nvarchar(50),
	MainColorNo nvarchar(200),
	NoImage int,
	ImageID varchar(50),
	ImageHistoryID varchar(50),
	[Version] int
)

INSERT INTO #tempStyleColorways
	(StyleColorID
	, StyleID
	, StyleColorNo
	, StyleColorName)
SELECT
	a.StyleColorID
	, a.StyleID
	, a.StyleColorNo
	, a.StyleColorName
FROM
	pStyleColorway a
	INNER JOIN pLineFolderItemColor b ON a.StyleID = b.StyleID
									AND a.StyleColorID = b.StyleColorID
									AND (b.LineFolderItemColorDrop = 0 OR b.LineFolderItemColorDrop IS NULL)
WHERE
	b.LineFolderID = @LineFolderID
	AND b.StyleID = @StyleID
ORDER BY
	a.Sort
	, a.StyleColorName
	, a.StyleColorID

SELECT @TotalCount = COUNT(*) FROM #tempStyleColorways
SET @RowCounter = 1

WHILE (@RowCounter <= @TotalCount)
	BEGIN
		SELECT
			@StyleColorID = StyleColorID,
			@StyleColorName = StyleColorName,
			@StyleColorNo = StyleColorNo
		FROM #tempStyleColorways
		WHERE TableRow = @RowCounter

		IF (SELECT COUNT(*)
			FROM pStyleColorwayItem
				INNER JOIN pMaterialColor ON pStyleColorwayItem.MaterialColorID = pMaterialColor.MaterialColorID
				INNER JOIN pStyleColorway ON pStyleColorwayItem.StyleColorID = pStyleColorway.StyleColorID
				INNER JOIN pLineFolderItemColor ON pStyleColorway.StyleColorID = pLineFolderItemColor.StyleColorID
				INNER JOIN pStyleMaterials ON pStyleColorwayItem.StyleMaterialID = pStyleMaterials.StyleMaterialID
				LEFT OUTER JOIN pLineFolderItem ON pLineFolderItemColor.LineFolderItemID = pLineFolderItem.LineFolderItemID
			WHERE	(pStyleMaterials.MainMaterial = 1)
					AND (pLineFolderItemColor.LineFolderID = @LineFolderID)
					AND	(pLineFolderItemColor.StyleID = @StyleID)
					AND (pLineFolderItemColor.StyleColorID = @StyleColorID)
			) = 0
			BEGIN
				INSERT INTO #tempMainMaterialImages (StyleID, ColorName, ColorCode,	ColorFolderID, ColorPaletteID, MainColor, MainColorNo, NoImage, ImageID, ImageHistoryID, [Version])	--Comment #01
				VALUES (@StyleID, NULL, NULL, NULL, NULL, @StyleColorName, @StyleColorNo, 1, NULL, NULL, NULL)	--Comment #01
		
			END
		ELSE
			BEGIN
				INSERT INTO #tempMainMaterialImages (StyleID, ColorName, ColorCode,	ColorFolderID, ColorPaletteID, MainColor, MainColorNo, NoImage, ImageID, ImageHistoryID, [Version])	--Comment #01
				SELECT
					pLineFolderItemColor.StyleID, 
					pMaterialColor.ColorName,
					pMaterialColor.ColorCode,
					pMaterialColor.ColorFolderID,
					pMaterialColor.ColorPaletteID,
					pStyleColorway.MainColor,
					pStyleColorway.StyleColorNo,
					0 AS NoImage,
					i.ImageID,
					i.ImageHistoryID,
					i.[Version]
				FROM pStyleColorwayItem INNER JOIN
					pMaterialColor ON pStyleColorwayItem.MaterialColorID = pMaterialColor.MaterialColorID
					INNER JOIN pStyleColorway ON pStyleColorwayItem.StyleColorID = pStyleColorway.StyleColorID
					INNER JOIN pLineFolderItemColor ON pStyleColorway.StyleColorID = pLineFolderItemColor.StyleColorID
					INNER JOIN pStyleMaterials ON pStyleColorwayItem.StyleMaterialID = pStyleMaterials.StyleMaterialID
					LEFT OUTER JOIN pLineFolderItem ON pLineFolderItemColor.LineFolderItemID = pLineFolderItem.LineFolderItemID
					LEFT OUTER JOIN hImage i on pMaterialColor.MaterialColorImageID = i.ImageID and pMaterialColor.MaterialColorImageVersion = i.Version
				WHERE	(pStyleMaterials.MainMaterial = 1) AND (pLineFolderItemColor.LineFolderID = @LineFolderID) AND
						(pLineFolderItemColor.StyleID = @StyleID) AND (pLineFolderItemColor.StyleColorID = @StyleColorID)

			END

		SET @RowCounter = @RowCounter + 1
	END

UPDATE #tempMainMaterialImages
SET FilePath = dbo.fnx_GetStreamingColorImagePath(ColorFolderID, ColorPaletteID)
FROM #tempMainMaterialImages
WHERE ColorFolderID is not null

UPDATE #tempMainMaterialImages
SET FilePath = dbo.fnx_GetStreamingImagePath(ImageID, [Version])
FROM #tempMainMaterialImages
WHERE ImageID is not null 
and FilePath is null

SELECT 
	TableRow / 7 AS [Row],
	TableRow % 7 AS [Column],
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
VALUES     ('DB_Version', '5.0.0000', '04676', GetDate())
GO
