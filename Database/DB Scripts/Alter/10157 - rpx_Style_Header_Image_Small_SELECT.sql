IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_Header_Image_Small_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_Header_Image_Small_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Style_Header_Image_Small_SELECT]
(
	@StyleID nvarchar(255)
	,@SeasonYearID NVARCHAR(50) = '00000000-0000-0000-0000-000000000000'
)
AS


/*Declare variables.*/
DECLARE @Season nvarchar(50)
DECLARE @Year nvarchar(50)

/*Get 'Season' and 'Year'.*/
SELECT @Season = Season
	,@Year = [Year]
FROM pSeasonYear
WHERE SeasonYearID = @SeasonYearID


SELECT dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version], 500) AS FilePath,
	sh.StyleNo,
	COALESCE(sc.Custom, sh.SizeClass) AS SizeClass, 
	COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange,
	sh.[Description],
	@Season AS Season,
	@Year AS [Year]
FROM pStyleHeader sh
LEFT OUTER JOIN hImage ON sh.DesignSketchID = hImage.ImageID AND
				          sh.DesignSketchVersion = hImage.Version
LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
WHERE sh.StyleID = @StyleID


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10157', GetUTCDate())
GO