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
		dbo.fnx_GetStreamingImagePath(DesignSketchID, DesignSketchVersion) AS FilePath
		, dbo.fnx_GetStreamingImagePath(DesignSketchBackID, DesignSketchBackVersion) AS FilePathBack
		, pStyleHeader.StyleNo
		, pStyleHeader.SizeClass
		, pStyleHeader.SizeRange
		, pStyleHeader.[Description]
		, @Season AS Season
		, @Year AS [Year]
		, dbo.fnx_GetQRImagePath(@SRSID) AS QRPath
	FROM pStyleHeader
	WHERE pStyleHeader.StyleID = @StyleID
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08584', GetDate())
GO
