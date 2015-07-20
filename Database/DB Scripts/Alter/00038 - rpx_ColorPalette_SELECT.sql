INSERT INTO [dbo].[sVersion]
    (AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '038', GetDate())

GO


ALTER      PROCEDURE [dbo].[rpx_ColorPalette_SELECT]
(
	@ColorFolderID nvarchar(255)
)

AS

DECLARE @ImageFolder varchar(200)
SET @ImageFolder = (SELECT TOP 1 SettingValue FROM rReportSetting WHERE SettingType = 'ImageColorPath')


SELECT 
0 AS TableRow,
0 AS [Column],
IDENTITY(INT,1,1) AS RowID  ,
@ImageFolder + '/' + CAST(ColorFolderID AS NVARCHAR(40)) + '/' + CAST(ColorPaletteID AS NVARCHAR(40)) + '/600.jpg' AS FilePath,
ColorName,
ColorCode,
Sort
INTO #tmpColor
FROM pColorPalette 
WHERE ColorFolderID = @ColorFolderID
ORDER BY Sort, ColorCode, ColorName

UPDATE #tmpColor SET [Column] = RowID % 7 

DECLARE @ROWID INT
DECLARE @TOTAL INT 
DECLARE @TABLEROW INT 

SELECT @TOTAL = COUNT(*) FROM #tmpColor 
SET @ROWID = 1
SET @TABLEROW  = 1

DECLARE @CONT INT 
SET @CONT = 1


WHILE @ROWID <= @TOTAL 
BEGIN

	UPDATE #tmpColor SET  TableRow = @TABLEROW  WHERE RowID = @ROWID 

	SET @CONT = @CONT + 1 
	IF @CONT > 7
	BEGIN
		SET  @CONT  = 1 
		SET @TABLEROW = @TABLEROW + 1
	END 
	
	SET @ROWID = @ROWID  + 1 
END 

select * from #tmpColor 

DROP TABLE #tmpColor


/*For Test Run*/
-- DECLARE @ColorFolderID nvarchar(255)
-- SET @ColorFolderID = '25d32611-49c7-44f2-bb7a-02d191a3aeb2'
/*
DECLARE @ImageFolder varchar(200)
DECLARE @TotalCount int
DECLARE @RowCounter int
 
SET @ImageFolder = (SELECT TOP 1 SettingValue FROM rReportSetting WHERE SettingType = 'ImageColorPath')

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
SELECT   ColorFolderID, ColorPaletteID, ColorName, ColorCode, Sort
FROM pColorPalette
WHERE ColorFolderID = @ColorFolderID
ORDER BY Sort, ColorCode, ColorName

SELECT @TotalCount = COUNT(*) FROM #TempColorPaletteIDs
SET @RowCounter = 1

WHILE (@RowCounter <= @TotalCount)
	BEGIN

		INSERT INTO #TempColorMatrix (FilePath, ColorName, ColorCode, Sort)
		SELECT
			@ImageFolder + '/' + ColorFolderID + '/' + ColorPaletteID + '/600.jpg' AS FilePath,
			ColorName,
			ColorCode,
			Sort
		FROM #TempColorPaletteIDs
		WHERE TableRow = @RowCounter

		SET @RowCounter = @RowCounter + 1
	END

SELECT TableRow % 7 AS [Column], FilePath, ColorName, ColorCode, Sort 
FROM #TempColorMatrix 

DROP TABLE #TempColorPaletteIDs
DROP TABLE #TempColorMatrix

*/

GO