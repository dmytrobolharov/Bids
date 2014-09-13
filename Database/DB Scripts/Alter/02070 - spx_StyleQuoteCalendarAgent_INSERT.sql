
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_StyleQuoteCalendarAgent_INSERT')
   DROP PROCEDURE spx_StyleQuoteCalendarAgent_INSERT
GO

CREATE PROCEDURE spx_StyleQuoteCalendarAgent_INSERT
(@TeamId uniqueidentifier,
@TradePartnerId uniqueidentifier = NULL,
@CalendarId uniqueidentifier,
@StartDate datetime,
@EndDate datetime)
AS 

IF @TradePartnerId IS NOT NULL
	BEGIN

		INSERT INTO dbo.pStyleCalendarTemp
			(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
		SELECT @CalendarId AS CalendarId, dbo.pStyleQuoteItem.StyleQuoteItemID, dbo.pStyleHeader.StyleID, dbo.pStyleHeader.DevelopmentID, 
			pStyleQuoteItem.StyleQuoteItemApprovedDate, 'Quote' AS CalendarType, pStyleQuoteItem.StyleQuoteItemStatusId,
			'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + dbo.pStyleHeader.StyleNo + ' (' + dbo.pStyleHeader.SizeClass + ') ' + dbo.pStyleHeader.Description AS CalendarDescription, 0
		FROM dbo.pStyleQuote WITH (NOLOCK) INNER JOIN
			dbo.pStyleQuoteItem WITH (NOLOCK) ON dbo.pStyleQuote.StyleQuoteID = dbo.pStyleQuoteItem.StyleQuoteID INNER JOIN
			dbo.uTradePartnerVendor WITH (NOLOCK) ON dbo.pStyleQuoteItem.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
			dbo.uTradePartner WITH (NOLOCK) ON dbo.pStyleQuote.TradePartnerID = dbo.uTradePartner.TradePartnerID INNER JOIN
			dbo.pStyleQuoteItemStatus WITH (NOLOCK) ON dbo.pStyleQuoteItem.StyleQuoteItemStatusId = dbo.pStyleQuoteItemStatus.CustomKey INNER JOIN
			dbo.pStyleHeader WITH (NOLOCK) ON dbo.pStyleQuoteItem.StyleID = dbo.pStyleHeader.StyleID
		WHERE (dbo.pStyleHeader.Active = 1) 
		  AND (pStyleQuoteItem.StyleQuoteItemApprovedDate BETWEEN @StartDate AND @EndDate) 
		  AND (pStyleQuoteItem.StyleQuoteItemStatusId <> 0) 
		  AND (pStyleQuoteItem.TradePartnerID = @TradePartnerId) 
	      AND pStyleHeader.StyleType IN (SELECT StyleTypeId FROM sAccessQuotationFolder WITH (NOLOCK) WHERE TeamID = @TeamId AND (AccessRoleId = 3 OR AccessView = 1) ) 


		INSERT INTO dbo.pStyleCalendarTemp
			(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
		SELECT @CalendarId AS CalendarId, dbo.pStyleQuoteItem.StyleQuoteItemID, dbo.pStyleHeader.StyleID, dbo.pStyleHeader.DevelopmentID, 
			pStyleQuoteItem.StyleQuoteItemDueDate, 'Quote' AS CalendarType, pStyleQuoteItem.StyleQuoteItemStatusId,
			'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + dbo.pStyleHeader.StyleNo + ' (' + dbo.pStyleHeader.SizeClass + ') ' + dbo.pStyleHeader.Description AS CalendarDescription, 0
		FROM dbo.pStyleQuote WITH (NOLOCK) INNER JOIN
			dbo.pStyleQuoteItem WITH (NOLOCK) ON dbo.pStyleQuote.StyleQuoteID = dbo.pStyleQuoteItem.StyleQuoteID INNER JOIN
			dbo.uTradePartnerVendor WITH (NOLOCK) ON dbo.pStyleQuoteItem.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
			dbo.uTradePartner WITH (NOLOCK) ON dbo.pStyleQuote.TradePartnerID = dbo.uTradePartner.TradePartnerID INNER JOIN
			dbo.pStyleQuoteItemStatus WITH (NOLOCK) ON dbo.pStyleQuoteItem.StyleQuoteItemStatusId = dbo.pStyleQuoteItemStatus.CustomKey INNER JOIN
			dbo.pStyleHeader WITH (NOLOCK) ON dbo.pStyleQuoteItem.StyleID = dbo.pStyleHeader.StyleID
		WHERE (dbo.pStyleHeader.Active = 1) 
		  AND (pStyleQuoteItem.StyleQuoteItemDueDate BETWEEN @StartDate AND @EndDate) 
		  AND  (pStyleQuoteItem.StyleQuoteItemStatusId = 0) 
		  AND (pStyleQuoteItem.TradePartnerID = @TradePartnerId) 
		  AND pStyleHeader.StyleType IN (SELECT StyleTypeId FROM sAccessQuotationFolder WITH (NOLOCK) WHERE TeamID = @TeamId AND (AccessRoleId = 3 OR AccessView = 1) ) 
	
	END
ELSE
	BEGIN

		INSERT INTO dbo.pStyleCalendarTemp
			(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
		SELECT @CalendarId AS CalendarId, dbo.pStyleQuoteItem.StyleQuoteItemID, dbo.pStyleHeader.StyleID, dbo.pStyleHeader.DevelopmentID, 
			pStyleQuoteItem.StyleQuoteItemApprovedDate, 'Quote' AS CalendarType, pStyleQuoteItem.StyleQuoteItemStatusId,
			'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + dbo.pStyleHeader.StyleNo + ' (' + dbo.pStyleHeader.SizeClass + ') ' + dbo.pStyleHeader.Description AS CalendarDescription, 0
		FROM dbo.pStyleQuote WITH (NOLOCK) INNER JOIN
			dbo.pStyleQuoteItem WITH (NOLOCK) ON dbo.pStyleQuote.StyleQuoteID = dbo.pStyleQuoteItem.StyleQuoteID INNER JOIN
			dbo.uTradePartnerVendor WITH (NOLOCK) ON dbo.pStyleQuoteItem.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
			dbo.uTradePartner WITH (NOLOCK) ON dbo.pStyleQuote.TradePartnerID = dbo.uTradePartner.TradePartnerID INNER JOIN
			dbo.pStyleQuoteItemStatus WITH (NOLOCK) ON dbo.pStyleQuoteItem.StyleQuoteItemStatusId = dbo.pStyleQuoteItemStatus.CustomKey INNER JOIN
			dbo.pStyleHeader WITH (NOLOCK) ON dbo.pStyleQuoteItem.StyleID = dbo.pStyleHeader.StyleID
		WHERE (dbo.pStyleHeader.Active = 1) 
		  AND (pStyleQuoteItem.StyleQuoteItemApprovedDate BETWEEN @StartDate AND @EndDate) 
		  AND (pStyleQuoteItem.StyleQuoteItemStatusId <> 0) 
	      AND pStyleHeader.StyleType IN (SELECT StyleTypeId FROM sAccessQuotationFolder WITH (NOLOCK) WHERE TeamID = @TeamId AND (AccessRoleId = 3 OR AccessView = 1) ) 


		INSERT INTO dbo.pStyleCalendarTemp
			(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
		SELECT @CalendarId AS CalendarId, dbo.pStyleQuoteItem.StyleQuoteItemID, dbo.pStyleHeader.StyleID, dbo.pStyleHeader.DevelopmentID, 
			pStyleQuoteItem.StyleQuoteItemDueDate, 'Quote' AS CalendarType, pStyleQuoteItem.StyleQuoteItemStatusId,
			'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + dbo.pStyleHeader.StyleNo + ' (' + dbo.pStyleHeader.SizeClass + ') ' + dbo.pStyleHeader.Description AS CalendarDescription, 0
		FROM dbo.pStyleQuote WITH (NOLOCK) INNER JOIN
			dbo.pStyleQuoteItem WITH (NOLOCK) ON dbo.pStyleQuote.StyleQuoteID = dbo.pStyleQuoteItem.StyleQuoteID INNER JOIN
			dbo.uTradePartnerVendor WITH (NOLOCK) ON dbo.pStyleQuoteItem.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
			dbo.uTradePartner WITH (NOLOCK) ON dbo.pStyleQuote.TradePartnerID = dbo.uTradePartner.TradePartnerID INNER JOIN
			dbo.pStyleQuoteItemStatus WITH (NOLOCK) ON dbo.pStyleQuoteItem.StyleQuoteItemStatusId = dbo.pStyleQuoteItemStatus.CustomKey INNER JOIN
			dbo.pStyleHeader WITH (NOLOCK) ON dbo.pStyleQuoteItem.StyleID = dbo.pStyleHeader.StyleID
		WHERE (dbo.pStyleHeader.Active = 1) 
		  AND (pStyleQuoteItem.StyleQuoteItemDueDate BETWEEN @StartDate AND @EndDate) 
		  AND  (pStyleQuoteItem.StyleQuoteItemStatusId = 0) 
		  AND pStyleHeader.StyleType IN (SELECT StyleTypeId FROM sAccessQuotationFolder WITH (NOLOCK) WHERE TeamID = @TeamId AND (AccessRoleId = 3 OR AccessView = 1) ) 

	END
GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02070'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02070', GetDate())
	END
GO