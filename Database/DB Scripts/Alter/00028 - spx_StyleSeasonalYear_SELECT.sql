
IF EXISTS (select * from sysobjects where id = object_id('spx_StyleSeasonalYear_SELECT') and sysstat & 0xf = 4)
	drop procedure spx_StyleSeasonalYear_SELECT
GO

CREATE PROCEDURE spx_StyleSeasonalYear_SELECT(@StyleId uniqueidentifier)  
AS   
  
SELECT pSeasonYear.Season + ' ' + pSeasonYear.Year AS SeasonYear,   pStyleSeasonYear.StyleSeasonYearID AS StyleSeasonYearID
FROM  pStyleSeasonYear INNER JOIN  
  pSeasonYear ON pStyleSeasonYear.SeasonYearID = pSeasonYear.SeasonYearID  
WHERE StyleID = @StyleID  
ORDER BY pSeasonYear.CurrentSeason DESC, pSeasonYear.Year DESC  , pSeasonYear.Season  
  
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '028', GetDate())

GO   
  
  
  
  
  
  
  
