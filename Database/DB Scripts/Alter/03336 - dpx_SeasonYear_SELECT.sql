IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_SeasonYear_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_SeasonYear_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[dpx_SeasonYear_SELECT]
AS

SELECT '00000000-0000-0000-0000-000000000000' AS SeasonYearID, 'Current Season' AS SeasonYear, '2100' AS [Year], '' AS Season
UNION
SELECT SeasonYearID, Season + ' ' + [Year] AS SeasonYear, [Year], Season FROM pSeasonYear 
WHERE (Season <> '' OR [Year] <>'')
AND (Season IN (SELECT Custom FROM pSeason)) AND ([Year] IN (SELECT Custom FROM pYear))
AND Active = 1
ORDER BY [Year] DESC , Season

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03336'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03336', GetDate())
END
GO