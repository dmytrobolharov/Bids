/*
Comments:

#01 - Ryan Cabanas - September 23, 2009
	Replace the old image string with the new image string using function.
Deleted old code.  Needed to add the 'Version' field to the temp table for
the image stream and get the 'Version' from 'hImage' to put in the temp table.
*/


ALTER    PROCEDURE [dbo].[rpx_LineFolder_Image_8x3_SELECT]
( 
	@LineFolderID AS varchar(255)
)
AS


CREATE TABLE #tempLineFolderStyles
(
	TableRow int identity(0,1),
	StyleID varchar(50),
	StyleNo varchar(50),
	[Description] nvarchar(255),
	ImageID varchar(50),
	ImageHistoryID varchar(50),
	LineFolderItemDrop varchar(5),
	LineFolderItemDropUser nvarchar(255),
	LineFolderItemDropDate datetime,
	SizeClass nvarchar(50),
	SizeRange nvarchar(50),
	MaterialName nvarchar(100),
	MaterialNo nvarchar(50),
	[Version] int	--Comment #01
)

/*Insert info into temp table.*/
INSERT INTO #tempLineFolderStyles(StyleID, StyleNo, [Description], ImageID, ImageHistoryID,
	LineFolderItemDrop, LineFolderItemDropUser,	LineFolderItemDropDate, SizeClass, SizeRange, MaterialName,
	MaterialNo, [Version])	--Comment #01
SELECT b.StyleID, b.StyleNo, b.[Description], c.ImageID, c.ImageHistoryID,
	a.LineFolderItemDrop, a.LineFolderItemDropUser, a.LineFolderItemDropDate, b.SizeClass, b.SizeRange, d.MaterialName,
	d.MaterialNo, c.[Version]	--Comment #01
FROM pLineFolderItem a INNER JOIN pStyleHeader b ON
a.StyleID = b.StyleID INNER JOIN hImage c ON
b.DesignSketchID = c.ImageID AND b.DesignSketchVersion = c.Version LEFT OUTER JOIN pMaterial d ON
b.MaterialID = d.MaterialID
WHERE LineFolderID = @LineFolderID
ORDER BY a.LineFolderItemSort, b.StyleNo, b.Description


/*Select the information how you want for the report.*/
SELECT
	TableRow / 8 AS Row,
	TableRow % 8 AS [Column],
	StyleID,
	StyleNo,
	[Description],
	dbo.fnx_GetStreamingImagePath(ImageID, [Version]) AS FilePath,	--Comment #01
	@LineFolderID AS LineFolderID,
	LineFolderItemDrop,
	'Dropped By ' + LineFolderItemDropUser + ' - ' + CAST(LineFolderItemDropDate AS varchar(50)) AS DroppedInfo,
	SizeClass,
	SizeRange,
	MaterialName,
	MaterialNo
FROM #tempLineFolderStyles

DROP TABLE #tempLineFolderStyles
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '837', GetDate())
GO