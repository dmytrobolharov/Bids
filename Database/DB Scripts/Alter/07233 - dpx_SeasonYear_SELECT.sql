IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_SeasonYear_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_SeasonYear_SELECT]
GO


CREATE PROCEDURE [dbo].[dpx_SeasonYear_SELECT]
AS

SELECT '00000000-0000-0000-0000-000000000000' AS SeasonYearID, 'Current Season' AS SeasonYear, 'zzzzzzzzzzzzzzzz' AS [Year], '' AS Season
UNION
SELECT SeasonYearID, Season + ' ' + [Year] AS SeasonYear, [Year], Season FROM pSeasonYear 
WHERE (Season <> '' OR [Year] <>'')
AND (Season IN (SELECT Custom FROM pSeason WHERE Active = 1) OR Season NOT IN (SELECT Custom FROM dbo.pSeason)) 
AND ([Year] IN (SELECT Custom FROM pYear WHERE Active = 1) OR [Year] NOT IN (SELECT Custom FROM dbo.pYear))
AND Active = 1 
ORDER BY  [Year] DESC , Season

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07233', GetDate())
GO
