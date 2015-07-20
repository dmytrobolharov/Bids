/****** Object:  StoredProcedure [dbo].[spx_StyleQuoteCalendarAgentShared_INSERT]    Script Date: 03/05/2013 15:33:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuoteCalendarAgentShared_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleQuoteCalendarAgentShared_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleQuoteCalendarAgentShared_INSERT]
(@TradePartnerId varchar(50),
@CalendarId varchar(50),
@StartDate datetime,
@EndDate datetime)
AS 


BEGIN
	INSERT INTO pStyleCalendarTemp
		(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
	SELECT     @CalendarId AS CalendarId, pStyleQuoteItem.StyleQuoteItemID, pStyleHeader.StyleID, pStyleHeader.DevelopmentID, 
		pStyleQuoteItem.StyleQuoteItemApprovedDate, 'Quote' AS CalendarType, pStyleQuoteItem.StyleQuoteItemStatusId,
		'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + pStyleHeader.StyleNo + ' (' + pStyleHeader.SizeClass + ') ' + pStyleHeader.Description AS CalendarDescription, 0
	FROM   pStyleQuote WITH (NOLOCK) INNER JOIN
		pStyleQuoteItem WITH (NOLOCK) ON pStyleQuote.StyleQuoteID = pStyleQuoteItem.StyleQuoteID INNER JOIN
		uTradePartnerVendor WITH (NOLOCK) ON pStyleQuoteItem.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID INNER JOIN
		uTradePartner WITH (NOLOCK) ON pStyleQuote.TradePartnerID = uTradePartner.TradePartnerID INNER JOIN
		pStyleQuoteItemStatus WITH (NOLOCK) ON pStyleQuoteItem.StyleQuoteItemStatusId = pStyleQuoteItemStatus.CustomKey INNER JOIN
		pStyleHeader WITH (NOLOCK) ON pStyleQuoteItem.StyleID = pStyleHeader.StyleID
	WHERE (pStyleHeader.Active = 1) AND (pStyleQuoteItem.StyleQuoteItemApprovedDate BETWEEN @StartDate AND @EndDate) AND 
		(pStyleQuoteItem.StyleQuoteItemStatusId <> 0) AND (pStyleQuoteItem.TradePartnerID = @TradePartnerId) AND
		(pStyleQuoteItem.StyleQuoteItemShare = 1) AND pStyleQuoteItem.TradePartnerVendorID IS NOT NULL
	

END 


BEGIN
	INSERT INTO pStyleCalendarTemp
		(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
	SELECT     @CalendarId AS CalendarId, pStyleQuoteItem.StyleQuoteItemID, pStyleHeader.StyleID, pStyleHeader.DevelopmentID, 
		pStyleQuoteItem.StyleQuoteItemDueDate, 'Quote' AS CalendarType, pStyleQuoteItem.StyleQuoteItemStatusId,
		'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + pStyleHeader.StyleNo + ' (' + pStyleHeader.SizeClass + ') ' + pStyleHeader.Description AS CalendarDescription, 0
	FROM   pStyleQuote WITH (NOLOCK) INNER JOIN
		pStyleQuoteItem WITH (NOLOCK) ON pStyleQuote.StyleQuoteID = pStyleQuoteItem.StyleQuoteID INNER JOIN
		uTradePartnerVendor WITH (NOLOCK) ON pStyleQuoteItem.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID INNER JOIN
		uTradePartner WITH (NOLOCK) ON pStyleQuote.TradePartnerID = uTradePartner.TradePartnerID INNER JOIN
		pStyleQuoteItemStatus WITH (NOLOCK) ON pStyleQuoteItem.StyleQuoteItemStatusId = pStyleQuoteItemStatus.CustomKey INNER JOIN
		pStyleHeader WITH (NOLOCK) ON pStyleQuoteItem.StyleID = pStyleHeader.StyleID
	WHERE (pStyleHeader.Active = 1) AND (pStyleQuoteItem.StyleQuoteItemDueDate BETWEEN @StartDate AND @EndDate) AND  
		(pStyleQuoteItem.StyleQuoteItemStatusId = 0) AND (pStyleQuoteItem.TradePartnerID = @TradePartnerId) AND
		(pStyleQuoteItem.StyleQuoteItemShare = 1) AND pStyleQuoteItem.TradePartnerVendorID IS NOT NULL
	
END

-- New partner management quotes
	INSERT INTO pStyleCalendarTemp(
		CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
	SELECT @CalendarId AS CalendarId, qi.StyleQuoteItemID, sh.StyleID, sh.DevelopmentID, 
		qi.StyleQuoteItemApprovedDate, 'Quote' AS CalendarType, qi.StyleQuoteItemStatusId,
		SUBSTRING(ISNULL('/' + tprl.AgentCode, '') + ISNULL('/' + tprl.VendorCode,'') + ISNULL ('/' + tprl.FactoryCode, ''), 2,1000) + '<BR>' + sh.StyleNo + ' (' + sh.SizeClass + ') ' + sh.Description AS CalendarDescription, 0
	FROM pStyleQuoteItem qi
	INNER JOIN pStyleQuoteItemShare qis ON qis.StyleQouteItemID = qi.StyleQuoteItemID AND qis.TradePartnerID = @TradePartnerId
	INNER JOIN pSourcingTradePartner stp ON qi.StyleQuoteTradePartnerID = stp.SourcingTradePartnerID
	INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON stp.TradePartnerLevelID = tprl.TradePartnerRelationshipLevelID		
	INNER JOIN pStyleQuoteItemStatus qist WITH (NOLOCK) ON qi.StyleQuoteItemStatusId = qist.CustomKey 
	INNER JOIN pStyleHeader sh WITH (NOLOCK) ON qi.StyleID = sh.StyleID
	WHERE sh.Active = 1 AND qi.StyleQuoteItemApprovedDate BETWEEN @StartDate AND @EndDate
		 AND qi.StyleQuoteItemStatusId <> 0
		 
	
	INSERT INTO pStyleCalendarTemp(
		CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
	SELECT @CalendarId AS CalendarId, qi.StyleQuoteItemID, sh.StyleID, sh.DevelopmentID, 
		qi.StyleQuoteItemDueDate, 'Quote' AS CalendarType, qi.StyleQuoteItemStatusId,
		SUBSTRING(ISNULL('/' + tprl.AgentCode, '') + ISNULL('/' + tprl.VendorCode,'') + ISNULL ('/' + tprl.FactoryCode, ''), 2,1000) + '<BR>' + sh.StyleNo + ' (' + sh.SizeClass + ') ' + sh.Description AS CalendarDescription, 0
	FROM pStyleQuoteItem qi
	INNER JOIN pStyleQuoteItemShare qis ON qis.StyleQouteItemID = qi.StyleQuoteItemID AND qis.TradePartnerID = @TradePartnerId
	INNER JOIN pSourcingTradePartner stp ON qi.StyleQuoteTradePartnerID = stp.SourcingTradePartnerID
	INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON stp.TradePartnerLevelID = tprl.TradePartnerRelationshipLevelID		
	INNER JOIN pStyleQuoteItemStatus qist WITH (NOLOCK) ON qi.StyleQuoteItemStatusId = qist.CustomKey 
	INNER JOIN pStyleHeader sh WITH (NOLOCK) ON qi.StyleID = sh.StyleID
	WHERE sh.Active = 1 AND qi.StyleQuoteItemDueDate BETWEEN @StartDate AND @EndDate
		 AND qi.StyleQuoteItemStatusId = 0
	

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05227', GetDate())
GO
