
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_StyleQuoteActivityCalendarAgent_INSERT')
   DROP PROCEDURE spx_StyleQuoteActivityCalendarAgent_INSERT
GO

CREATE PROCEDURE spx_StyleQuoteActivityCalendarAgent_INSERT
(@Teamid uniqueidentifier,
@TradePartnerId uniqueidentifier = NULL,
@CalendarId uniqueidentifier,
@StartDate datetime,
@EndDate datetime)
AS 

IF @TradePartnerId IS NOT NULL
	BEGIN

		INSERT INTO dbo.pStyleCalendarTemp
			(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
		SELECT @CalendarId AS CalendarId,  pStyleQuoteItem.StyleQuoteItemId, pStyleQuoteItem.StyleId, 
			pStyleQuoteItem.styleQuoteId AS CalendarLinkSubId, pStyleQuoteItemActivity.CDate, 
			'QuoteActivity' AS CalendarType, pStyleQuoteItemActivity.ActivityType, 
			'<b>A: </b>' + dbo.uTradePartner.TradePartnerCode + ' / <b>V: </b>' + dbo.uTradePartnerVendor.VendorCode + '<BR>' + dbo.pStyleHeader.StyleNo + ' (' +
			dbo.pStyleHeader.SizeClass + ') ' + dbo.pStyleHeader.Description AS CalendarDescription, pStyleQuoteItem.AgentView
		FROM pStyleQuoteItem WITH (NOLOCK) INNER JOIN
			dbo.pStyleHeader WITH (NOLOCK) ON pStyleQuoteItem.StyleID = dbo.pStyleHeader.StyleID INNER JOIN
			pStyleQuoteItemActivity WITH (NOLOCK) ON pStyleQuoteItem.StyleQuoteItemId = pStyleQuoteItemActivity.StyleQuoteItemId INNER JOIN
			dbo.uTradePartner WITH (NOLOCK) ON pStyleQuoteItem.TradePartnerId = dbo.uTradePartner.TradePartnerID INNER JOIN
			dbo.uTradePartnerVendor WITH (NOLOCK) ON pStyleQuoteItem.TradePartnerVendorId = dbo.uTradePartnerVendor.TradePartnerVendorID
		WHERE (pStyleQuoteItemActivity.TeamId = @TradePartnerId) 
		  AND (pStyleQuoteItemActivity.TradePartner = 1)
		  AND (pStyleQuoteItemActivity.CDate BETWEEN @StartDate AND @EndDate) 
		  AND pStyleQuoteItemActivity.ActivityType <> 'V'
		  AND pStyleHeader.StyleType IN (SELECT StyleTypeId FROM sAccessQuotationFolder WITH (NOLOCK) WHERE TeamID = @Teamid AND (AccessRoleId = 3 OR AccessView = 1) ) 
		ORDER BY dbo.pStyleHeader.StyleNo, pStyleQuoteItemActivity.ActivityType, pStyleQuoteItemActivity.Cdate ASC	

	END
ELSE
	BEGIN

		INSERT INTO dbo.pStyleCalendarTemp
			(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
		SELECT @CalendarId AS CalendarId,  pStyleQuoteItem.StyleQuoteItemId, pStyleQuoteItem.StyleId, 
			pStyleQuoteItem.styleQuoteId AS CalendarLinkSubId, pStyleQuoteItemActivity.CDate, 
			'QuoteActivity' AS CalendarType, pStyleQuoteItemActivity.ActivityType, 
			'<b>A: </b>' + dbo.uTradePartner.TradePartnerCode + ' / <b>V: </b>' + dbo.uTradePartnerVendor.VendorCode + '<BR>' + dbo.pStyleHeader.StyleNo + ' (' +
			dbo.pStyleHeader.SizeClass + ') ' + dbo.pStyleHeader.Description AS CalendarDescription, pStyleQuoteItem.AgentView
		FROM pStyleQuoteItem WITH (NOLOCK) INNER JOIN
			dbo.pStyleHeader WITH (NOLOCK) ON pStyleQuoteItem.StyleID = dbo.pStyleHeader.StyleID INNER JOIN
			pStyleQuoteItemActivity WITH (NOLOCK) ON pStyleQuoteItem.StyleQuoteItemId = pStyleQuoteItemActivity.StyleQuoteItemId INNER JOIN
			dbo.uTradePartner WITH (NOLOCK) ON pStyleQuoteItem.TradePartnerId = dbo.uTradePartner.TradePartnerID INNER JOIN
			dbo.uTradePartnerVendor WITH (NOLOCK) ON pStyleQuoteItem.TradePartnerVendorId = dbo.uTradePartnerVendor.TradePartnerVendorID
		WHERE (pStyleQuoteItemActivity.TradePartner = 1)
		  AND (pStyleQuoteItemActivity.CDate BETWEEN @StartDate AND @EndDate) 
		  AND pStyleQuoteItemActivity.ActivityType <> 'V'
		  AND pStyleHeader.StyleType IN (SELECT StyleTypeId FROM sAccessQuotationFolder WITH (NOLOCK) WHERE TeamID = @Teamid AND (AccessRoleId = 3 OR AccessView = 1) ) 
		ORDER BY dbo.pStyleHeader.StyleNo, pStyleQuoteItemActivity.ActivityType, pStyleQuoteItemActivity.Cdate ASC	

	END
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02069'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02069', GetDate())
	END
GO