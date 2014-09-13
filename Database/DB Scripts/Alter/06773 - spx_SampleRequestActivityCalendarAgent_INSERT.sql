IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestActivityCalendarAgent_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestActivityCalendarAgent_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestActivityCalendarAgent_INSERT]
	@TeamId [varchar](50),
	@TradePartnerId [varchar](50)=null,
	@CalendarId [varchar](50),
	@StartDate [datetime],
	@EndDate [datetime],
	@SearchCond NVARCHAR(MAX) = N''
WITH EXECUTE AS CALLER
AS

;WITH srt as (
	SELECT SampleRequestTradeID, StyleID, TradePartnerRelationshipLevelID, TradePartnerID, TradePartnerVendorID, 0 AS IsBOM FROM pSampleRequestTrade 
	UNION
	SELECT SampleRequestTradeID, StyleID, TradePartnerRelationshipLevelID, TradePartnerID, TradePartnerVendorID, 1 AS IsBOM FROM pSampleRequestBOMTrade
), srs as (
	SELECT SampleRequestTradeID, SampleWorkflowID, SampleRequestWorkflowID, SampleRequestSubmitID, Submit, AgentView FROM pSampleRequestSubmit
	UNION
	SELECT SampleRequestTradeID, SampleWorkflowID, SampleRequestWorkflowID, SampleRequestSubmitID, Submit, AgentView FROM pSampleRequestSubmitBOM
), sra as (
	SELECT SampleRequestSubmitID, ActivityType, TradePartner, CDate FROM pSampleRequestActivity
	UNION
	SELECT SampleRequestSubmitID, ActivityType, TradePartner, CDate FROM pSampleRequestBOMActivity
)
SELECT @CalendarId AS CalendarId,
	srs.SampleRequestWorkflowID AS PKeyId,
	srs.SampleRequestTradeID AS CalendarLinkId,
	sw.SampleWorkflow + N' (' + CAST(srs.Submit AS nVARCHAR(4)) + ') ' AS CalendarLinkSubId,
	sra.CDate AS CalendarDate,
	'SampleActivity' AS CalendarType,
	sra.ActivityType AS CalendarStatus,
	CASE WHEN srt.TradePartnerRelationshipLevelID IS NOT NULL
		THEN SUBSTRING(ISNULL('/' + tprl.AgentName, '') + ISNULL('/' + tprl.VendorName, '') + ISNULL('/' + tprl.FactoryName, ''), 2, 2000)
		ELSE '<b>A: </b>' + tp.TradePartnerCode + ' / <b>V: </b>' + tpv.VendorCode
	END + '<BR>' + sh.StyleNo + ' (' + sh.SizeClass + ') ' + sh.Description AS CalendarDescription,
	srs.AgentView AS CalendarView,
	srt.IsBOM as CalendarSN,
	-- columns for search purposes
	tp.TradePartnerID, tpv.TradePartnerVendorID,
	tprl.AgentID, tprl.VendorID, tprl.FactoryID
INTO #tmpCal
FROM srt
INNER JOIN srs ON srt.SampleRequestTradeID = srs.SampleRequestTradeID
INNER JOIN pSampleWorkflow sw ON srs.SampleWorkflowID = sw.SampleWorkflowID
INNER JOIN sra ON srs.SampleRequestSubmitID = sra.SampleRequestSubmitID
INNER JOIN pStyleHeader sh ON srt.StyleID = sh.StyleID
LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON srt.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
LEFT JOIN uTradePartner tp ON srt.TradePartnerID = tp.TradePartnerID AND srt.TradePartnerRelationshipLevelID IS NULL
LEFT JOIN uTradePartnerVendor tpv ON srt.TradePartnerVendorID = tpv.TradePartnerVendorID AND srt.TradePartnerRelationshipLevelID IS NULL
WHERE sra.TradePartner = 0
	AND sra.CDate BETWEEN @StartDate AND @EndDate
	AND sra.ActivityType NOT IN ('V', 'U')
	AND srs.SampleWorkflowID IN (
		SELECT SampleWorkflowId FROM pSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId = @TeamId)
	AND sw.SampleWorkflowID IN (
		SELECT SampleTypeId FROM sAccessSampleFolder WITH (NOLOCK)
		WHERE TeamId = @TeamId AND (AccessRoleId = 3 OR AccessView = 1))
	AND (@TradePartnerId IS NULL OR @TradePartnerId IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID, tp.TradePartnerID))
ORDER BY sra.Cdate DESC, sh.StyleNo, sw.SampleWorkflowID

exec(N'
INSERT INTO pStyleCalendarTemp(
	CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, 
	CalendarType, CalendarStatus, CalendarDescription, CalendarView, CalendarSN)
SELECT CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, 
	CalendarType, CalendarStatus, CalendarDescription, CalendarView, CalendarSN
FROM #tmpCal ' + @SearchCond)

DROP TABLE #tmpCal

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06773', GetDate())
GO
