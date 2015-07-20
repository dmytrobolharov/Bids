IF OBJECT_ID(N'[dbo].[spx_NPMStyleQuoteActivityCalendarPartner_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_NPMStyleQuoteActivityCalendarPartner_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_NPMStyleQuoteActivityCalendarPartner_INSERT]
(@Teamid uniqueidentifier,
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
		SELECT @CalendarId AS CalendarId,  qi.StyleQuoteItemId, qi.StyleId, 
			qi.styleQuoteId AS CalendarLinkSubId, qia.CDate, 
			'QuoteActivity' AS CalendarType, qia.ActivityType, 
			SUBSTRING(ISNULL('/' + tprl.AgentCode, '') + ISNULL('/' + tprl.VendorCode, '') + ISNULL('/' + tprl.FactoryCode, ''), 2, 1000) 
				 + '<BR>' + sh.StyleNo + ' (' +	COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription,
			CASE 
				WHEN EXISTS(
					SELECT * FROM pStyleQuoteItemShare qis 
					WHERE qis.StyleQouteItemID = qi.StyleQuoteItemID AND qis.PartnerView = 1
						AND qis.TradePartnerID IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID))
				THEN 1
				ELSE 0
			END
		FROM pStyleQuoteItem qi WITH (NOLOCK) 
		INNER JOIN dbo.pStyleHeader sh WITH (NOLOCK) ON qi.StyleID = sh.StyleID 
		INNER JOIN pStyleQuoteItemActivity qia WITH (NOLOCK) ON qi.StyleQuoteItemId = qia.StyleQuoteItemId 
		INNER JOIN pSourcingTradePartner stp ON qi.StyleQuoteTradePartnerID = stp.SourcingTradePartnerID
		INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON stp.TradePartnerLevelID = tprl.TradePartnerRelationshipLevelID	
		INNER JOIN fnx_Permissions_GetIntProductTypePermissions(@TeamID, 4) access ON access.ProductTypeId = sh.StyleType
		LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
		WHERE (qia.TeamId IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID)) 
			AND @TradePartnerId IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID)
			AND (qia.TradePartner = 1)
			AND (qia.CDate BETWEEN @StartDate AND @EndDate) 
			AND qia.ActivityType <> 'V'
			AND (access.PermissionRoleId = 3 OR access.PermissionView = 1) 
		ORDER BY sh.StyleNo, qia.ActivityType, qia.Cdate ASC	

	END
ELSE
	BEGIN

		INSERT INTO dbo.pStyleCalendarTemp(
			CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, 
			CalendarType, CalendarStatus, CalendarDescription, CalendarView)
		SELECT @CalendarId AS CalendarId,  qi.StyleQuoteItemId, qi.StyleId, 
			qi.styleQuoteId AS CalendarLinkSubId, qia.CDate, 
			'QuoteActivity' AS CalendarType, qia.ActivityType, 
			SUBSTRING(ISNULL('/' + tprl.AgentCode, '') + ISNULL('/' + tprl.VendorCode, '') + ISNULL('/' + tprl.FactoryCode, ''), 2, 1000) 
				 + '<BR>' + sh.StyleNo + ' (' +	COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription,
			CASE 
				WHEN EXISTS(
					SELECT * FROM pStyleQuoteItemShare qis 
					WHERE qis.StyleQouteItemID = qi.StyleQuoteItemID AND qis.PartnerView = 1
						AND qis.TradePartnerID IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID))
				THEN 1
				ELSE 0
			END
		FROM pStyleQuoteItem qi WITH (NOLOCK) 
		INNER JOIN dbo.pStyleHeader sh WITH (NOLOCK) ON qi.StyleID = sh.StyleID 
		INNER JOIN pStyleQuoteItemActivity qia WITH (NOLOCK) ON qi.StyleQuoteItemId = qia.StyleQuoteItemId 
		INNER JOIN pSourcingTradePartner stp ON qi.StyleQuoteTradePartnerID = stp.SourcingTradePartnerID
		INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON stp.TradePartnerLevelID = tprl.TradePartnerRelationshipLevelID	
		INNER JOIN fnx_Permissions_GetIntProductTypePermissions(@TeamID, 4) access ON access.ProductTypeId = sh.StyleType	
		LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
		WHERE (qia.TeamId IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID)) 
			AND (qia.TradePartner = 1)
			AND (qia.CDate BETWEEN @StartDate AND @EndDate) 
			AND qia.ActivityType <> 'V'
			AND (access.PermissionRoleId = 3 OR access.PermissionView = 1) 
		ORDER BY sh.StyleNo, qia.ActivityType, qia.Cdate ASC
		

	END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09656', GetDate())
GO
