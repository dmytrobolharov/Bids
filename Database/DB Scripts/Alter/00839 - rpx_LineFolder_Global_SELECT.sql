/*
Comments:

#01 - Ryan Cabanas - September 23, 2009
	Replace the old image string with the new image string using function.
Deleted old code.  Needed to add the 'Version' field to the temp table for
the image stream and get the 'Version' from 'hImage' to put in the temp table.
*/


ALTER     procedure [dbo].[rpx_LineFolder_Global_SELECT]
	@Season varchar(50) = null,
	@Year varchar(50) = null,
	@Category varchar(50) = null
as

/*Test values*/
-- DECLARE	@Season varchar(50)
-- DECLARE	@Year varchar(50)
-- DECLARE	@Category varchar(50)
-- SET @Season = NULL
-- SET @Year = NULL
-- SET @Category = NULL


/*Variables*/
DECLARE @StrCategory varchar(255)


/*Get the string version of the StyleCategory for the report header*/
SELECT @StrCategory = StyleCategory
FROM pStyleCategory
WHERE CAST(StyleCategoryID AS varchar(50)) = @Category

/*Create temp tables*/
CREATE TABLE #tempLineFolderStyles
(
	TableRow int identity(0,1),
	StyleID varchar(50),
	StyleNo varchar(50),
	[Description] nvarchar(255),
	ImageID varchar(50),
	ImageHistoryID varchar(50),
	SizeClass nvarchar(50),
	SizeRange nvarchar(50),
	MaterialName nvarchar(100),
	MaterialNo nvarchar(50),
	Colorways varchar(2000),
	[Version] int	--Comment #01
)

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
	[Version])	--Comment #01
SELECT 	b.StyleID, 
	b.StyleNo, 
	b.[Description], 
	c.ImageID, 
	c.ImageHistoryID,
	b.SizeClass, 
	b.SizeRange, 
	d.MaterialName,
	d.MaterialNo,
	c.[Version]	--Comment #01
FROM pStyleHeader b 
INNER JOIN hImage c ON b.DesignSketchID = c.ImageID AND b.DesignSketchVersion = c.Version 
LEFT OUTER JOIN pMaterial d ON b.MaterialID = d.MaterialID
LEFT OUTER JOIN pStyleCategory e ON	b.StyleCategory = e.StyleCategoryID
WHERE (@Season is null or b.CustomField2 = @Season)
and (@Year is null or b.CustomField4 = @Year)
and (@Category is null or CAST(b.StyleCategory AS varchar(50)) = @Category)
ORDER BY e.StyleCategory, b.StyleNo, b.[Description]

create table #StyleColorways
(
	RowNum int identity(1,1),
	StyleID varchar(50),
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
	TableRow / 4 AS Row,
	TableRow % 4 AS [Column],
	@StrCategory AS Category,
	StyleID,
	StyleNo,
	[Description],
	dbo.fnx_GetStreamingImagePath(ImageID, [Version]) AS FilePath,	--Comment #01
	SizeClass,
	SizeRange,
	MaterialName,
	MaterialNo,
	substring(Colorways, 1, len(Colorways)-1) as Colorways
FROM #tempLineFolderStyles

/*Drop the temp tables*/
drop table #StyleColorways
DROP TABLE #tempLineFolderStyles
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '839', GetDate())
GO