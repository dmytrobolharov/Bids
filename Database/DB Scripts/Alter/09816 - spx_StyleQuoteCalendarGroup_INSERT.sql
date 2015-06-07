IF OBJECT_ID(N'[dbo].[spx_StyleQuoteCalendarGroup_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleQuoteCalendarGroup_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleQuoteCalendarGroup_INSERT]
(@CalendarId nvarchar(50),
@StartDate datetime,
@EndDate datetime)
AS 


BEGIN
	INSERT INTO dbo.pStyleCalendarTemp
		(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription)
	SELECT     @CalendarId AS CalendarId, dbo.pStyleQuoteItem.StyleQuoteItemID, sh.StyleID, sh.DevelopmentID, 
		pStyleQuoteItem.StyleQuoteItemApprovedDate, 'Quote' AS CalendarType, pStyleQuoteItem.StyleQuoteItemStatusId,
		'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + sh.StyleNo + 
		' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription
	FROM   dbo.pStyleQuote INNER JOIN
		dbo.pStyleQuoteItem ON dbo.pStyleQuote.StyleQuoteID = dbo.pStyleQuoteItem.StyleQuoteID INNER JOIN
		dbo.uTradePartnerVendor ON dbo.pStyleQuoteItem.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
		dbo.uTradePartner ON dbo.pStyleQuote.TradePartnerID = dbo.uTradePartner.TradePartnerID INNER JOIN
		dbo.pStyleQuoteItemStatus ON dbo.pStyleQuoteItem.StyleQuoteItemStatusId = dbo.pStyleQuoteItemStatus.CustomKey INNER JOIN
		dbo.pStyleHeader sh ON dbo.pStyleQuoteItem.StyleID = sh.StyleID
		LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
	WHERE (sh.Active = 1) AND (pStyleQuoteItem.StyleQuoteItemApprovedDate BETWEEN @StartDate AND @EndDate) AND  (pStyleQuoteItem.StyleQuoteItemStatusId <> 0)
	
END 


BEGIN
	INSERT INTO dbo.pStyleCalendarTemp
		(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription)
	SELECT     @CalendarId AS CalendarId, dbo.pStyleQuoteItem.StyleQuoteItemID, sh.StyleID, sh.DevelopmentID, 
		pStyleQuote.StyleQuoteDueDate, 'Quote' AS CalendarType, pStyleQuoteItem.StyleQuoteItemStatusId,
		'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + sh.StyleNo + 
		' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription
	FROM   dbo.pStyleQuote INNER JOIN
		dbo.pStyleQuoteItem ON dbo.pStyleQuote.StyleQuoteID = dbo.pStyleQuoteItem.StyleQuoteID INNER JOIN
		dbo.uTradePartnerVendor ON dbo.pStyleQuoteItem.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
		dbo.uTradePartner ON dbo.pStyleQuote.TradePartnerID = dbo.uTradePartner.TradePartnerID INNER JOIN
		dbo.pStyleQuoteItemStatus ON dbo.pStyleQuoteItem.StyleQuoteItemStatusId = dbo.pStyleQuoteItemStatus.CustomKey INNER JOIN
		dbo.pStyleHeader sh ON dbo.pStyleQuoteItem.StyleID = sh.StyleID
		LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
	WHERE (sh.Active = 1) AND (dbo.pStyleQuote.StyleQuoteDueDate BETWEEN @StartDate AND @EndDate) AND  (pStyleQuoteItem.StyleQuoteItemStatusId = 0)
	
END 


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09816', GetDate())
GO
