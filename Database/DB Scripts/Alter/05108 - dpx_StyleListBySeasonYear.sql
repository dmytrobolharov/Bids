IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_StyleListBySeasonYear]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_StyleListBySeasonYear]
GO

CREATE PROCEDURE [dbo].[dpx_StyleListBySeasonYear]
	@SeasonYearID UNIQUEIDENTIFIER
AS
BEGIN
	IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
		SELECT TOP 1 @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1

	SELECT sh.StyleID, ISNULL(sh.StyleNo, '') + ISNULL(' (' + sh.Description + ')', '') AS txtLabel
	FROM pStyleHeader sh
		LEFT OUTER JOIN pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID
		LEFT OUTER JOIN pSeasonYear sy ON sy.SeasonYearID = ssy.SeasonYearID
	WHERE ssy.SeasonYearID = @SeasonYearID
	ORDER BY sh.StyleNo
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05108', GetDate())
GO
