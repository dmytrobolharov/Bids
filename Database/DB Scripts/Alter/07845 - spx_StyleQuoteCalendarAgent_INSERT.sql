/****** Object:  StoredProcedure [dbo].[spx_StyleQuoteCalendarAgent_INSERT]    Script Date: 06/03/2014 11:31:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuoteCalendarAgent_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleQuoteCalendarAgent_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleQuoteCalendarAgent_INSERT]    Script Date: 06/03/2014 11:31:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
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
		SELECT @CalendarId AS CalendarId, dbo.pStyleQuoteItem.StyleQuoteItemID, dbo.pStyleHeader.StyleID, dbo.pStyleHeader.DevelopmentID, 
			pStyleQuoteItem.StyleQuoteItemApprovedDate, 'Quote' AS CalendarType, pStyleQuoteItem.StyleQuoteItemStatusId,
			'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + dbo.pStyleHeader.StyleNo + ' (' + dbo.pStyleHeader.SizeClass + ') ' + dbo.pStyleHeader.Description AS CalendarDescription, 0
		FROM dbo.pStyleQuote WITH (NOLOCK) INNER JOIN
			dbo.pStyleQuoteItem WITH (NOLOCK) ON dbo.pStyleQuote.StyleQuoteID = dbo.pStyleQuoteItem.StyleQuoteID INNER JOIN
			dbo.uTradePartnerVendor WITH (NOLOCK) ON dbo.pStyleQuoteItem.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
			dbo.uTradePartner WITH (NOLOCK) ON dbo.pStyleQuote.TradePartnerID = dbo.uTradePartner.TradePartnerID INNER JOIN
			dbo.pStyleQuoteItemStatus WITH (NOLOCK) ON dbo.pStyleQuoteItem.StyleQuoteItemStatusId = dbo.pStyleQuoteItemStatus.CustomKey INNER JOIN
			dbo.pStyleHeader WITH (NOLOCK) ON dbo.pStyleQuoteItem.StyleID = dbo.pStyleHeader.StyleID INNER JOIN
			fnx_Permissions_GetIntProductTypePermissions(@TeamID, 4) access ON access.ProductTypeId = pStyleHeader.StyleType
		WHERE (dbo.pStyleHeader.Active = 1) 
		  AND (pStyleQuoteItem.StyleQuoteItemApprovedDate BETWEEN @StartDate AND @EndDate) 
		  AND (pStyleQuoteItem.StyleQuoteItemStatusId <> 0) 
		  AND (pStyleQuoteItem.TradePartnerID = @TradePartnerId) 
	      AND (PermissionRoleId = 3 OR PermissionView = 1)


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
			dbo.pStyleHeader WITH (NOLOCK) ON dbo.pStyleQuoteItem.StyleID = dbo.pStyleHeader.StyleID INNER JOIN
			fnx_Permissions_GetIntProductTypePermissions(@TeamID, 4) access ON access.ProductTypeId = pStyleHeader.StyleType
		WHERE (dbo.pStyleHeader.Active = 1) 
		  AND (pStyleQuoteItem.StyleQuoteItemDueDate BETWEEN @StartDate AND @EndDate) 
		  AND  (pStyleQuoteItem.StyleQuoteItemStatusId = 0) 
		  AND (pStyleQuoteItem.TradePartnerID = @TradePartnerId) 
		  AND (PermissionRoleId = 3 OR PermissionView = 1)
	
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
			dbo.pStyleHeader WITH (NOLOCK) ON dbo.pStyleQuoteItem.StyleID = dbo.pStyleHeader.StyleID INNER JOIN
			fnx_Permissions_GetIntProductTypePermissions(@TeamID, 4) access ON access.ProductTypeId = pStyleHeader.StyleType
		WHERE (dbo.pStyleHeader.Active = 1) 
		  AND (pStyleQuoteItem.StyleQuoteItemApprovedDate BETWEEN @StartDate AND @EndDate) 
		  AND (pStyleQuoteItem.StyleQuoteItemStatusId <> 0) 
	      AND (PermissionRoleId = 3 OR PermissionView = 1)


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
			dbo.pStyleHeader WITH (NOLOCK) ON dbo.pStyleQuoteItem.StyleID = dbo.pStyleHeader.StyleID INNER JOIN
			fnx_Permissions_GetIntProductTypePermissions(@TeamID, 4) access ON access.ProductTypeId = pStyleHeader.StyleType
		WHERE (dbo.pStyleHeader.Active = 1) 
		  AND (pStyleQuoteItem.StyleQuoteItemDueDate BETWEEN @StartDate AND @EndDate) 
		  AND  (pStyleQuoteItem.StyleQuoteItemStatusId = 0) 
		  AND (PermissionRoleId = 3 OR PermissionView = 1)

	END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07845', GetDate())
GO