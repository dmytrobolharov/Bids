IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_LineFolder_Image_4x0_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_LineFolder_Image_4x0_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[rpx_LineFolder_Image_4x0_SELECT]
( 
	@LineFolderID AS varchar(255)
)
AS


CREATE TABLE #tempLineFolderStyles
(
	TableRow int identity(0,1)
	, StyleID varchar(50)
	, StyleNo varchar(50)
	, [Description] nvarchar(255)
	, ImageID varchar(50)
	, ImageHistoryID varchar(50)
	, LineFolderItemDrop varchar(5)
	, LineFolderItemDropUser nvarchar(255)
	, LineFolderItemDropDate datetime
	, SizeClass nvarchar(50)
	, SizeRange nvarchar(50)
	, MaterialName nvarchar(100)
	, MaterialNo nvarchar(50)
	, [Version] int
	, StyleCategory nvarchar(255)
)

INSERT INTO
	#tempLineFolderStyles
		(StyleID
		, StyleNo
		, [Description]
		, ImageID
		, ImageHistoryID
		, LineFolderItemDrop
		, LineFolderItemDropUser
		, LineFolderItemDropDate
		, SizeClass
		, SizeRange
		, MaterialName
		, MaterialNo
		, [Version]
		, StyleCategory)
SELECT
	b.StyleID
	, b.StyleNo
	, b.[Description]
	, c.ImageID
	, c.ImageHistoryID
	, a.LineFolderItemDrop
	, a.LineFolderItemDropUser
	, a.LineFolderItemDropDate
	, b.SizeClass
	, b.SizeRange
	, d.MaterialName
	, d.MaterialNo
	, c.[Version]
	, sc.StyleCategory
FROM
	pLineFolderItem a
	INNER JOIN pStyleHeader b ON a.StyleID = b.StyleID
	LEFT OUTER JOIN hImage c ON b.DesignSketchID = c.ImageID
							AND b.DesignSketchVersion = c.Version
	LEFT OUTER JOIN pMaterial d ON b.MaterialID = d.MaterialID
	LEFT OUTER JOIN pStyleCategory sc ON b.StyleCategory = sc.StyleCategoryId	
WHERE
	LineFolderID = @LineFolderID
ORDER BY
	a.LineFolderItemSort
	, b.StyleNo
	, b.Description

SELECT
	TableRow / 4 AS [Row]
	, TableRow % 4 AS [Column]
	, StyleID
	, StyleNo
	, [Description]
	, dbo.fnx_GetStreamingImagePath(ImageID, [Version]) AS FilePath
	, @LineFolderID AS LineFolderID
	, LineFolderItemDrop
	, LineFolderItemDropUser
	, LineFolderItemDropDate
	, SizeClass
	, SizeRange
	, MaterialName
	, MaterialNo
	, StyleCategory
FROM
	#tempLineFolderStyles

DROP TABLE #tempLineFolderStyles

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04680', GetDate())
GO
