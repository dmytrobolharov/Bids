IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_LineFolder_MainMaterial_Image_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_LineFolder_MainMaterial_Image_SELECT]
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[rpx_LineFolder_MainMaterial_Image_SELECT]
( 
	@LineFolderItemID nvarchar(50)
)
AS

DECLARE @SeasonYearID UNIQUEIDENTIFIER
SELECT @SeasonYearID = lf.SeasonYearID
FROM pLineFolderItem lfi 
INNER JOIN pLineFolder lf ON lfi.LineFolderID = lf.LineFolderID
WHERE lfi.LineFolderItemID = @LineFolderItemID

CREATE TABLE #tempMainMaterialImages
(
	TableRow int identity(0,1)
	, LineFolderItemColorID uniqueidentifier
	, LineFolderItemID uniqueidentifier
	, ColorFolderID uniqueidentifier
	, ColorPaletteID uniqueidentifier
	, ColorCode nvarchar(50)
	, ColorName nvarchar(150)
	, SColorCode nvarchar(50)
	, SColorName nvarchar(150)
	, MatColorImageId nvarchar(40)
	, MatColorImageVersion int
	, Sort nvarchar(10)
	, IsVisible int
	, StyleColorID int
	, LineFolderItemColorDrop int
)

IF @SeasonYearID <> '00000000-0000-0000-0000-000000000000'
BEGIN
	INSERT INTO #tempMainMaterialImages (
		  LineFolderItemID
		, ColorFolderID
		, ColorPaletteID
		, ColorCode
		, ColorName
		, SColorCode
		, SColorName
		, StyleColorID
		, Sort
		, IsVisible
		, MatColorImageId
		, MatColorImageVersion				
		, LineFolderItemColorDrop
	) EXEC spx_LineFolderItem_StyleBOMColorwaysFolder_SELECT @LineFolderItemID
END
ELSE
BEGIN
	INSERT INTO #tempMainMaterialImages (
		  LineFolderItemColorID
		, LineFolderItemID
		, ColorFolderID
		, ColorPaletteID
		, ColorCode
		, ColorName
		, SColorCode
		, SColorName
		, MatColorImageId
		, MatColorImageVersion
		, Sort
		, LineFolderItemColorDrop
	) EXEC spx_LineFolderItemColorChip_SELECT @LineFolderItemID, 2
END

SELECT 
	TableRow / 7 AS [Row]
	, TableRow % 7 AS [Column]
	, dbo.fnx_GetStreamingColorImagePath(ColorFolderID, ColorPaletteID, '100') as FilePath
	, ColorName
	, ColorCode
FROM
	#tempMainMaterialImages
 
DROP TABLE #tempMainMaterialImages



GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10118', GetUTCDate())
GO