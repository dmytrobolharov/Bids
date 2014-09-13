IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSeasonYear_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSeasonYear_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleSeasonYear_SELECT](@StyleId uniqueidentifier)
AS 

SELECT pSeasonYear.Season + ' ' + pSeasonYear.Year AS SeasonYear
FROM  pStyleSeasonYear INNER JOIN
  pSeasonYear ON pStyleSeasonYear.SeasonYearID = pSeasonYear.SeasonYearID
WHERE StyleID = @StyleID
ORDER BY pStyleSeasonYear.Sort --pSeasonYear.CurrentSeason DESC, pSeasonYear.Year DESC  , pSeasonYear.Season

--ORDER BY pSeasonYear.Sort DESC

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04335', GetDate())
GO
