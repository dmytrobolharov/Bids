/****** Object:  StoredProcedure [dbo].[spx_StyleQuoteActivityCalendarAgentShared_INSERT]    Script Date: 03/05/2013 16:25:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuoteActivityCalendarAgentShared_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleQuoteActivityCalendarAgentShared_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleQuoteActivityCalendarAgentShared_INSERT]
(@TradePartnerId varchar(50),
@CalendarId varchar(50),
@StartDate datetime,
@EndDate datetime)
AS 

BEGIN


	INSERT INTO dbo.pStyleCalendarTemp
		(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
	SELECT   @CalendarId AS CalendarId,  pStyleQuoteItem.StyleQuoteItemId, pStyleQuoteItem.StyleId, 
		pStyleQuoteItem.styleQuoteId AS CalendarLinkSubId, 
		pStyleQuoteItemActivity.CDate, 'QuoteActivity' AS CalendarType, pStyleQuoteItemActivity.ActivityType, 
		'<b>A: </b>' + dbo.uTradePartner.TradePartnerCode + ' / <b>V: </b>' + dbo.uTradePartnerVendor.VendorCode + '<BR>' + dbo.pStyleHeader.StyleNo + ' (' +
		dbo.pStyleHeader.SizeClass + ') ' + dbo.pStyleHeader.Description AS CalendarDescription, pStyleQuoteItem.AgentView
	FROM         pStyleQuoteItem WITH (NOLOCK) INNER JOIN
		dbo.pStyleHeader WITH (NOLOCK) ON pStyleQuoteItem.StyleID = dbo.pStyleHeader.StyleID INNER JOIN
		pStyleQuoteItemActivity WITH (NOLOCK) ON 
		pStyleQuoteItem.StyleQuoteItemId = pStyleQuoteItemActivity.StyleQuoteItemId INNER JOIN
		dbo.uTradePartner WITH (NOLOCK) ON pStyleQuoteItem.TradePartnerId = dbo.uTradePartner.TradePartnerID INNER JOIN
		dbo.uTradePartnerVendor WITH (NOLOCK) ON pStyleQuoteItem.TradePartnerVendorId = dbo.uTradePartnerVendor.TradePartnerVendorID
	WHERE     (uTradePartner.TradePartnerId = @TradePartnerId) 
	AND (pStyleQuoteItemActivity.TradePartner = 0)
	AND     (pStyleQuoteItemActivity.CDate BETWEEN @StartDate AND @EndDate) 
	AND pStyleQuoteItemActivity.ActivityType NOT IN ('V','A') AND (pStyleQuoteItem.StyleQuoteItemShare = 1)
	AND pStyleQuoteItem.TradePartnerVendorID IS NOT NULL
	ORDER BY  dbo.pStyleHeader.StyleNo, pStyleQuoteItemActivity.ActivityType, pStyleQuoteItemActivity.Cdate ASC	
	
	-- new partner management quotes
	
	INSERT INTO dbo.pStyleCalendarTemp
		(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
	SELECT   @CalendarId AS CalendarId,  qi.StyleQuoteItemId, qi.StyleId, 
		qi.styleQuoteId AS CalendarLinkSubId, 
		qia.CDate, 'QuoteActivity' AS CalendarType, qia.ActivityType, 
		SUBSTRING(ISNULL('/' + tprl.AgentCode, '') + ISNULL('/' + tprl.VendorCode,'') + ISNULL ('/' + tprl.FactoryCode, ''), 2,1000) + '<BR>' + sh.StyleNo + ' (' +
		sh.SizeClass + ') ' + sh.Description AS CalendarDescription, 1
	FROM pStyleQuoteItem qi WITH (NOLOCK) 
	INNER JOIN pStyleQuoteItemShare qis ON qi.StyleQuoteItemID = qis.StyleQouteItemID AND qis.TradePartnerID = @TradePartnerId
	INNER JOIN pSourcingTradePartner stp ON qi.StyleQuoteTradePartnerID = stp.SourcingTradePartnerID
	INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON stp.TradePartnerLevelID = tprl.TradePartnerRelationshipLevelID
	INNER JOIN pStyleHeader sh WITH (NOLOCK) ON qi.StyleID = sh.StyleID 
	INNER JOIN pStyleQuoteItemActivity qia WITH (NOLOCK) ON qi.StyleQuoteItemId = qia.StyleQuoteItemId 	
	WHERE qia.CDate BETWEEN @StartDate AND @EndDate
		AND qia.ActivityType NOT IN ('V','A')
	ORDER BY  sh.StyleNo, qia.ActivityType, qia.Cdate ASC	

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05226', GetDate())
GO
