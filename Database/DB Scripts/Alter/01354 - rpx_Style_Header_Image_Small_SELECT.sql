IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_Header_Image_Small_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_Header_Image_Small_SELECT]
GO


CREATE PROCEDURE [dbo].[rpx_Style_Header_Image_Small_SELECT]
(
	@StyleID varchar(255)
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


SELECT dbo.fnx_GetStreamingImageSmallPath(hImage.ImageID, hImage.[Version]) AS FilePath,
	pStyleHeader.StyleNo,
	pStyleHeader.SizeClass, 
	pStyleHeader.SizeRange,
	pStyleHeader.[Description],
	@Season AS Season,
	@Year AS [Year]
FROM	pStyleHeader LEFT OUTER JOIN hImage ON
	pStyleHeader.DesignSketchID = hImage.ImageID AND
	pStyleHeader.DesignSketchVersion = hImage.Version
WHERE pStyleHeader.StyleID = @StyleID
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01354', GetDate())
GO