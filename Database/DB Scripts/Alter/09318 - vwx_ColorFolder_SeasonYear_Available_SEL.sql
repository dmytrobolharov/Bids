IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_ColorFolder_SeasonYear_Available_SEL]'))
DROP VIEW [dbo].[vwx_ColorFolder_SeasonYear_Available_SEL]
GO

CREATE VIEW [dbo].[vwx_ColorFolder_SeasonYear_Available_SEL]
AS

SELECT sy.SeasonYearID
	, sy.Season
	, sy.Year
	, cf.ColorFolderID
FROM dbo.pColorFolder AS cf
CROSS JOIN dbo.pSeasonYear AS sy
LEFT OUTER JOIN dbo.pColorFolderSeasonYear AS cfsy ON cf.ColorFolderID = cfsy.ColorFolderID
	AND sy.SeasonYearID = cfsy.SeasonYearID
WHERE sy.Active = 1 
	AND (sy.Season IN (SELECT Custom FROM pSeason WHERE Active = 1) OR sy.Season NOT IN (SELECT Custom FROM pSeason))
	AND (sy.Year IN (SELECT Custom FROM pYear WHERE Active = 1) OR sy.Year NOT IN (SELECT Custom FROM pYear))
	AND cfsy.ColorFolderSeasonYearID IS NULL

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09318', GetDate())
GO
