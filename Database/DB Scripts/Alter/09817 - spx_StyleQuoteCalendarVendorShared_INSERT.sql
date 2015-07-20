IF OBJECT_ID(N'[dbo].[spx_StyleQuoteCalendarVendorShared_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleQuoteCalendarVendorShared_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleQuoteCalendarVendorShared_INSERT]
(@TradePartnerId nvarchar(50),
@TradePartnerVendorId nvarchar(50),
@CalendarId nvarchar(50),
@StartDate datetime,
@EndDate datetime)
AS 

BEGIN
	INSERT INTO pStyleCalendarTemp
		(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
	SELECT     @CalendarId AS CalendarId, pStyleQuoteItem.StyleQuoteItemID, sh.StyleID, sh.DevelopmentID, 
		pStyleQuoteItem.StyleQuoteItemApprovedDate, 'Quote' AS CalendarType, pStyleQuoteItem.StyleQuoteItemStatusId,
		'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + sh.StyleNo + 
		' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription, 0
	FROM   pStyleQuote WITH (NOLOCK) INNER JOIN
		pStyleQuoteItem WITH (NOLOCK) ON pStyleQuote.StyleQuoteID = pStyleQuoteItem.StyleQuoteID INNER JOIN
		uTradePartnerVendor WITH (NOLOCK) ON pStyleQuoteItem.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID INNER JOIN
		uTradePartner WITH (NOLOCK) ON pStyleQuote.TradePartnerID = uTradePartner.TradePartnerID INNER JOIN
		pStyleQuoteItemStatus WITH (NOLOCK) ON pStyleQuoteItem.StyleQuoteItemStatusId = pStyleQuoteItemStatus.CustomKey INNER JOIN
		pStyleHeader sh WITH (NOLOCK) ON pStyleQuoteItem.StyleID = sh.StyleID
		LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
	WHERE (sh.Active = 1) AND (pStyleQuoteItem.StyleQuoteItemApprovedDate BETWEEN @StartDate AND @EndDate) AND 
		(pStyleQuoteItem.StyleQuoteItemStatusId <> 0) AND (pStyleQuoteItem.TradePartnerID = @TradePartnerId) AND
		(pStyleQuoteItem.TradePartnerVendorID = @TradePartnerVendorID) AND (pStyleQuoteItem.StyleQuoteItemShare = 1)
	

END 

BEGIN
	INSERT INTO pStyleCalendarTemp
		(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
	SELECT     @CalendarId AS CalendarId, pStyleQuoteItem.StyleQuoteItemID, sh.StyleID, sh.DevelopmentID, 
		pStyleQuoteItem.StyleQuoteItemDueDate, 'Quote' AS CalendarType, pStyleQuoteItem.StyleQuoteItemStatusId,
		'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + sh.StyleNo + 
		' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription, 0
	FROM   pStyleQuote WITH (NOLOCK) INNER JOIN
		pStyleQuoteItem WITH (NOLOCK) ON pStyleQuote.StyleQuoteID = pStyleQuoteItem.StyleQuoteID INNER JOIN
		uTradePartnerVendor WITH (NOLOCK) ON pStyleQuoteItem.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID INNER JOIN
		uTradePartner WITH (NOLOCK) ON pStyleQuote.TradePartnerID = uTradePartner.TradePartnerID INNER JOIN
		pStyleQuoteItemStatus WITH (NOLOCK) ON pStyleQuoteItem.StyleQuoteItemStatusId = pStyleQuoteItemStatus.CustomKey INNER JOIN
		pStyleHeader sh WITH (NOLOCK) ON pStyleQuoteItem.StyleID = sh.StyleID
		LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
	WHERE (sh.Active = 1) AND (pStyleQuoteItem.StyleQuoteItemDueDate BETWEEN @StartDate AND @EndDate) AND  
		(pStyleQuoteItem.StyleQuoteItemStatusId = 0) AND (pStyleQuoteItem.TradePartnerID = @TradePartnerId) AND
		(pStyleQuoteItem.TradePartnerVendorID = @TradePartnerVendorID) AND (pStyleQuoteItem.StyleQuoteItemShare = 1)
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09817', GetDate())
GO
