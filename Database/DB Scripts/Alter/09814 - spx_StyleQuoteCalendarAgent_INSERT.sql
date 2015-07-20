IF OBJECT_ID(N'[dbo].[spx_StyleQuoteCalendarAgent_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleQuoteCalendarAgent_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleQuoteCalendarAgent_INSERT]
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
		SELECT @CalendarId AS CalendarId, dbo.pStyleQuoteItem.StyleQuoteItemID, sh.StyleID, sh.DevelopmentID, 
			pStyleQuoteItem.StyleQuoteItemApprovedDate, 'Quote' AS CalendarType, pStyleQuoteItem.StyleQuoteItemStatusId,
			'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + sh.StyleNo + 
			' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription, 0
		FROM dbo.pStyleQuote WITH (NOLOCK) INNER JOIN
			dbo.pStyleQuoteItem WITH (NOLOCK) ON dbo.pStyleQuote.StyleQuoteID = dbo.pStyleQuoteItem.StyleQuoteID INNER JOIN
			dbo.uTradePartnerVendor WITH (NOLOCK) ON dbo.pStyleQuoteItem.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
			dbo.uTradePartner WITH (NOLOCK) ON dbo.pStyleQuote.TradePartnerID = dbo.uTradePartner.TradePartnerID INNER JOIN
			dbo.pStyleQuoteItemStatus WITH (NOLOCK) ON dbo.pStyleQuoteItem.StyleQuoteItemStatusId = dbo.pStyleQuoteItemStatus.CustomKey INNER JOIN
			dbo.pStyleHeader sh WITH (NOLOCK) ON dbo.pStyleQuoteItem.StyleID = sh.StyleID INNER JOIN
			fnx_Permissions_GetIntProductTypePermissions(@TeamID, 4) access ON access.ProductTypeId = sh.StyleType
			LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
		WHERE (sh.Active = 1) 
		  AND (pStyleQuoteItem.StyleQuoteItemApprovedDate BETWEEN @StartDate AND @EndDate) 
		  AND (pStyleQuoteItem.StyleQuoteItemStatusId <> 0) 
		  AND (pStyleQuoteItem.TradePartnerID = @TradePartnerId) 
	      AND (PermissionRoleId = 3 OR PermissionView = 1)


		INSERT INTO dbo.pStyleCalendarTemp
			(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
		SELECT @CalendarId AS CalendarId, dbo.pStyleQuoteItem.StyleQuoteItemID, sh.StyleID, sh.DevelopmentID, 
			pStyleQuoteItem.StyleQuoteItemDueDate, 'Quote' AS CalendarType, pStyleQuoteItem.StyleQuoteItemStatusId,
			'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + sh.StyleNo + 
			' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription, 0
		FROM dbo.pStyleQuote WITH (NOLOCK) INNER JOIN
			dbo.pStyleQuoteItem WITH (NOLOCK) ON dbo.pStyleQuote.StyleQuoteID = dbo.pStyleQuoteItem.StyleQuoteID INNER JOIN
			dbo.uTradePartnerVendor WITH (NOLOCK) ON dbo.pStyleQuoteItem.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
			dbo.uTradePartner WITH (NOLOCK) ON dbo.pStyleQuote.TradePartnerID = dbo.uTradePartner.TradePartnerID INNER JOIN
			dbo.pStyleQuoteItemStatus WITH (NOLOCK) ON dbo.pStyleQuoteItem.StyleQuoteItemStatusId = dbo.pStyleQuoteItemStatus.CustomKey INNER JOIN
			dbo.pStyleHeader sh WITH (NOLOCK) ON dbo.pStyleQuoteItem.StyleID = sh.StyleID INNER JOIN
			fnx_Permissions_GetIntProductTypePermissions(@TeamID, 4) access ON access.ProductTypeId = sh.StyleType
			LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
		WHERE (sh.Active = 1) 
		  AND (pStyleQuoteItem.StyleQuoteItemDueDate BETWEEN @StartDate AND @EndDate) 
		  AND  (pStyleQuoteItem.StyleQuoteItemStatusId = 0) 
		  AND (pStyleQuoteItem.TradePartnerID = @TradePartnerId) 
		  AND (PermissionRoleId = 3 OR PermissionView = 1)
	
	END
ELSE
	BEGIN

		INSERT INTO dbo.pStyleCalendarTemp
			(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
		SELECT @CalendarId AS CalendarId, dbo.pStyleQuoteItem.StyleQuoteItemID, sh.StyleID, sh.DevelopmentID, 
			pStyleQuoteItem.StyleQuoteItemApprovedDate, 'Quote' AS CalendarType, pStyleQuoteItem.StyleQuoteItemStatusId,
			'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + sh.StyleNo + 
			' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription, 0
		FROM dbo.pStyleQuote WITH (NOLOCK) INNER JOIN
			dbo.pStyleQuoteItem WITH (NOLOCK) ON dbo.pStyleQuote.StyleQuoteID = dbo.pStyleQuoteItem.StyleQuoteID INNER JOIN
			dbo.uTradePartnerVendor WITH (NOLOCK) ON dbo.pStyleQuoteItem.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
			dbo.uTradePartner WITH (NOLOCK) ON dbo.pStyleQuote.TradePartnerID = dbo.uTradePartner.TradePartnerID INNER JOIN
			dbo.pStyleQuoteItemStatus WITH (NOLOCK) ON dbo.pStyleQuoteItem.StyleQuoteItemStatusId = dbo.pStyleQuoteItemStatus.CustomKey INNER JOIN
			dbo.pStyleHeader sh WITH (NOLOCK) ON dbo.pStyleQuoteItem.StyleID = sh.StyleID INNER JOIN
			fnx_Permissions_GetIntProductTypePermissions(@TeamID, 4) access ON access.ProductTypeId = sh.StyleType
			LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
		WHERE (sh.Active = 1) 
		  AND (pStyleQuoteItem.StyleQuoteItemApprovedDate BETWEEN @StartDate AND @EndDate) 
		  AND (pStyleQuoteItem.StyleQuoteItemStatusId <> 0) 
	      AND (PermissionRoleId = 3 OR PermissionView = 1)


		INSERT INTO dbo.pStyleCalendarTemp
			(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
		SELECT @CalendarId AS CalendarId, dbo.pStyleQuoteItem.StyleQuoteItemID, sh.StyleID, sh.DevelopmentID, 
			pStyleQuoteItem.StyleQuoteItemDueDate, 'Quote' AS CalendarType, pStyleQuoteItem.StyleQuoteItemStatusId,
			'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + sh.StyleNo + 
			' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription, 0
		FROM dbo.pStyleQuote WITH (NOLOCK) INNER JOIN
			dbo.pStyleQuoteItem WITH (NOLOCK) ON dbo.pStyleQuote.StyleQuoteID = dbo.pStyleQuoteItem.StyleQuoteID INNER JOIN
			dbo.uTradePartnerVendor WITH (NOLOCK) ON dbo.pStyleQuoteItem.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
			dbo.uTradePartner WITH (NOLOCK) ON dbo.pStyleQuote.TradePartnerID = dbo.uTradePartner.TradePartnerID INNER JOIN
			dbo.pStyleQuoteItemStatus WITH (NOLOCK) ON dbo.pStyleQuoteItem.StyleQuoteItemStatusId = dbo.pStyleQuoteItemStatus.CustomKey INNER JOIN
			dbo.pStyleHeader sh WITH (NOLOCK) ON dbo.pStyleQuoteItem.StyleID = sh.StyleID INNER JOIN
			fnx_Permissions_GetIntProductTypePermissions(@TeamID, 4) access ON access.ProductTypeId = sh.StyleType
			LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
		WHERE (sh.Active = 1) 
		  AND (pStyleQuoteItem.StyleQuoteItemDueDate BETWEEN @StartDate AND @EndDate) 
		  AND  (pStyleQuoteItem.StyleQuoteItemStatusId = 0) 
		  AND (PermissionRoleId = 3 OR PermissionView = 1)

	END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09814', GetDate())
GO
