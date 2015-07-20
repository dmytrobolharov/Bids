IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_FlashEdit_StyleQuoteDefault_SELECT]') AND type = N'V' )
	DROP VIEW [dbo].[vwx_FlashEdit_StyleQuoteDefault_SELECT]
GO


CREATE VIEW dbo.vwx_FlashEdit_StyleQuoteDefault_SELECT
AS


	SELECT
		a.StyleQuoteItemStatusId,
		b.StyleNo, b.Description, b.MaterialName, h.ColorName,
		a.StyleQuoteItemID, a.StyleQuoteItemNo, a.StyleQuoteItemCustomField8,
		a.StyleQuoteItemCustomField9, a.StyleQuoteItemCustomField10, a.StyleQuoteItemCustomField15,
		a.StyleQuoteItemCustomField23,
		f.Status AS ColorwayStatus, i.Season, i.Year, l.VendorName AS Vendor , k.TradePartnerName AS Agent,
		c.Custom AS QuoteStatus
	FROM dbo.pStyleQuoteItem a WITH(NOLOCK)
		INNER JOIN dbo.pStyleHeader b WITH(NOLOCK) ON a.StyleID =  b.StyleID 
		INNER JOIN pStyleQuoteItemStatus c WITH(NOLOCK) ON c.CustomKey  = a.StyleQuoteItemStatusId
		INNER JOIN dbo.pStyleSourcing d WITH(NOLOCK) ON D.StyleSourcingID = a.StyleSourcingID 
		INNER JOIN dbo.pStyleSeasonYear j WITH(NOLOCK) ON j.StyleSeasonYearID =  d.StyleSeasonYearID
		INNER JOIN dbo.pStyleColorwaySeasonYear e WITH(NOLOCK) ON e.StyleSeasonYearID = j.StyleSeasonYearID
			AND e.StyleColorwayID = a.StyleColorID 
		INNER JOIN dbo.pStyleColorwayStatus f WITH(NOLOCK) ON f.StatusID = e.StyleColorStatus
		INNER JOIN dbo.pStyleColorway g WITH(NOLOCK) ON g.StyleColorID = e.StyleColorwayID
		INNER JOIN  dbo.pColorPalette h WITH(NOLOCK)  ON h.ColorPaletteID = g.ColorPaletteID
		INNER JOIN dbo.pSeasonYear i WITH(NOLOCK)  ON i.SeasonYearID = j.SeasonYearID
		INNER JOIN dbo.uTradePartnerVendor l WITH(NOLOCK) ON l.TradePartnerVendorID =  a.TradePartnerVendorID 
		INNER JOIN dbo.uTradePartner  k WITH(NOLOCK) ON k.TradePartnerID =  l.TradePartnerID 
		
		
GO		

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01143', GetDate())
GO