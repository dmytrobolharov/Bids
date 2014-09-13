IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_LineFolder_MainMaterial_Image_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_LineFolder_MainMaterial_Image_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[rpx_LineFolder_MainMaterial_Image_SELECT]
( 
	@LineFolderItemID varchar(50)
)
AS

CREATE TABLE #tempMainMaterialImages
(
	TableRow int identity(0,1)
	, ColorFolderID uniqueidentifier
	, ColorPaletteID uniqueidentifier
	, ColorCode nvarchar(50)
	, ColorName nvarchar(150)
	, SColorCode nvarchar(50)
	, SColorName nvarchar(150)
	, MatColorImageId uniqueidentifier
	, MatColorImageVersion int
)

INSERT INTO
	#tempMainMaterialImages
		(ColorFolderID
		, ColorPaletteID
		, ColorCode
		, ColorName
		, SColorCode
		, SColorName
		, MatColorImageId
		, MatColorImageVersion)
		exec spx_LineFolderItemColorChip_SELECT @LineFolderItemID ,2

SELECT 
	TableRow / 7 AS [Row]
	, TableRow % 7 AS [Column]
	, dbo.fnx_GetStreamingColorImagePath(ColorFolderID, ColorPaletteID) as FilePath
	, ColorName
	, ColorCode
FROM
	#tempMainMaterialImages
 
DROP TABLE #tempMainMaterialImages


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04684', GetDate())
GO