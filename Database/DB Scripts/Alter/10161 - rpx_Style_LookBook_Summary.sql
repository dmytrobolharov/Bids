IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_LookBook_Summary]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_LookBook_Summary]
GO

CREATE PROCEDURE [dbo].[rpx_Style_LookBook_Summary]
	@StyleID UNIQUEIDENTIFIER
	, @SeasonYearID UNIQUEIDENTIFIER
AS
BEGIN
	SELECT (ROW_NUMBER() OVER (PARTITION BY swh.StyleNo ORDER BY swh.StyleNo) - 1) / 3 AS Row
		, (ROW_NUMBER() OVER (PARTITION BY swh.StyleNo ORDER BY swh.StyleNo) - 1) % 3 AS Col
		, swh.StyleNo AS WStyleNo
		, swh.Description AS WDescription
		, dbo.fnx_GetStreamingImagePath(swh.DesignSketchID,swh.DesignSketchVersion, 2000) AS ImagePath
		, ISNULL(sy.Season, '') + ' ' + ISNULL(sy.Year, '') AS SeasonYear
		, sh.StyleNo
		, sh.Description
		, dbo.fnx_GetStreamingImagePath(sh.DesignSketchID,sh.DesignSketchVersion, 2000) AS StyleImagePath		
	FROM pStyleWardrobeRelation sw
		INNER JOIN pStyleHeader swh ON sw.StyleID = swh.StyleID
		INNER JOIN pStyleHeader sh ON sw.StyleRelationID = sh.StyleID
		INNER JOIN pSeasonYear sy ON sw.SeasonYearID = sy.SeasonYearID
	WHERE sw.StyleID = @StyleID
		AND sw.SeasonYearID = @SeasonYearID
	ORDER BY sw.Sort, sh.StyleNo
END	



GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10161', GetUTCDate())
GO