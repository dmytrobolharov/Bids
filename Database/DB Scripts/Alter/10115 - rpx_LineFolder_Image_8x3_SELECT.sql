IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_LineFolder_Image_8x3_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_LineFolder_Image_8x3_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_LineFolder_Image_8x3_SELECT]
( 
	@LineFolderID AS nvarchar(255)
)
AS


CREATE TABLE #tempLineFolderStyles
(
	TableRow int identity(0,1),
	StyleID nvarchar(50),
	StyleNo nvarchar(50),
	[Description] nvarchar(255),
	ImageID nvarchar(50),
	ImageHistoryID nvarchar(50),
	LineFolderItemDrop nvarchar(5),
	LineFolderItemDropUser nvarchar(255),
	LineFolderItemDropDate datetime,
	SizeClass nvarchar(400),
	SizeRange nvarchar(200),
	MaterialName nvarchar(100),
	MaterialNo nvarchar(50),
	[Version] int	--Comment #01
)

/*Insert info into temp table.*/
INSERT INTO #tempLineFolderStyles(StyleID, StyleNo, [Description], ImageID, ImageHistoryID,
	LineFolderItemDrop, LineFolderItemDropUser,	LineFolderItemDropDate, SizeClass, SizeRange, MaterialName,
	MaterialNo, [Version])	--Comment #01
SELECT b.StyleID, b.StyleNo, b.[Description], c.ImageID, c.ImageHistoryID,
	a.LineFolderItemDrop, a.LineFolderItemDropUser, a.LineFolderItemDropDate, 
	COALESCE(sc.Custom, b.SizeClass), COALESCE(sr.SizeRangeCode, b.SizeRange), 
	d.MaterialName,	d.MaterialNo, c.[Version]	--Comment #01
FROM pLineFolderItem a 
INNER JOIN pStyleHeader b ON a.StyleID = b.StyleID 
LEFT OUTER JOIN hImage c ON b.DesignSketchID = c.ImageID AND 
							b.DesignSketchVersion = c.Version 
LEFT OUTER JOIN pMaterial d ON b.MaterialID = d.MaterialID
LEFT JOIN pSizeClass sc ON sc.CustomID = b.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomId = b.SizeRangeId
WHERE LineFolderID = @LineFolderID
ORDER BY a.LineFolderItemSort, b.StyleNo, b.Description


/*Select the information how you want for the report.*/
SELECT
	TableRow / 8 AS Row,
	TableRow % 8 AS [Column],
	StyleID,
	StyleNo,
	[Description],
	dbo.fnx_GetStreamingImagePath(ImageID, [Version], 2000) AS FilePath,	--Comment #01
	@LineFolderID AS LineFolderID,
	LineFolderItemDrop,
	'Dropped By ' + LineFolderItemDropUser + ' - ' + CAST(LineFolderItemDropDate AS nvarchar(50)) AS DroppedInfo,
	SizeClass,
	SizeRange,
	MaterialName,
	MaterialNo
FROM #tempLineFolderStyles

DROP TABLE #tempLineFolderStyles


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10115', GetUTCDate())
GO