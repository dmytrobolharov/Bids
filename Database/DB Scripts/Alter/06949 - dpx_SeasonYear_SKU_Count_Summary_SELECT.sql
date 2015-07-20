IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_SeasonYear_SKU_Count_Summary_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_SeasonYear_SKU_Count_Summary_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_SeasonYear_SKU_Count_Summary_SELECT]
(
	@Season NVARCHAR(50)
	, @Year NVARCHAR(20)
	, @StyleCategory NVARCHAR(255)

)

AS
BEGIN
	SELECT ISNULL(sy.Season, '') + ' ' + ISNULL(sy.[Year], '') AS SeasonYear
		, sc.StyleCategory
		, COUNT (DISTINCT sh.StyleNo) AS StyleCount
		, COUNT (DISTINCT ISNULL(sco.ColorPaletteID, cp.ColorPaletteID)) AS ColorCount
		, (DENSE_RANK() OVER (ORDER BY sy.[Year], s.CustomSort, s.Custom)-1) % 4 AS Col
		, (DENSE_RANK() OVER (ORDER BY sy.[Year], s.CustomSort, s.Custom)-1) / 4 AS Row
	FROM pSeasonYear sy
		LEFT OUTER JOIN pSeason s ON sy.Season = s.Custom
		INNER JOIN pStyleSeasonYear ssy ON sy.SeasonYearID = ssy.SeasonYearID
		INNER JOIN pStyleHeader sh ON ssy.StyleID = sh.StyleID
		INNER JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryID
		INNER JOIN pStyleColorwaySeasonYear scsy ON ssy.StyleSeasonYearID = scsy.StyleSeasonYearID AND sh.StyleID = scsy.StyleID
		LEFT JOIN pStyleColorway sco ON scsy.StyleColorwayID = sco.StyleColorID
		LEFT JOIN pColorPalette cp ON scsy.ColorPaletteID = cp.ColorPaletteID
	WHERE
		(sy.Season = @Season OR @Season IS NULL)
		AND (sy.[Year] = @Year OR @Year IS NULL)
		AND (sc.StyleCategoryID = @StyleCategory OR @StyleCategory IS NULL)
	GROUP BY sy.Season, sy.Year, sc.StyleCategory, s.Custom, s.CustomSort
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06949', GetDate())
GO
