IF OBJECT_ID(N'[dbo].[dpx_StyleQuoteItem_ApprovedDate_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[dpx_StyleQuoteItem_ApprovedDate_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_StyleQuoteItem_ApprovedDate_SELECT]
(
	@DateTime datetime
)
AS

--Variables.
DECLARE @ShortStringDate nvarchar(10)
DECLARE @StringDateBegin nvarchar(25)
DECLARE @StringDateEnd nvarchar(25)

--Set date variable to a short date format.
SET @ShortStringDate = SUBSTRING(CONVERT(nvarchar(25), @DateTime, 120), 1, 10)

--Set two variables to the beginning and end of the date specified.
SET @StringDateBegin = @ShortStringDate + ' 00:00:00.000'
SET @StringDateEnd = @ShortStringDate + ' 23:59:59.998'

--Get approved quotes for the specified date.
SELECT
	uTradePartner.TradePartnerName,
	uTradePartnerVendor.VendorName,
	sh.StyleNo,
	COALESCE(sc.Custom, sh.SizeClass) AS SizeClass,
	COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange,
	pStyleQuoteItemStatus.Custom AS Status,
	pStyleQuoteItem.StyleQuoteItemApprovedDate,
	pStyleQuoteItem.StyleQuoteItemApprovedBy
FROM	pStyleQuoteItem
	LEFT OUTER JOIN pStyleQuoteItemStatus ON 	(pStyleQuoteItem.StyleQuoteItemStatusID = pStyleQuoteItemStatus.CustomKey)
	INNER JOIN pStyleHeader sh ON (pStyleQuoteItem.StyleID = sh.StyleID)
	LEFT OUTER JOIN uTradePartner ON	(pStyleQuoteItem.TradePartnerID = uTradePartner.TradePartnerID)
	LEFT OUTER JOIN uTradePartnerVendor ON	(pStyleQuoteItem.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID)
	LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
	LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
WHERE	(pStyleQuoteItem.StyleQuoteItemStatusID = 3)
	AND	(pStyleQuoteItem.StyleQuoteItemApprovedDate >= @StringDateBegin
		AND	pStyleQuoteItem.StyleQuoteItemApprovedDate <= @StringDateEnd)
ORDER BY	uTradePartner.TradePartnerName,
	uTradePartnerVendor.VendorName,
	sh.StyleNo,
	COALESCE(sc.Custom, sh.SizeClass),
	COALESCE(sr.SizeRangeCode, sh.SizeRange)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09573', GetDate())
GO
