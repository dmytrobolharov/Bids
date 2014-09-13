/****** Object:  StoredProcedure [dbo].[rpx_Style_Header_Image_SELECT]    Script Date: 09/28/2012 17:02:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_Header_Image_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_Header_Image_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[rpx_Style_Header_Image_SELECT]    Script Date: 09/28/2012 17:02:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Comments:

#01 - Ryan Cabanas - September 23, 2009
	Replace the old image string with the new image string using function.
Deleted old code.

#02 - Ryan Cabanas - November 3, 2009
	Pass the 'Season' and 'Year' information to the report.
*/


CREATE    PROCEDURE [dbo].[rpx_Style_Header_Image_SELECT]
(
	@StyleID varchar(255)
	,@SeasonYearID NVARCHAR(50) = '00000000-0000-0000-0000-000000000000'
	,@SRSID varchar(255) = NULL
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


SELECT dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version]) AS FilePath,	--Comment #01
	pStyleHeader.StyleNo,
	pStyleHeader.SizeClass, 
	pStyleHeader.SizeRange,
	pStyleHeader.[Description],
	@Season AS Season,	--Comment #02
	@Year AS [Year],		--Comment #02
	dbo.fnx_GetQRImagePath(@SRSID) AS QRPath
FROM	pStyleHeader LEFT OUTER JOIN hImage ON
	pStyleHeader.DesignSketchID = hImage.ImageID AND
	pStyleHeader.DesignSketchVersion = hImage.Version
WHERE pStyleHeader.StyleID = @StyleID
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04026', GetDate())
GO