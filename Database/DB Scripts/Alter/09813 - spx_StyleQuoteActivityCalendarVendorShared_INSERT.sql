IF OBJECT_ID(N'[dbo].[spx_StyleQuoteActivityCalendarVendorShared_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleQuoteActivityCalendarVendorShared_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleQuoteActivityCalendarVendorShared_INSERT]
(@TradePartnerId nvarchar(50),
@TradePartnerVendorId nvarchar(50),
@CalendarId nvarchar(50),
@StartDate datetime,
@EndDate datetime)
AS 

BEGIN

	INSERT INTO dbo.pStyleCalendarTemp
		(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
	SELECT   @CalendarId AS CalendarId,  pStyleQuoteItem.StyleQuoteItemId, pStyleQuoteItem.StyleId, 
		pStyleQuoteItem.styleQuoteId AS CalendarLinkSubId, 
		pStyleQuoteItemActivity.CDate, 'QuoteActivity' AS CalendarType, pStyleQuoteItemActivity.ActivityType, 
		'<b>A: </b>' + dbo.uTradePartner.TradePartnerCode + ' / <b>V: </b>' + dbo.uTradePartnerVendor.VendorCode + '<BR>' + sh.StyleNo + ' (' +
		COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription, pStyleQuoteItem.AgentView
	FROM         pStyleQuoteItem WITH (NOLOCK) INNER JOIN
		dbo.pStyleHeader sh WITH (NOLOCK) ON pStyleQuoteItem.StyleID = sh.StyleID INNER JOIN
		pStyleQuoteItemActivity WITH (NOLOCK) ON 
		pStyleQuoteItem.StyleQuoteItemId = pStyleQuoteItemActivity.StyleQuoteItemId INNER JOIN
		dbo.uTradePartner WITH (NOLOCK) ON pStyleQuoteItem.TradePartnerId = dbo.uTradePartner.TradePartnerID INNER JOIN
		dbo.uTradePartnerVendor WITH (NOLOCK) ON pStyleQuoteItem.TradePartnerVendorId = dbo.uTradePartnerVendor.TradePartnerVendorID
		LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
	WHERE  (uTradePartnerVendor.TradePartnerVendorID = @TradePartnerVendorId)  
	AND (pStyleQuoteItemActivity.TradePartner = 0)
	AND     (pStyleQuoteItemActivity.CDate BETWEEN @StartDate AND @EndDate) 
	AND pStyleQuoteItemActivity.ActivityType NOT IN ('V','A') AND (pStyleQuoteItem.StyleQuoteItemShare = 1)
	ORDER BY  pStyleQuoteItemActivity.Cdate, sh.StyleNo, pStyleQuoteItemActivity.ActivityType ASC	


END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09813', GetDate())
GO
