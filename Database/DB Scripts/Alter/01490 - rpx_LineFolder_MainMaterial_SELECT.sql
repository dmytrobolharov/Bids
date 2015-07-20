IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_LineFolder_MainMaterial_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[rpx_LineFolder_MainMaterial_SELECT]
GO


/*
Comments:

#01 - Ryan Cabanas - September 23, 2009
	Replace the old image string with the new image string using function.
Deleted old code.  Needed to add the 'Version' field to the temp table for
the image stream and get the 'Version' from 'hImage' to put in the temp table.
*/


CREATE PROCEDURE [dbo].[rpx_LineFolder_MainMaterial_SELECT]
(
	@LineFolderID AS varchar(50)
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
a.StyleID = b.StyleID LEFT OUTER JOIN hImage c ON
b.DesignSketchID = c.ImageID AND b.DesignSketchVersion = c.Version LEFT OUTER JOIN pMaterial d ON
b.MaterialID = d.MaterialID
WHERE a.LineFolderID = @LineFolderID
ORDER BY a.LineFolderItemSort, b.StyleNo, b.Description

/*Select the information how you want for the report.*/
SELECT
	TableRow / 3 AS [Row],
	TableRow % 3 AS [Column],
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
VALUES ('DB_Version', '4.1.0000', '01490', GetDate())
GO