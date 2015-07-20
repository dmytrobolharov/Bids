/****** Object:  StoredProcedure [dbo].[spx_StyleSeasonYear_OldNewSeasons_SELECT]    Script Date: 02/11/2013 12:25:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSeasonYear_OldNewSeasons_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSeasonYear_OldNewSeasons_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleSeasonYear_OldNewSeasons_SELECT]    Script Date: 02/11/2013 12:25:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleSeasonYear_OldNewSeasons_SELECT]
	@StyleID UNIQUEIDENTIFIER,
	@BeginSourcingSeason INT,
	@OldSeasonYears INT = 0 OUTPUT,
	@NewSeasonYears INT = 0 OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT @NewSeasonYears = COUNT(*) FROM (
		SELECT sy.Season, sy.Year, sy.SeasonOrder FROM pStyleSeasonYear ssy
		LEFT JOIN pSeasonYear sy ON sy.SeasonYearID = ssy.SeasonYearID
		WHERE StyleID=@StyleID AND SeasonOrder >= @BeginSourcingSeason
		UNION
		SELECT sy.Season, sy.Year, sy.SeasonOrder FROM pStyleHeader sh
		LEFT JOIN pSeasonYear sy ON sy.SeasonYearID = sh.IntroSeasonYearID
		WHERE StyleID=@StyleID AND SeasonOrder >= @BeginSourcingSeason
	) AS tbl
	
	SELECT @OldSeasonYears = COUNT(*) FROM (
		SELECT sy.Season, sy.Year, sy.SeasonOrder FROM pStyleSeasonYear ssy
		LEFT JOIN pSeasonYear sy ON sy.SeasonYearID = ssy.SeasonYearID
		WHERE StyleID=@StyleID AND SeasonOrder < @BeginSourcingSeason
		UNION
		SELECT sy.Season, sy.Year, sy.SeasonOrder FROM pStyleHeader sh
		LEFT JOIN pSeasonYear sy ON sy.SeasonYearID = sh.IntroSeasonYearID
		WHERE StyleID=@StyleID AND SeasonOrder < @BeginSourcingSeason
	) AS tbl
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05015', GetDate())
GO
