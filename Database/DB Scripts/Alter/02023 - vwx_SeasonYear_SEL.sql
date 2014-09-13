IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SeasonYear_SEL]') AND type in (N'V'))
	DROP VIEW [dbo].[vwx_SeasonYear_SEL]
GO

CREATE VIEW [dbo].[vwx_SeasonYear_SEL]
AS

SELECT TOP (100) PERCENT SeasonYearID, Season + ' ' + Year AS SeasonYear, Year, Season
FROM   pSeasonYear
ORDER BY Year DESC, Season

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02023'))
BEGIN
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02023', GetDate())

END	  
GO

