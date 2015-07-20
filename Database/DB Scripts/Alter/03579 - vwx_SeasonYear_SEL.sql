IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SeasonYear_SEL]'))
DROP VIEW [dbo].[vwx_SeasonYear_SEL]
GO


CREATE  VIEW [dbo].[vwx_SeasonYear_SEL]
AS

SELECT TOP (100) PERCENT SeasonYearID, Season + ' ' + Year AS SeasonYear, Year, Season,Active
FROM   pSeasonYear
ORDER BY Year DESC, Season


GO

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03579', GetDate())
GO

