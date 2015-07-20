/****** Object:  StoredProcedure [dbo].[spx_NPMStyleQuoteCalendarPartner_INSERT]    Script Date: 06/04/2014 12:56:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMStyleQuoteCalendarPartner_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMStyleQuoteCalendarPartner_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_NPMStyleQuoteCalendarPartner_INSERT]    Script Date: 06/04/2014 12:56:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_NPMStyleQuoteCalendarPartner_INSERT]
(@TeamId uniqueidentifier,
@TradePartnerId uniqueidentifier = NULL,
@CalendarId uniqueidentifier,
@StartDate datetime,
@EndDate datetime)
AS 

IF @TradePartnerId IS NOT NULL
	BEGIN

		INSERT INTO dbo.pStyleCalendarTemp(
			CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, 
			CalendarType, CalendarStatus, CalendarDescription, CalendarView)
		SELECT @CalendarId AS CalendarId, qi.StyleQuoteItemID, sh.StyleID, sh.DevelopmentID, 
			qi.StyleQuoteItemApprovedDate, 'Quote' AS CalendarType, qi.StyleQuoteItemStatusId,
			SUBSTRING(ISNULL('/' + tprl.AgentCode, '') + ISNULL('/' + tprl.VendorCode, '') + ISNULL('/' + tprl.FactoryCode, ''), 2, 1000) 
				+ '<BR>' + sh.StyleNo + ' (' + sh.SizeClass + ') ' + sh.Description AS CalendarDescription, 0
		FROM pStyleQuoteItem qi 
		INNER JOIN pSourcingTradePartner stp ON qi.StyleQuoteTradePartnerID = stp.SourcingTradePartnerID
		INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON stp.TradePartnerLevelID = tprl.TradePartnerRelationshipLevelID
		INNER JOIN pStyleQuoteItemStatus qis WITH (NOLOCK) ON qi.StyleQuoteItemStatusId = qis.CustomKey 
		INNER JOIN pStyleHeader sh WITH (NOLOCK) ON qi.StyleID = sh.StyleID 
		INNER JOIN fnx_Permissions_GetIntProductTypePermissions(@TeamID, 4) access ON access.ProductTypeId = sh.StyleType
		WHERE sh.Active = 1
			AND qi.StyleQuoteItemApprovedDate BETWEEN @StartDate AND @EndDate
			AND qi.StyleQuoteItemStatusId <> 0
			AND @TradePartnerId IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID)
			AND (access.PermissionRoleId = 3 OR access.PermissionView = 1)

		INSERT INTO dbo.pStyleCalendarTemp(
			CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, 
			CalendarType, CalendarStatus, CalendarDescription, CalendarView)
		SELECT @CalendarId AS CalendarId, qi.StyleQuoteItemID, sh.StyleID, sh.DevelopmentID, 
			qi.StyleQuoteItemDueDate, 'Quote' AS CalendarType, qi.StyleQuoteItemStatusId,
			SUBSTRING(ISNULL('/' + tprl.AgentCode, '') + ISNULL('/' + tprl.VendorCode, '') + ISNULL('/' + tprl.FactoryCode, ''), 2, 1000) 
				+ '<BR>' + sh.StyleNo + ' (' + sh.SizeClass + ') ' + sh.Description AS CalendarDescription, 0
		FROM pStyleQuoteItem qi 
		INNER JOIN pSourcingTradePartner stp ON qi.StyleQuoteTradePartnerID = stp.SourcingTradePartnerID
		INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON stp.TradePartnerLevelID = tprl.TradePartnerRelationshipLevelID
		INNER JOIN pStyleQuoteItemStatus qis WITH (NOLOCK) ON qi.StyleQuoteItemStatusId = qis.CustomKey 
		INNER JOIN pStyleHeader sh WITH (NOLOCK) ON qi.StyleID = sh.StyleID
		INNER JOIN fnx_Permissions_GetIntProductTypePermissions(@TeamID, 4) access ON access.ProductTypeId = sh.StyleType
		WHERE sh.Active = 1
			AND qi.StyleQuoteItemDueDate BETWEEN @StartDate AND @EndDate
			AND qi.StyleQuoteItemStatusId = 0
			AND @TradePartnerId IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID)
			AND (access.PermissionRoleId = 3 OR access.PermissionView = 1)

	END
ELSE
	BEGIN
	
		INSERT INTO dbo.pStyleCalendarTemp(
			CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, 
			CalendarType, CalendarStatus, CalendarDescription, CalendarView)
		SELECT @CalendarId AS CalendarId, qi.StyleQuoteItemID, sh.StyleID, sh.DevelopmentID, 
			qi.StyleQuoteItemApprovedDate, 'Quote' AS CalendarType, qi.StyleQuoteItemStatusId,
			SUBSTRING(ISNULL('/' + tprl.AgentCode, '') + ISNULL('/' + tprl.VendorCode, '') + ISNULL('/' + tprl.FactoryCode, ''), 2, 1000) 
				+ '<BR>' + sh.StyleNo + ' (' + sh.SizeClass + ') ' + sh.Description AS CalendarDescription, 0
		FROM pStyleQuoteItem qi 
		INNER JOIN pSourcingTradePartner stp ON qi.StyleQuoteTradePartnerID = stp.SourcingTradePartnerID
		INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON stp.TradePartnerLevelID = tprl.TradePartnerRelationshipLevelID
		INNER JOIN pStyleQuoteItemStatus qis WITH (NOLOCK) ON qi.StyleQuoteItemStatusId = qis.CustomKey 
		INNER JOIN pStyleHeader sh WITH (NOLOCK) ON qi.StyleID = sh.StyleID
		INNER JOIN fnx_Permissions_GetIntProductTypePermissions(@TeamID, 4) access ON access.ProductTypeId = sh.StyleType
		WHERE sh.Active = 1
			AND qi.StyleQuoteItemApprovedDate BETWEEN @StartDate AND @EndDate
			AND qi.StyleQuoteItemStatusId <> 0			
			AND (access.PermissionRoleId = 3 OR access.PermissionView = 1) 

		INSERT INTO dbo.pStyleCalendarTemp(
			CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, 
			CalendarType, CalendarStatus, CalendarDescription, CalendarView)
		SELECT @CalendarId AS CalendarId, qi.StyleQuoteItemID, sh.StyleID, sh.DevelopmentID, 
			qi.StyleQuoteItemDueDate, 'Quote' AS CalendarType, qi.StyleQuoteItemStatusId,
			SUBSTRING(ISNULL('/' + tprl.AgentCode, '') + ISNULL('/' + tprl.VendorCode, '') + ISNULL('/' + tprl.FactoryCode, ''), 2, 1000) 
				+ '<BR>' + sh.StyleNo + ' (' + sh.SizeClass + ') ' + sh.Description AS CalendarDescription, 0
		FROM pStyleQuoteItem qi 
		INNER JOIN pSourcingTradePartner stp ON qi.StyleQuoteTradePartnerID = stp.SourcingTradePartnerID
		INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON stp.TradePartnerLevelID = tprl.TradePartnerRelationshipLevelID
		INNER JOIN pStyleQuoteItemStatus qis WITH (NOLOCK) ON qi.StyleQuoteItemStatusId = qis.CustomKey 
		INNER JOIN pStyleHeader sh WITH (NOLOCK) ON qi.StyleID = sh.StyleID
		INNER JOIN fnx_Permissions_GetIntProductTypePermissions(@TeamID, 4) access ON access.ProductTypeId = sh.StyleType
		WHERE sh.Active = 1
			AND qi.StyleQuoteItemDueDate BETWEEN @StartDate AND @EndDate
			AND qi.StyleQuoteItemStatusId = 0			
			AND (access.PermissionRoleId = 3 OR access.PermissionView = 1) 		 

	END



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07873', GetDate())
GO