IF OBJECT_ID(N'[dbo].[spx_StyleQuoteCalendarAgentShared_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleQuoteCalendarAgentShared_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleQuoteCalendarAgentShared_INSERT]
(@TradePartnerId nvarchar(50),
@CalendarId nvarchar(50),
@StartDate datetime,
@EndDate datetime)
AS 


BEGIN
	INSERT INTO pStyleCalendarTemp
		(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
	SELECT     @CalendarId AS CalendarId, pStyleQuoteItem.StyleQuoteItemID, sh.StyleID, sh.DevelopmentID, 
		pStyleQuoteItem.StyleQuoteItemApprovedDate, 'Quote' AS CalendarType, pStyleQuoteItem.StyleQuoteItemStatusId,
		'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + sh.StyleNo + 
		' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription, 0
	FROM   pStyleQuote WITH (NOLOCK) INNER JOIN
		pStyleQuoteItem WITH (NOLOCK) ON pStyleQuote.StyleQuoteID = pStyleQuoteItem.StyleQuoteID INNER JOIN
		uTradePartnerVendor WITH (NOLOCK) ON pStyleQuoteItem.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID INNER JOIN
		uTradePartner WITH (NOLOCK) ON pStyleQuote.TradePartnerID = uTradePartner.TradePartnerID INNER JOIN
		pStyleQuoteItemStatus WITH (NOLOCK) ON pStyleQuoteItem.StyleQuoteItemStatusId = pStyleQuoteItemStatus.CustomKey INNER JOIN
		pStyleHeader sh WITH (NOLOCK) ON pStyleQuoteItem.StyleID = sh.StyleID
		LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
	WHERE (sh.Active = 1) AND (pStyleQuoteItem.StyleQuoteItemApprovedDate BETWEEN @StartDate AND @EndDate) AND 
		(pStyleQuoteItem.StyleQuoteItemStatusId <> 0) AND (pStyleQuoteItem.TradePartnerID = @TradePartnerId) AND
		(pStyleQuoteItem.StyleQuoteItemShare = 1) AND pStyleQuoteItem.TradePartnerVendorID IS NOT NULL
	

END 


BEGIN
	INSERT INTO pStyleCalendarTemp
		(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
	SELECT     @CalendarId AS CalendarId, pStyleQuoteItem.StyleQuoteItemID, sh.StyleID, sh.DevelopmentID, 
		pStyleQuoteItem.StyleQuoteItemDueDate, 'Quote' AS CalendarType, pStyleQuoteItem.StyleQuoteItemStatusId,
		'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + sh.StyleNo + 
		' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription, 0
	FROM   pStyleQuote WITH (NOLOCK) INNER JOIN
		pStyleQuoteItem WITH (NOLOCK) ON pStyleQuote.StyleQuoteID = pStyleQuoteItem.StyleQuoteID INNER JOIN
		uTradePartnerVendor WITH (NOLOCK) ON pStyleQuoteItem.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID INNER JOIN
		uTradePartner WITH (NOLOCK) ON pStyleQuote.TradePartnerID = uTradePartner.TradePartnerID INNER JOIN
		pStyleQuoteItemStatus WITH (NOLOCK) ON pStyleQuoteItem.StyleQuoteItemStatusId = pStyleQuoteItemStatus.CustomKey INNER JOIN
		pStyleHeader sh WITH (NOLOCK) ON pStyleQuoteItem.StyleID = sh.StyleID
		LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
	WHERE (sh.Active = 1) AND (pStyleQuoteItem.StyleQuoteItemDueDate BETWEEN @StartDate AND @EndDate) AND  
		(pStyleQuoteItem.StyleQuoteItemStatusId = 0) AND (pStyleQuoteItem.TradePartnerID = @TradePartnerId) AND
		(pStyleQuoteItem.StyleQuoteItemShare = 1) AND pStyleQuoteItem.TradePartnerVendorID IS NOT NULL
	
END

-- New partner management quotes
	INSERT INTO pStyleCalendarTemp(
		CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
	SELECT @CalendarId AS CalendarId, qi.StyleQuoteItemID, sh.StyleID, sh.DevelopmentID, 
		qi.StyleQuoteItemApprovedDate, 'Quote' AS CalendarType, qi.StyleQuoteItemStatusId,
		SUBSTRING(ISNULL('/' + tprl.AgentCode, '') + ISNULL('/' + tprl.VendorCode,'') + ISNULL ('/' + tprl.FactoryCode, ''), 2,1000) + '<BR>' + 
		sh.StyleNo + ' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription, 0
	FROM pStyleQuoteItem qi
	INNER JOIN pStyleQuoteItemShare qis ON qis.StyleQouteItemID = qi.StyleQuoteItemID AND qis.TradePartnerID = @TradePartnerId
	INNER JOIN pSourcingTradePartner stp ON qi.StyleQuoteTradePartnerID = stp.SourcingTradePartnerID
	INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON stp.TradePartnerLevelID = tprl.TradePartnerRelationshipLevelID		
	INNER JOIN pStyleQuoteItemStatus qist WITH (NOLOCK) ON qi.StyleQuoteItemStatusId = qist.CustomKey 
	INNER JOIN pStyleHeader sh WITH (NOLOCK) ON qi.StyleID = sh.StyleID
	LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
	WHERE sh.Active = 1 AND qi.StyleQuoteItemApprovedDate BETWEEN @StartDate AND @EndDate
		 AND qi.StyleQuoteItemStatusId <> 0
		 
	
	INSERT INTO pStyleCalendarTemp(
		CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
	SELECT @CalendarId AS CalendarId, qi.StyleQuoteItemID, sh.StyleID, sh.DevelopmentID, 
		qi.StyleQuoteItemDueDate, 'Quote' AS CalendarType, qi.StyleQuoteItemStatusId,
		SUBSTRING(ISNULL('/' + tprl.AgentCode, '') + ISNULL('/' + tprl.VendorCode,'') + ISNULL ('/' + tprl.FactoryCode, ''), 2,1000) + '<BR>' + 
		sh.StyleNo + ' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription, 0
	FROM pStyleQuoteItem qi
	INNER JOIN pStyleQuoteItemShare qis ON qis.StyleQouteItemID = qi.StyleQuoteItemID AND qis.TradePartnerID = @TradePartnerId
	INNER JOIN pSourcingTradePartner stp ON qi.StyleQuoteTradePartnerID = stp.SourcingTradePartnerID
	INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON stp.TradePartnerLevelID = tprl.TradePartnerRelationshipLevelID		
	INNER JOIN pStyleQuoteItemStatus qist WITH (NOLOCK) ON qi.StyleQuoteItemStatusId = qist.CustomKey 
	INNER JOIN pStyleHeader sh WITH (NOLOCK) ON qi.StyleID = sh.StyleID
	LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
	WHERE sh.Active = 1 AND qi.StyleQuoteItemDueDate BETWEEN @StartDate AND @EndDate
		 AND qi.StyleQuoteItemStatusId = 0
	

-- New partner management commitments
	INSERT INTO pStyleCalendarTemp(
		CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
	SELECT @CalendarId AS CalendarId, sci.SourcingCommitmentItemID, sh.StyleID, sh.DevelopmentID, 
		sci.StyleQuoteItemApprovedDate, 'Commitment' AS CalendarType, sci.StyleQuoteItemStatusId,
		SUBSTRING(ISNULL('/' + tprl.AgentCode, '') + ISNULL('/' + tprl.VendorCode,'') + ISNULL ('/' + tprl.FactoryCode, ''), 2,1000) + '<BR>' + 
		sh.StyleNo + ' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription, 0
	FROM pStyleQuoteItem qi
	INNER JOIN pSourcingCommitmentItem sci ON qi.StyleQuoteItemID = sci.StyleQuoteItemID
	INNER JOIN pStyleQuoteItemShare qis ON qis.StyleQouteItemID = qi.StyleQuoteItemID AND qis.TradePartnerID = @TradePartnerId
	INNER JOIN pSourcingTradePartner stp ON qi.StyleQuoteTradePartnerID = stp.SourcingTradePartnerID
	INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON stp.TradePartnerLevelID = tprl.TradePartnerRelationshipLevelID		
	INNER JOIN pStyleQuoteItemStatus qist WITH (NOLOCK) ON qi.StyleQuoteItemStatusId = qist.CustomKey 
	INNER JOIN pStyleHeader sh WITH (NOLOCK) ON qi.StyleID = sh.StyleID
	LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
	WHERE sh.Active = 1 AND sci.StyleQuoteItemApprovedDate BETWEEN @StartDate AND @EndDate
		 AND sci.StyleQuoteItemStatusId <> 0
		 
	
	INSERT INTO pStyleCalendarTemp(
		CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
	SELECT @CalendarId AS CalendarId, sci.SourcingCommitmentItemID, sh.StyleID, sh.DevelopmentID, 
		sci.StyleQuoteItemDueDate, 'Commitment' AS CalendarType, sci.StyleQuoteItemStatusId,
		SUBSTRING(ISNULL('/' + tprl.AgentCode, '') + ISNULL('/' + tprl.VendorCode,'') + ISNULL ('/' + tprl.FactoryCode, ''), 2,1000) + '<BR>' + 
		sh.StyleNo + ' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription, 0
	FROM pStyleQuoteItem qi
	INNER JOIN pSourcingCommitmentItem sci ON qi.StyleQuoteItemID = sci.StyleQuoteItemID
	INNER JOIN pStyleQuoteItemShare qis ON qis.StyleQouteItemID = qi.StyleQuoteItemID AND qis.TradePartnerID = @TradePartnerId
	INNER JOIN pSourcingTradePartner stp ON qi.StyleQuoteTradePartnerID = stp.SourcingTradePartnerID
	INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON stp.TradePartnerLevelID = tprl.TradePartnerRelationshipLevelID		
	INNER JOIN pStyleQuoteItemStatus qist WITH (NOLOCK) ON qi.StyleQuoteItemStatusId = qist.CustomKey 
	INNER JOIN pStyleHeader sh WITH (NOLOCK) ON qi.StyleID = sh.StyleID
	LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
	WHERE sh.Active = 1 AND sci.StyleQuoteItemDueDate BETWEEN @StartDate AND @EndDate
		 AND sci.StyleQuoteItemStatusId = 0


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09815', GetDate())
GO
