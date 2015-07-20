/****** Object:  View [dbo].[vwx_SeasonYear_SEL]    Script Date: 03/18/2013 12:32:52 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SeasonYear_SEL]'))
DROP VIEW [dbo].[vwx_SeasonYear_SEL]
GO

CREATE VIEW [dbo].[vwx_SeasonYear_SEL]
AS
SELECT TOP (100) PERCENT
	SeasonYearID
	, Season + ' ' + Year AS SeasonYear
	, Year
	, Season
	, SeasonOrder
	, Active
	, Sort
FROM
	dbo.pSeasonYear
WHERE
	(Active = 1)
	AND (
		Season IN (SELECT Custom FROM dbo.pSeason WHERE (Active = 1))
		OR Season NOT IN(SELECT Custom FROM dbo.pSeason)
		)
	AND (
		Year IN (SELECT Custom FROM dbo.pYear WHERE (Active = 1))
		OR Year NOT IN (SELECT Custom FROM dbo.pYear)
		)
ORDER BY
	Sort


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05324', GetDate())
GO
