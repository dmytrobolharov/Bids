IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_Header_Image_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_Header_Image_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Style_Header_Image_SELECT]
(
	@StyleID UNIQUEIDENTIFIER
	, @SeasonYearID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000'
	, @SRSID UNIQUEIDENTIFIER = NULL
)
AS
BEGIN
	DECLARE @Season NVARCHAR(50)
	DECLARE @Year NVARCHAR(50)

	SELECT @Season = Season
		, @Year = [Year]
	FROM pSeasonYear
	WHERE SeasonYearID = @SeasonYearID

	SELECT
		dbo.fnx_GetStreamingImagePath(DesignSketchID, DesignSketchVersion, 2000) AS FilePath
		, dbo.fnx_GetStreamingImagePath(DesignSketchBackID, DesignSketchBackVersion, 2000) AS FilePathBack
		, sh.StyleNo
		, COALESCE(sc.Custom, sh.SizeClass) AS SizeClass
		, COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange
		, sh.[Description]
		, @Season AS Season
		, @Year AS [Year]
		, dbo.fnx_GetQRImagePath(@SRSID) AS QRPath
	FROM pStyleHeader sh
	LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
	LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
	WHERE sh.StyleID = @StyleID
END


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10156', GetUTCDate())
GO