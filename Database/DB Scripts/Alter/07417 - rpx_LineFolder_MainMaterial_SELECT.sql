IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_LineFolder_MainMaterial_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_LineFolder_MainMaterial_SELECT]
GO



CREATE PROCEDURE [dbo].[rpx_LineFolder_MainMaterial_SELECT]
(
	@LineFolderID AS nvarchar(50)
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
	LineFolderItemID nvarchar(50),
	LineFolderItemDrop nvarchar(5),
	LineFolderItemDropUser nvarchar(255),
	LineFolderItemDropDate datetime,
	SizeClass nvarchar(50),
	SizeRange nvarchar(50),
	--MaterialName nvarchar(100),
	MaterialNo nvarchar(500),
	[Version] int
)

DECLARE @SeasonYearID UNIQUEIDENTIFIER
SELECT @SeasonYearID = SeasonYearID FROM pLineFolder WHERE LineFolderID = @LineFolderID

-- seasonal line list
IF @SeasonYearID IS NOT NULL AND @SeasonYearID <> '00000000-0000-0000-0000-000000000000'
BEGIN
	INSERT INTO
		#tempLineFolderStyles
			(StyleID
			, StyleNo
			, [Description]
			, ImageID
			, ImageHistoryID
			, LineFolderItemID
			, LineFolderItemDrop
			, LineFolderItemDropUser
			, LineFolderItemDropDate
			, SizeClass
			, SizeRange
			--, MaterialName
			, MaterialNo
			, [Version])
		SELECT
			b.StyleID
			, b.StyleNo
			, b.[Description]
			, c.ImageID
			, c.ImageHistoryID
			, a.LineFolderItemID
			, a.LineFolderItemDrop
			, a.LineFolderItemDropUser
			, a.LineFolderItemDropDate
			, b.SizeClass
			, b.SizeRange
			--, d.MaterialName
			--, d.MaterialNo
			, STUFF(
			(SELECT ', ' + materials.MaterialNo FROM
				(SELECT sb.MaterialNo FROM pStyleBOM sb
					INNER JOIN pWorkFlowItem wi ON sb.WorkflowItemId = wi.WorkFlowItemID
					INNER JOIN pStyleSeasonYear ssy ON wi.StyleSeasonYearID = ssy.StyleSeasonYearID AND ssy.SeasonYearID = @SeasonYearID
				WHERE sb.StyleID = b.StyleID AND sb.MainMaterial = 1
				UNION
				SELECT sm.MaterialNo FROM pStyleMaterials sm
				WHERE sm.StyleID = b.StyleID AND sm.MainMaterial = 1
				) materials
			FOR XML PATH('')), 1, 2, '') AS MaterialNo
			, c.[Version]
		FROM
			pLineFolderItem a
			INNER JOIN pStyleHeader b ON a.StyleID = b.StyleID
			LEFT OUTER JOIN hImage c ON b.DesignSketchID = c.ImageID
									AND b.DesignSketchVersion = c.Version
			--LEFT OUTER JOIN pMaterial d ON b.MaterialID = d.MaterialID
		WHERE
			a.LineFolderID = @LineFolderID
		ORDER BY
			a.LineFolderItemSort
			, b.StyleNo
			, b.Description
END
ELSE
BEGIN -- non-seasonal line list
	INSERT INTO
		#tempLineFolderStyles
			(StyleID
			, StyleNo
			, [Description]
			, ImageID
			, ImageHistoryID
			, LineFolderItemID
			, LineFolderItemDrop
			, LineFolderItemDropUser
			, LineFolderItemDropDate
			, SizeClass
			, SizeRange
			--, MaterialName
			, MaterialNo
			, [Version])
		SELECT
			b.StyleID
			, b.StyleNo
			, b.[Description]
			, c.ImageID
			, c.ImageHistoryID
			, a.LineFolderItemID
			, a.LineFolderItemDrop
			, a.LineFolderItemDropUser
			, a.LineFolderItemDropDate
			, b.SizeClass
			, b.SizeRange
			--, d.MaterialName
			--, d.MaterialNo
			, STUFF(
			(SELECT ', ' + materials.MaterialNo FROM
				(SELECT sb.MaterialNo FROM pStyleBOM sb
					INNER JOIN pWorkFlowItem wi ON sb.WorkflowItemId = wi.WorkFlowItemID
				WHERE sb.StyleID = b.StyleID AND sb.MainMaterial = 1
				UNION
				SELECT sm.MaterialNo FROM pStyleMaterials sm
				WHERE sm.StyleID = b.StyleID AND sm.MainMaterial = 1
				) materials
			FOR XML PATH('')), 1, 2, '') AS MaterialNo
			, c.[Version]
		FROM
			pLineFolderItem a
			INNER JOIN pStyleHeader b ON a.StyleID = b.StyleID
			LEFT OUTER JOIN hImage c ON b.DesignSketchID = c.ImageID
									AND b.DesignSketchVersion = c.Version
			--LEFT OUTER JOIN pMaterial d ON b.MaterialID = d.MaterialID
		WHERE
			a.LineFolderID = @LineFolderID
		ORDER BY
			a.LineFolderItemSort
			, b.StyleNo
			, b.Description
END

SELECT
	TableRow / 1 AS [Row]
	, TableRow % 1 AS [Column]
	, StyleID
	, StyleNo
	, [Description]
	, dbo.fnx_GetStreamingImagePath(ImageID, [Version]) AS FilePath
	, @LineFolderID AS LineFolderID
	, LineFolderItemID
	, LineFolderItemDrop
	, LineFolderItemDropUser
	, LineFolderItemDropDate
	, SizeClass
	, SizeRange
	--, MaterialName
	, MaterialNo
FROM
	#tempLineFolderStyles

DROP TABLE #tempLineFolderStyles

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07417', GetDate())
GO
