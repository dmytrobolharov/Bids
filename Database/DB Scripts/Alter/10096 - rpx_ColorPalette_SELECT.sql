IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_ColorPalette_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_ColorPalette_SELECT]
GO

CREATE      PROCEDURE [dbo].[rpx_ColorPalette_SELECT]
(
	@ColorFolderID nvarchar(255)
)

AS

DECLARE @TotalCount int
DECLARE @RowCounter int

CREATE TABLE #TempColorPaletteIDs
(
	TableRow int identity(1,1),
	ColorFolderID nvarchar(200),
	ColorPaletteID nvarchar(200),
	ColorName nvarchar(150),
	ColorCode nvarchar(50),
	Sort nvarchar(10)
)

CREATE TABLE #TempColorMatrix
(
	TableRow int identity(0,1),
	FilePath nvarchar(255),
	ColorName nvarchar(150),
	ColorCode nvarchar(50),
	Sort nvarchar(10)
)

INSERT INTO #TempColorPaletteIDs (ColorFolderID, ColorPaletteID, ColorName, ColorCode, Sort)
SELECT ColorFolderID, ColorPaletteID, ColorName, ColorCode, Sort
FROM pColorPalette
WHERE ColorFolderID = @ColorFolderID
ORDER BY Sort, ColorCode, ColorName

SELECT @TotalCount = COUNT(*) FROM #TempColorPaletteIDs
SET @RowCounter = 1

WHILE (@RowCounter <= @TotalCount)
	BEGIN

		INSERT INTO #TempColorMatrix (FilePath, ColorName, ColorCode, Sort)
		SELECT
			dbo.fnx_GetStreamingColorImagePath(ColorFolderID, ColorPaletteID, '100') AS FilePath,		
			ColorName,
			ColorCode,
			Sort
		FROM #TempColorPaletteIDs
		WHERE TableRow = @RowCounter

		SET @RowCounter = @RowCounter + 1
	END

SELECT TableRow / 7 AS [Row], TableRow % 7 AS [Column], FilePath, ColorName, ColorCode, Sort 
FROM #TempColorMatrix 

DROP TABLE #TempColorPaletteIDs
DROP TABLE #TempColorMatrix


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10096', GetUTCDate())
GO