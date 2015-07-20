IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestSeasonYearColorBOM_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestSeasonYearColorBOM_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestSeasonYearColorBOM_SELECT]    Script Date: 06/9/2011 19:14:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[spx_SampleRequestSeasonYearColorBOM_SELECT] (
@SampleRequestTradeID UNIQUEIDENTIFIER 
)
AS

BEGIN
	SELECT  pSeasonYear.Season + ' ' + pSeasonYear.Year AS SeasonYearName, 
		pColorPalette.ColorCode + ' ' + pColorPalette.ColorName AS ColorName
	FROM  pSampleRequestBOMTrade LEFT OUTER JOIN
	  pStyleSeasonYear ON pSampleRequestBOMTrade.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID LEFT OUTER JOIN
	  pSeasonYear ON pStyleSeasonYear.SeasonYearID = pSeasonYear.SeasonYearID LEFT OUTER JOIN
	  pColorPalette ON pSampleRequestBOMTrade.ItemDim1Id = pColorPalette.ColorPaletteID OR 
	  pSampleRequestBOMTrade.ItemDim2Id = pColorPalette.ColorPaletteID OR
	  pSampleRequestBOMTrade.ItemDim3Id = pColorPalette.ColorPaletteID 
	WHERE pSampleRequestBOMTrade.SampleRequestTradeID = @SampleRequestTradeID
END

GO

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03588', GetDate())
GO