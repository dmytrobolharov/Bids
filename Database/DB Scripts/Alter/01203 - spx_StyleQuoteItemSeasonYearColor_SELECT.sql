

/****** Object:  StoredProcedure [dbo].[spx_StyleQuoteItemSeasonYearColor_SELECT]    Script Date: 02/28/2011 00:44:39 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[spx_StyleQuoteItemSeasonYearColor_SELECT]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[spx_StyleQuoteItemSeasonYearColor_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleQuoteItemSeasonYearColor_SELECT] (
@StyleQuoteItemID  UNIQUEIDENTIFIER 
)
AS

IF (SELECT StyleSourcingID FROM pStyleQuoteItem WHERE StyleQuoteItemID = @StyleQuoteItemID) IS NOT NULL
	BEGIN
		--Sourcing
		SELECT pColorPalette.ColorCode + ' ' + pColorPalette.ColorName AS ColorName, 
			pSeasonYear.Season + ' ' + pSeasonYear.Year AS SeasonYearName
		FROM  pStyleSourcing INNER JOIN
			  pStyleQuoteItem ON pStyleSourcing.StyleSourcingID = pStyleQuoteItem.StyleSourcingID INNER JOIN
			  pStyleSeasonYear ON pStyleSourcing.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID INNER JOIN
			  pSeasonYear ON pStyleSeasonYear.SeasonYearID = pSeasonYear.SeasonYearID LEFT OUTER JOIN
			  pColorPalette INNER JOIN
			  pStyleColorway ON pColorPalette.ColorPaletteID = pStyleColorway.ColorPaletteID ON 
			  pStyleQuoteItem.StyleColorID = pStyleColorway.StyleColorID
		WHERE pStyleQuoteItem.StyleQuoteItemID = @StyleQuoteItemID      
	END      
ELSE
	BEGIN
		--Seasonal Quote      
		SELECT pSeasonYear.Season + ' ' + pSeasonYear.Year AS SeasonYearName, '' AS ColorName
		FROM  pSeasonYear INNER JOIN
			  pStyleSeasonYear ON pSeasonYear.SeasonYearID = pStyleSeasonYear.SeasonYearID INNER JOIN
			  pStyleQuoteItem ON pStyleSeasonYear.StyleSeasonYearID = pStyleQuoteItem.StyleSeasonYearID      
		WHERE pStyleQuoteItem.StyleQuoteItemID = @StyleQuoteItemID         
	END      
      
      

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01203', GetDate())
GO
