IF  EXISTS (SELECT * FROM sys.procedures WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestSeasonYearColor_SELECT]'))
DROP PROCEDURE spx_SampleRequestSeasonYearColor_SELECT
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestSeasonYearColor_SELECT] (
@SampleRequestTradeID UNIQUEIDENTIFIER 
)
AS


SELECT  pSeasonYear.Season + ' ' + pSeasonYear.Year AS SeasonYearName, 
	pColorPalette.ColorCode + ' ' + pColorPalette.ColorName AS ColorName
FROM  pSampleRequestTrade INNER JOIN
  pStyleSeasonYear ON pSampleRequestTrade.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID INNER JOIN
  pStyleColorway ON pSampleRequestTrade.StyleColorID = pStyleColorway.StyleColorID INNER JOIN
  pColorPalette ON pStyleColorway.ColorPaletteID = pColorPalette.ColorPaletteID INNER JOIN
  pSeasonYear ON pStyleSeasonYear.SeasonYearID = pSeasonYear.SeasonYearID
WHERE pSampleRequestTrade.SampleRequestTradeID = @SampleRequestTradeID 


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01290', GetDate())
Go
