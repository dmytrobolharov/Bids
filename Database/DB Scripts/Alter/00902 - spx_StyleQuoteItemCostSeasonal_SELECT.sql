IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_StyleQuoteItemCostSeasonal_SELECT')
   DROP PROCEDURE spx_StyleQuoteItemCostSeasonal_SELECT
GO


CREATE PROCEDURE [dbo].[spx_StyleQuoteItemCostSeasonal_SELECT]
(
@StyleQuoteId uniqueidentifier,
@StyleId uniqueidentifier,
@SeasonYearID uniqueidentifier
)
AS 

DECLARE @StyleSeasonYearID uniqueidentifier
SELECT @StyleSeasonYearID = StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID 


SELECT   pStyleQuoteItem.StyleQuoteItemID, pStyleQuoteItem.StyleQuoteItemNo, pStyleQuoteItem.StyleQuoteItemStatusId, 
		pStyleQuoteItem.StyleQuoteID, pStyleQuoteItem.StyleDevelopmentID, pStyleQuoteItem.StyleID, 
		pStyleQuoteItem.StyleQuoteTradePartnerID, pStyleQuoteItem.StyleCostingID, pStyleQuoteItem.TradePartnerID, 
		pStyleQuoteItem.TradePartnerVendorID, uTradePartnerVendor.VendorCode, uTradePartnerVendor.VendorName, 
		pStyleQuoteItemStatus.Custom AS QuoteStatus, pStyleCostingType.StyleCostingType, 
		pStyleQuoteItemStatus.CustomIcon AS QuoteStatusIcon
FROM    pStyleQuoteItem WITH (NOLOCK) INNER JOIN
		uTradePartnerVendor WITH (NOLOCK) ON pStyleQuoteItem.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID INNER JOIN
		pStyleQuoteItemStatus WITH (NOLOCK) ON pStyleQuoteItem.StyleQuoteItemStatusId = pStyleQuoteItemStatus.CustomKey INNER JOIN
		pStyleCostingType WITH (NOLOCK) ON pStyleQuoteItem.StyleCostingType = pStyleCostingType.StyleCostingTypeID
WHERE     (pStyleQuoteItem.StyleQuoteID = @StyleQuoteId) AND (pStyleQuoteItem.StyleID = @StyleId) 
		AND pStylequoteItem.StyleSeasonYearID  = @StyleSeasonYearID 
ORDER BY uTradePartnerVendor.VendorCode, uTradePartnerVendor.VendorName
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '902', GetDate())

GO
