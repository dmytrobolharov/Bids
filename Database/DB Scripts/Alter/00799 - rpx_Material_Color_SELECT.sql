/*
Comments:

#01 - Ryan Cabanas - September 23, 2009
	Replace the old color image string with the new color image string using function.
Deleted old code.
*/


ALTER      PROCEDURE [dbo].[rpx_Material_Color_SELECT]
(
	@MaterialID varchar(255) 	
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
FROM pMaterialColor
WHERE MaterialID = @MaterialID
ORDER BY Sort, ColorCode, ColorName

SELECT @TotalCount = COUNT(*) FROM #TempColorPaletteIDs
SET @RowCounter = 1

WHILE (@RowCounter <= @TotalCount)
	BEGIN

		INSERT INTO #TempColorMatrix (FilePath, ColorName, ColorCode, Sort)
		SELECT
			dbo.fnx_GetStreamingColorImagePath(ColorFolderID, ColorPaletteID) AS FilePath,	--Comment #01
			ColorName,
			ColorCode,
			Sort
		FROM #TempColorPaletteIDs
		WHERE TableRow = @RowCounter

		SET @RowCounter = @RowCounter + 1
	END

SELECT TableRow % 7 AS [Column], TableRow / 7 AS Row, FilePath, ColorName, ColorCode, Sort 
FROM #TempColorMatrix 

DROP TABLE #TempColorPaletteIDs
DROP TABLE #TempColorMatrix
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '799', GetDate())
GO