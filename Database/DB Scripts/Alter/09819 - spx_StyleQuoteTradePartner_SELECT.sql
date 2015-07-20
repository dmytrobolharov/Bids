IF OBJECT_ID(N'[dbo].[spx_StyleQuoteTradePartner_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleQuoteTradePartner_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleQuoteTradePartner_SELECT](
 @StyleDevelopmentID uniqueidentifier,
 @TradePartnerID uniqueidentifier)
AS SELECT sh.StyleNo, sh.Description, COALESCE(sc.Custom, sh.SizeClass) AS SizeClass, 
          COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange, sh.DesignSketchID, sh.DesignSketchVersion, 
		  dbo.pStyleQuoteItem.StyleQuoteItemID, dbo.pStyleQuoteItem.StyleQuoteID, dbo.pStyleQuoteItem.StyleID, 
		  dbo.pStyleQuoteItem.StyleQuoteTradePartnerID, dbo.pStyleQuoteItem.StyleCostingID,
          dbo.pStyleQuoteItem.StyleCostingType, dbo.pStyleQuoteItem.TradePartnerID, dbo.pStyleQuoteItem.StyleDevelopmentID
FROM dbo.pStyleQuoteItem WITH (NOLOCK) 
INNER JOIN dbo.pStyleHeader sh WITH (NOLOCK) ON dbo.pStyleQuoteItem.StyleID = sh.StyleID
LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomID = sh.SizeRangeId
WHERE (dbo.pStyleQuoteItem.StyleDevelopmentID = @StyleDevelopmentID) AND (dbo.pStyleQuoteItem.TradePartnerID = @TradePartnerID)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09819', GetDate())
GO
