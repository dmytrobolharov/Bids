IF OBJECT_ID(N'[dbo].[rpx_LineFolder_Global_4x0_Category_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[rpx_LineFolder_Global_4x0_Category_SELECT]
GO

CREATE Procedure [dbo].[rpx_LineFolder_Global_4x0_Category_SELECT]
	@Season nvarchar(50) = null
	, @Year nvarchar(50) = null
	, @Category nvarchar(50) = null
	, @CategoryFrom int = -999
	, @SortBy int = -999
as

DECLARE @StrCategory nvarchar(255)

IF @SortBy IS NULL or @SortBy = -999
	SET @SortBy = 1

IF @CategoryFrom IS NULL or @CategoryFrom = -999
	SET @CategoryFrom = 1

CREATE TABLE #tempLineFolderStyles
(
	TableRow int identity(0,1)
	, StyleID nvarchar(50)
	, StyleNo nvarchar(50)
	, [Description] nvarchar(255)
	, ImageID nvarchar(50)
	, ImageHistoryID nvarchar(50)
	, SizeClass nvarchar(400)
	, SizeRange nvarchar(200)
	, MaterialName nvarchar(100)
	, MaterialNo nvarchar(50)
	, Colorways nvarchar(2000)
	, ItemCategory nvarchar(200)
	, [Version] int
)

IF @CategoryFrom = 1 and @SortBy = 1
BEGIN
	INSERT INTO #tempLineFolderStyles(
		StyleID
		, StyleNo
		, [Description]
		, ImageID
		, ImageHistoryID
		, SizeClass
		, SizeRange
		, MaterialName
		, MaterialNo
		, ItemCategory
		, [Version]
	)
	SELECT
		b.StyleID
		, b.StyleNo
		, b.[Description]
		, c.ImageID
		, c.ImageHistoryID
		, COALESCE(sc.Custom, b.SizeClass)
		, COALESCE(sr.SizeRangeCode, b.SizeRange)
		, d.MaterialName
		, d.MaterialNo
		, e.StyleCategory
		, c.[Version]
	FROM
		pStyleHeader b 
		INNER JOIN pStyleSeasonYear ON b.StyleID = pStyleSeasonYear.StyleID
		INNER JOIN pSeasonYear On pStyleSeasonYear.SeasonYearID = PSeasonYear.SeasonYearID
		LEFT OUTER JOIN hImage c ON b.DesignSketchID = c.ImageID AND b.DesignSketchVersion = c.Version 
		LEFT OUTER JOIN pMaterial d ON b.MaterialID = d.MaterialID
		LEFT OUTER JOIN pStyleCategory e ON	b.StyleCategory = e.StyleCategoryID
		LEFT JOIN pSizeClass sc ON sc.CustomID = b.SizeClassId
		LEFT JOIN pSizeRange sr ON sr.CustomId = b.SizeRangeId
	WHERE
		(@Season IS NULL OR pSeasonYear.Season = @Season)
		AND (@Year IS NULL OR pSeasonYear.[Year] = @Year)
		AND (@Category is null or b.StyleCategory = @Category)
	ORDER BY
		e.StyleCategory, b.StyleNo, b.[Description]
END

IF @CategoryFrom = 1 and @SortBy = 2
BEGIN
	INSERT INTO #tempLineFolderStyles(
		StyleID
		, StyleNo
		, [Description]
		, ImageID
		, ImageHistoryID
		, SizeClass
		, SizeRange
		, MaterialName
		, MaterialNo
		, ItemCategory
		, [Version]
	)
	SELECT
		b.StyleID
		, b.StyleNo
		, b.[Description]
		, c.ImageID
		, c.ImageHistoryID
		, COALESCE(sc.Custom, b.SizeClass)
		, COALESCE(sr.SizeRangeCode, b.SizeRange)
		, d.MaterialName
		, d.MaterialNo
		, e.StyleCategory
		, c.[Version]
	FROM
		pStyleHeader b 
		INNER JOIN pStyleSeasonYear ON b.StyleID = pStyleSeasonYear.StyleID
		INNER JOIN pSeasonYear On pStyleSeasonYear.SeasonYearID = PSeasonYear.SeasonYearID
		LEFT OUTER JOIN hImage c ON b.DesignSketchID = c.ImageID AND b.DesignSketchVersion = c.Version 
		LEFT OUTER JOIN pMaterial d ON b.MaterialID = d.MaterialID
		LEFT OUTER JOIN pStyleCategory e ON	b.StyleCategory = e.StyleCategoryID
		LEFT JOIN pSizeClass sc ON sc.CustomID = b.SizeClassId
		LEFT JOIN pSizeRange sr ON sr.CustomId = b.SizeRangeId
	WHERE
		(@Season IS NULL OR pSeasonYear.Season = @Season)
		AND (@Year IS NULL OR pSeasonYear.[Year] = @Year)
		AND (@Category is null or b.StyleCategory = @Category)
	ORDER BY
		b.StyleNo, e.StyleCategory, b.[Description]
END

create table #StyleColorways
(
	RowNum int identity(1,1)
	, StyleID nvarchar(50)
	, MainColor nvarchar(100)
)

insert #StyleColorways (StyleID, MainColor)
select StyleID, MainColor
from pStyleColorway
where StyleID in (select StyleID from #tempLineFolderStyles)

declare @counter int, @maxcount int
set @counter = 1

select @maxcount = max(RowNum)
from #StyleColorways

while (@counter <= @maxcount)
begin
	update s
	set s.Colorways = isnull(s.Colorways, '') + rtrim(c.MainColor) + ', '
	from #tempLineFolderStyles s
	inner join #StyleColorways c on s.StyleID = c.StyleID
	where c.RowNum = @counter

	set @counter = @counter + 1
end

SELECT
	TableRow / 4 AS [Row],
	TableRow % 4 AS [Column],
	@StrCategory AS Category,
	StyleID,
	StyleNo,
	[Description],
	dbo.fnx_GetStreamingImagePath(ImageID, [Version]) AS FilePath,
	SizeClass,
	SizeRange,
	MaterialName,
	MaterialNo,
	substring(Colorways, 1, len(Colorways)-1) as Colorways,
	ItemCategory
FROM #tempLineFolderStyles
ORDER BY TableRow

drop table #StyleColorways
DROP TABLE #tempLineFolderStyles


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09592', GetDate())
GO
