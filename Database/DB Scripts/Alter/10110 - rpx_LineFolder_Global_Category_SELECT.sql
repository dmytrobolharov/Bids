IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_LineFolder_Global_Category_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_LineFolder_Global_Category_SELECT]
GO

CREATE procedure [dbo].[rpx_LineFolder_Global_Category_SELECT]
	@Season nvarchar(50) = null,
	@Year nvarchar(50) = null,
	@Category nvarchar(50) = null,

	@CategoryFrom int = -999,   -- Category From Table or custome field
	@SortBy	int = -999
as

/*Test values*/
-- DECLARE	@Season nvarchar(50)
-- DECLARE	@Year nvarchar(50)
-- DECLARE	@Category nvarchar(50)
-- SET @Season = NULL
-- SET @Year = NULL
-- SET @Category = NULL


/*Variables*/
DECLARE @StrCategory nvarchar(255)

IF @SortBy IS NULL or @SortBy = -999
BEGIN
 SET @SortBy = 1
END


IF @CategoryFrom IS NULL or @CategoryFrom = -999
BEGIN
 SET @CategoryFrom = 1
END

/*Create temp tables*/
CREATE TABLE #tempLineFolderStyles
(
	TableRow int identity(0,1),
	StyleID nvarchar(50),
	StyleNo nvarchar(50),
	[Description] nvarchar(255),
	ImageID nvarchar(50),
	ImageHistoryID nvarchar(50),
	SizeClass nvarchar(400),
	SizeRange nvarchar(200),
	MaterialName nvarchar(100),
	MaterialNo nvarchar(50),
	Colorways nvarchar(2000),
	ItemCategory nvarchar(200),
	[Version] int	--Comment #01
)

IF @CategoryFrom = 1 and @SortBy = 1   --- Category data from the CustomField5 of pStyleHeader and sort by the category
	BEGIN
		/*Insert info into temp table.*/
		INSERT INTO #tempLineFolderStyles(
			StyleID, 
			StyleNo, 
			[Description], 
			ImageID, 
			ImageHistoryID,
			SizeClass, 
			SizeRange, 
			MaterialName,
			MaterialNo,
			ItemCategory,
			[Version]	--Comment #01
		)
		SELECT 	b.StyleID, 
			b.StyleNo, 
			b.[Description], 
			c.ImageID, 
			c.ImageHistoryID,
			COALESCE(sc.Custom, b.SizeClass), 
			COALESCE(sr.SizeRangeCode, b.SizeRange), 
			d.MaterialName,
			d.MaterialNo,
			b.CustomField5 as ItemCategory,
			c.[Version]	--Comment #01
		FROM pStyleHeader b 
		INNER JOIN hImage c ON b.DesignSketchID = c.ImageID AND b.DesignSketchVersion = c.Version 
		LEFT OUTER JOIN pMaterial d ON b.MaterialID = d.MaterialID
		--LEFT OUTER JOIN pStyleCategory e ON	b.StyleCategory = e.StyleCategoryID
		LEFT JOIN pSizeClass sc ON sc.CustomID = b.SizeClassId
		LEFT JOIN pSizeRange sr ON sr.CustomId = b.SizeRangeId
		WHERE (@Season is null or b.CustomField2 = @Season)
		and (@Year is null or b.CustomField4 = @Year)
		and (@Category is null or  b.CustomField5 = @Category)
		ORDER BY --e.StyleCategory, b.StyleNo, b.[Description]
		          b.CustomField5, b.StyleNo, b.[Description]
        END

IF @CategoryFrom = 1 and @SortBy = 2 ---  Category from the CustomField5 of pStyleHeader and sort by StyleNo
	BEGIN
		/*Insert info into temp table.*/
		INSERT INTO #tempLineFolderStyles(
			StyleID, 
			StyleNo, 
			[Description], 
			ImageID, 
			ImageHistoryID,
			SizeClass, 
			SizeRange, 
			MaterialName,
			MaterialNo,
			ItemCategory,
			[Version]	--Comment #01
		)
		SELECT 	b.StyleID, 
			b.StyleNo, 
			b.[Description], 
			c.ImageID, 
			c.ImageHistoryID,
			COALESCE(sc.Custom, b.SizeClass), 
			COALESCE(sr.SizeRangeCode, b.SizeRange), 
			d.MaterialName,
			d.MaterialNo,
			b.CustomField5 as ItemCategory,
			c.[Version]	--Comment #01
		FROM pStyleHeader b 
		INNER JOIN hImage c ON b.DesignSketchID = c.ImageID AND b.DesignSketchVersion = c.Version 
		LEFT OUTER JOIN pMaterial d ON b.MaterialID = d.MaterialID
		--LEFT OUTER JOIN pStyleCategory e ON	b.StyleCategory = e.StyleCategoryID
		LEFT JOIN pSizeClass sc ON sc.CustomID = b.SizeClassId
		LEFT JOIN pSizeRange sr ON sr.CustomId = b.SizeRangeId
		WHERE (@Season is null or b.CustomField2 = @Season)
		and (@Year is null or b.CustomField4 = @Year)
		and (@Category is null or  b.CustomField5 = @Category)
		ORDER BY --e.StyleCategory, b.StyleNo, b.[Description]
		         b.StyleNo, b.[Description],  b.CustomField5
        END


IF @CategoryFrom = 2 and @SortBy = 1  --- Category data from pStyleCategory Table and Sort by category
	BEGIN
		/*Insert info into temp table.*/
		INSERT INTO #tempLineFolderStyles(
			StyleID, 
			StyleNo, 
			[Description], 
			ImageID, 
			ImageHistoryID,
			SizeClass, 
			SizeRange, 
			MaterialName,
			MaterialNo,
			ItemCategory,
			[Version]	--Comment #01
		)
		SELECT 	b.StyleID, 
			b.StyleNo, 
			b.[Description], 
			c.ImageID, 
			c.ImageHistoryID,
			COALESCE(sc.Custom, b.SizeClass), 
			COALESCE(sr.SizeRangeCode, b.SizeRange), 
			d.MaterialName,
			d.MaterialNo,
			e.StyleCategory as ItemCategory,
			c.[Version]	--Comment #01
		FROM pStyleHeader b 
		INNER JOIN hImage c ON b.DesignSketchID = c.ImageID AND b.DesignSketchVersion = c.Version 
		LEFT OUTER JOIN pMaterial d ON b.MaterialID = d.MaterialID
		LEFT OUTER JOIN pStyleCategory e ON	b.StyleCategory = e.StyleCategoryID
		LEFT JOIN pSizeClass sc ON sc.CustomID = b.SizeClassId
		LEFT JOIN pSizeRange sr ON sr.CustomId = b.SizeRangeId
		WHERE (@Season is null or b.CustomField2 = @Season)
		and (@Year is null or b.CustomField4 = @Year)
		and (@Category is null or CAST(b.StyleCategory AS nvarchar(50)) = @Category)
		ORDER BY e.StyleCategory, b.StyleNo, b.[Description]
		          --b.CustomField5, b.StyleNo, b.[Description]
        END


IF  @CategoryFrom = 2 and @SortBy = 2 --- --- Category data from pStyleCategory Table and Sort by StyleNo
	BEGIN
		/*Insert info into temp table.*/
		INSERT INTO #tempLineFolderStyles(
			StyleID, 
			StyleNo, 
			[Description], 
			ImageID, 
			ImageHistoryID,
			SizeClass, 
			SizeRange, 
			MaterialName,
			MaterialNo,
			ItemCategory,
			[Version]	--Comment #01
		)
		SELECT 	b.StyleID, 
			b.StyleNo, 
			b.[Description], 
			c.ImageID, 
			c.ImageHistoryID,
			COALESCE(sc.Custom, b.SizeClass), 
			COALESCE(sr.SizeRangeCode, b.SizeRange), 
			d.MaterialName,
			d.MaterialNo,
			e.StyleCategory as ItemCategory,
			c.[Version]	--Comment #01
		FROM pStyleHeader b 
		INNER JOIN hImage c ON b.DesignSketchID = c.ImageID AND b.DesignSketchVersion = c.Version 
		LEFT OUTER JOIN pMaterial d ON b.MaterialID = d.MaterialID
		LEFT OUTER JOIN pStyleCategory e ON	b.StyleCategory = e.StyleCategoryID
		LEFT JOIN pSizeClass sc ON sc.CustomID = b.SizeClassId
		LEFT JOIN pSizeRange sr ON sr.CustomId = b.SizeRangeId
		WHERE (@Season is null or b.CustomField2 = @Season)
		and (@Year is null or b.CustomField4 = @Year)
		and (@Category is null or CAST(b.StyleCategory AS nvarchar(50)) = @Category)
		ORDER BY b.StyleNo, b.[Description], e.StyleCategory
		         
        END





create table #StyleColorways
(
	RowNum int identity(1,1),
	StyleID nvarchar(50),
	MainColor nvarchar(100)
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

/*Select the information how you want for the report.*/
SELECT
	TableRow % 4 AS [Column],
	TableRow / 4 AS Row,
	@StrCategory AS Category,
	StyleID,
	StyleNo,
	[Description],
	dbo.fnx_GetStreamingImagePath(ImageID, [Version], 2000) AS FilePath,	--Comment #01
	SizeClass,
	SizeRange,
	MaterialName,
	MaterialNo,
	substring(Colorways, 1, len(Colorways)-1) as Colorways,
	ItemCategory
FROM #tempLineFolderStyles
ORDER BY TableRow

/*Drop the temp tables*/
drop table #StyleColorways
DROP TABLE #tempLineFolderStyles


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10110', GetUTCDate())
GO