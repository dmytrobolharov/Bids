IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestSeasonYearColor_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestSeasonYearColor_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestSeasonYearColor_SELECT] (@SampleRequestTradeID UNIQUEIDENTIFIER)
AS
SELECT pSeasonYear.Season + ' ' + pSeasonYear.Year AS SeasonYearName, pColorPalette.ColorCode + ' ' + pColorPalette.ColorName AS ColorName, pSeasonYear.SeasonYearID
FROM pSampleRequestTrade
LEFT OUTER JOIN pStyleSeasonYear ON pSampleRequestTrade.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
LEFT OUTER JOIN pSeasonYear ON pStyleSeasonYear.SeasonYearID = pSeasonYear.SeasonYearID
LEFT OUTER JOIN pStyleColorway ON pSampleRequestTrade.StyleColorID = pStyleColorway.StyleColorID
INNER JOIN pColorPalette ON pStyleColorway.ColorPaletteID = pColorPalette.ColorPaletteID
WHERE pSampleRequestTrade.SampleRequestTradeID = @SampleRequestTradeID
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06149', GetDate())
GO
