IF OBJECT_ID(N'[dbo].[spx_StyleQuoteActivityCalendarAgent_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleQuoteActivityCalendarAgent_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleQuoteActivityCalendarAgent_INSERT]
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
			'<b>A: </b>' + dbo.uTradePartner.TradePartnerCode + ' / <b>V: </b>' + dbo.uTradePartnerVendor.VendorCode + '<BR>' + sh.StyleNo + ' (' +
			COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription, pStyleQuoteItem.AgentView
		FROM pStyleQuoteItem WITH (NOLOCK) INNER JOIN
			dbo.pStyleHeader sh WITH (NOLOCK) ON pStyleQuoteItem.StyleID = sh.StyleID INNER JOIN
			pStyleQuoteItemActivity WITH (NOLOCK) ON pStyleQuoteItem.StyleQuoteItemId = pStyleQuoteItemActivity.StyleQuoteItemId INNER JOIN
			dbo.uTradePartner WITH (NOLOCK) ON pStyleQuoteItem.TradePartnerId = dbo.uTradePartner.TradePartnerID INNER JOIN
			dbo.uTradePartnerVendor WITH (NOLOCK) ON pStyleQuoteItem.TradePartnerVendorId = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
			fnx_Permissions_GetIntProductTypePermissions(@TeamID, 4) access ON access.ProductTypeId = sh.StyleType
			LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
		WHERE (pStyleQuoteItemActivity.TeamId = @TradePartnerId) 
		  AND (pStyleQuoteItemActivity.TradePartner = 1)
		  AND (pStyleQuoteItemActivity.CDate BETWEEN @StartDate AND @EndDate) 
		  AND pStyleQuoteItemActivity.ActivityType <> 'V'
		  AND (access.PermissionRoleId = 3 OR access.PermissionView = 1)
		ORDER BY sh.StyleNo, pStyleQuoteItemActivity.ActivityType, pStyleQuoteItemActivity.Cdate ASC	

	END
ELSE
	BEGIN

		INSERT INTO dbo.pStyleCalendarTemp
			(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
		SELECT @CalendarId AS CalendarId,  pStyleQuoteItem.StyleQuoteItemId, pStyleQuoteItem.StyleId, 
			pStyleQuoteItem.styleQuoteId AS CalendarLinkSubId, pStyleQuoteItemActivity.CDate, 
			'QuoteActivity' AS CalendarType, pStyleQuoteItemActivity.ActivityType, 
			'<b>A: </b>' + dbo.uTradePartner.TradePartnerCode + ' / <b>V: </b>' + dbo.uTradePartnerVendor.VendorCode + '<BR>' + sh.StyleNo + ' (' +
			COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription, pStyleQuoteItem.AgentView
		FROM pStyleQuoteItem WITH (NOLOCK) INNER JOIN
			dbo.pStyleHeader sh WITH (NOLOCK) ON pStyleQuoteItem.StyleID = sh.StyleID INNER JOIN
			pStyleQuoteItemActivity WITH (NOLOCK) ON pStyleQuoteItem.StyleQuoteItemId = pStyleQuoteItemActivity.StyleQuoteItemId INNER JOIN
			dbo.uTradePartner WITH (NOLOCK) ON pStyleQuoteItem.TradePartnerId = dbo.uTradePartner.TradePartnerID INNER JOIN
			dbo.uTradePartnerVendor WITH (NOLOCK) ON pStyleQuoteItem.TradePartnerVendorId = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN 
			fnx_Permissions_GetIntProductTypePermissions(@TeamID, 4) access ON access.ProductTypeId = sh.StyleType
			LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
		WHERE (pStyleQuoteItemActivity.TradePartner = 1)
		  AND (pStyleQuoteItemActivity.CDate BETWEEN @StartDate AND @EndDate) 
		  AND pStyleQuoteItemActivity.ActivityType <> 'V'
		  AND (access.PermissionRoleId = 3 OR access.PermissionView = 1)
		ORDER BY sh.StyleNo, pStyleQuoteItemActivity.ActivityType, pStyleQuoteItemActivity.Cdate ASC	

	END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09811', GetDate())
GO
