IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSeasonYear_SELECTED]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSeasonYear_SELECTED]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleSeasonYear_SELECTED]  (
@StyleID UNIQUEIDENTIFIER
)
AS 

/*
SELECT  SeasonYearID , [Season] + ' ' + [Year] AS SeasonYear FROM  pSeasonYear 
WHERE SeasonYearID IN (SELECT SeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleID)
ORDER BY Sort
*/

SELECT b.SeasonYearID , b.Season + ' ' + b.Year AS SeasonYear 
FROM pStyleSeasonYear a
INNER JOIN pSeasonYear b ON a.SeasonYearID = b.SeasonYearID  
WHERE StyleID = @StyleID 
ORDER BY a.Sort --b.CurrentSeason DESC, b.Year DESC, b.Season

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04336', GetDate())
GO
