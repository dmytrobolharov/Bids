IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_Header_Image_StyleSet_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_Header_Image_StyleSet_SELECT]
GO


CREATE PROCEDURE [dbo].[rpx_Style_Header_Image_StyleSet_SELECT]
(
	@StyleID varchar(255)
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
	pStyleHeader.StyleNo,
	pStyleHeader.SizeClass, 
	pStyleHeader.SizeRange,
	pStyleHeader.[Description],
	@Season AS Season,	--Comment #02
	@Year AS [Year]		--Comment #02
	,CASE
		WHEN @StyleSet = 1 AND (pStyleHeader.Pc1 = '' OR pStyleHeader.Pc1 IS NULL)			THEN '1st Set'
		WHEN @StyleSet = 1 AND (pStyleHeader.Pc1 <> '' AND pStyleHeader.Pc1 IS NOT NULL)	THEN pStyleHeader.Pc1
		WHEN @StyleSet = 2 AND (pStyleHeader.Pc2 = '' OR pStyleHeader.Pc2 IS NULL)			THEN '2nd Set'
		WHEN @StyleSet = 2 AND (pStyleHeader.Pc2 <> '' AND pStyleHeader.Pc2 IS NOT NULL)	THEN pStyleHeader.Pc2
		WHEN @StyleSet = 3 AND (pStyleHeader.Pc3 = '' OR pStyleHeader.Pc3 IS NULL)			THEN '3rd Set'
		WHEN @StyleSet = 3 AND (pStyleHeader.Pc3 <> '' AND pStyleHeader.Pc3 IS NOT NULL)	THEN pStyleHeader.Pc3
		WHEN @StyleSet = 4 AND (pStyleHeader.Pc4 = '' OR pStyleHeader.Pc4 IS NULL)			THEN '4th Set'
		WHEN @StyleSet = 4 AND (pStyleHeader.Pc4 <> '' AND pStyleHeader.Pc4 IS NOT NULL)	THEN pStyleHeader.Pc4
	END AS StyleSet
FROM	pStyleHeader LEFT OUTER JOIN hImage ON
	pStyleHeader.DesignSketchID = hImage.ImageID AND
	pStyleHeader.DesignSketchVersion = hImage.Version
WHERE pStyleHeader.StyleID = @StyleID
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01510', GetDate())
GO