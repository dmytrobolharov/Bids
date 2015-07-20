IF OBJECT_ID(N'[dbo].[rpx_Style_Header_Image_StyleSet_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[rpx_Style_Header_Image_StyleSet_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Style_Header_Image_StyleSet_SELECT]
(
	@StyleID nvarchar(255)
	,@SeasonYearID NVARCHAR(50) = '00000000-0000-0000-0000-000000000000'
	,@StyleSet INT
)
AS


--Comment #02
/*Declare variables.*/
DECLARE @Season nvarchar(50)
DECLARE @Year nvarchar(50)

--Comment #02
/*Get 'Season' and 'Year'.*/
SELECT @Season = Season
	,@Year = [Year]
FROM pSeasonYear
WHERE SeasonYearID = @SeasonYearID


SELECT dbo.fnx_GetStreamingImageSmallPath(hImage.ImageID, hImage.[Version]) AS FilePath,	--Comment #01
	sh.StyleNo,
	COALESCE(sc.Custom, sh.SizeClass) AS SizeClass, 
	COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange,
	sh.[Description],
	@Season AS Season,	--Comment #02
	@Year AS [Year]		--Comment #02
	,CASE
		WHEN @StyleSet = 1 AND (sh.Pc1 = '' OR sh.Pc1 IS NULL)			THEN '1st Set'
		WHEN @StyleSet = 1 AND (sh.Pc1 <> '' AND sh.Pc1 IS NOT NULL)	THEN sh.Pc1
		WHEN @StyleSet = 2 AND (sh.Pc2 = '' OR sh.Pc2 IS NULL)			THEN '2nd Set'
		WHEN @StyleSet = 2 AND (sh.Pc2 <> '' AND sh.Pc2 IS NOT NULL)	THEN sh.Pc2
		WHEN @StyleSet = 3 AND (sh.Pc3 = '' OR sh.Pc3 IS NULL)			THEN '3rd Set'
		WHEN @StyleSet = 3 AND (sh.Pc3 <> '' AND sh.Pc3 IS NOT NULL)	THEN sh.Pc3
		WHEN @StyleSet = 4 AND (sh.Pc4 = '' OR sh.Pc4 IS NULL)			THEN '4th Set'
		WHEN @StyleSet = 4 AND (sh.Pc4 <> '' AND sh.Pc4 IS NOT NULL)	THEN sh.Pc4
	END AS StyleSet
FROM pStyleHeader sh
LEFT OUTER JOIN hImage ON sh.DesignSketchID = hImage.ImageID AND
						  sh.DesignSketchVersion = hImage.Version
LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
WHERE sh.StyleID = @StyleID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09618', GetDate())
GO
