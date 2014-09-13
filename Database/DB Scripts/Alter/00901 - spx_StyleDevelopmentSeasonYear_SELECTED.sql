
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_StyleDevelopmentSeasonYear_SELECTED')
   DROP PROCEDURE spx_StyleDevelopmentSeasonYear_SELECTED
GO


CREATE PROCEDURE [dbo].[spx_StyleDevelopmentSeasonYear_SELECTED]  (
@StyleDevelopmentID UNIQUEIDENTIFIER
)
AS 

BEGIN
		SELECT dbo.pSeasonYear.SeasonYearID, dbo.pSeasonYear.Season + ' ' + dbo.pSeasonYear.Year AS SeasonYear
		FROM  dbo.pStyleSeasonYear INNER JOIN
		  dbo.pSeasonYear ON dbo.pStyleSeasonYear.SeasonYearID = dbo.pSeasonYear.SeasonYearID INNER JOIN
		  dbo.pStyleDevelopmentItem ON dbo.pStyleSeasonYear.StyleID = dbo.pStyleDevelopmentItem.StyleID  
		WHERE pStyleDevelopmentItem.StyleDevelopmentID = @StyleDevelopmentID
		GROUP BY pSeasonYear.SeasonYearID, pSeasonYear.CurrentSeason, pSeasonYear.Year, pSeasonYear.Season
		ORDER BY pSeasonYear.CurrentSeason DESC, pSeasonYear.Year DESC, pSeasonYear.Season
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '901', GetDate())

GO
	
