
CREATE VIEW [dbo].[vwx_SeasonYear_SEL]
AS
SELECT TOP (100) PERCENT SeasonYearID, Season + ' ' + Year AS SeasonYear
FROM   pSeasonYear
ORDER BY Year DESC, Season

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01155', GetDate())
GO
