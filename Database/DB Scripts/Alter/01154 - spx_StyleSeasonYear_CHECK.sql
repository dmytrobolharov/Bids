
ALTER PROCEDURE [dbo].[spx_StyleSeasonYear_CHECK](@StyleId uniqueidentifier)
AS 

/*
It will select the IntroSeasonYearID from pStyleHeader and create an 
entry on pStyleSeasonYear and pStyleColorwaySeasonYear for seasonality.
Daniel Pak 2/17/01
*/

IF (SELECT COUNT(*) FROM pStyleSeasonYear WHERE StyleID = @StyleID) = 0
BEGIN
	DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER
	SET @StyleSeasonYearID = newid()

	INSERT INTO pStyleSeasonYear (StyleSeasonYearID, StyleID, SeasonYearID, StyleSeason, StyleYear)
	SELECT @StyleSeasonYearID, @StyleID, SeasonYearID, Season, [Year] 
	FROM pSeasonYear INNER JOIN
	  pStyleHeader ON pSeasonYear.SeasonYearID = pStyleHeader.IntroSeasonYearID
	WHERE StyleID = @StyleID

	INSERT INTO pStyleColorwaySeasonYear(StyleSeasonYearID, StyleColorwayID, StyleID)
	SELECT @StyleSeasonYearID, StyleColorID, @StyleID FROM pStyleColorway 
	WHERE StyleID = @StyleID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01154', GetDate())
GO