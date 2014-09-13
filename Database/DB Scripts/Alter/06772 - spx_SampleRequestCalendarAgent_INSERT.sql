IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestCalendarAgent_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestCalendarAgent_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestCalendarAgent_INSERT]
	@TeamId [varchar](50),
	@TradePartnerId [varchar](50) = null,
	@CalendarId [varchar](50),
	@StartDate [datetime],
	@EndDate [datetime],
	@SearchCond NVARCHAR(MAX) = N''
WITH EXECUTE AS CALLER
AS
/*Holiday's INSERT SELECT Statement.*/
INSERT INTO pStyleCalendarTemp
		(CalendarID, PKeyID, CalendarLinkID, CalendarLinkSubID, CalendarDate, CalendarType, CalendarStatus, CalendarDescription)
SELECT	@CalendarID AS CalendarID, '00000000-0000-0000-0000-000000000000' AS PKeyID, '00000000-0000-0000-0000-000000000000' AS CalendarLinkID, 
	'00000000-0000-0000-0000-000000000000' AS CalendarLinkSubID, CalendarEventDate AS CalendarDate, 'Holiday' AS CalendarType, 0 AS CalendarStatus,
	CalendarEventCountry +  ' - ' + CalendarEventName as CalendarDescription
FROM	cCalendarEvent WITH (NOLOCK)

;WITH srt as (
	SELECT SampleRequestTradeID, StyleID, TradePartnerRelationshipLevelID, TradePartnerID, TradePartnerVendorID, 0 AS IsBOM FROM pSampleRequestTrade 
	UNION
	SELECT SampleRequestTradeID, StyleID, TradePartnerRelationshipLevelID, TradePartnerID, TradePartnerVendorID, 1 AS IsBOM FROM pSampleRequestBOMTrade
), srw as (
	SELECT SampleRequestTradeID, SampleWorkflowID, SampleRequestWorkflowID, Submit, DueDate, EndDate, Status FROM pSampleRequestWorkflow
	UNION
	SELECT SampleRequestTradeID, SampleWorkflowID, SampleRequestWorkflowID, Submit, DueDate, EndDate, Status FROM pSampleRequestWorkflowBOM
)
SELECT @CalendarId AS CalendarId,
	srw.SampleRequestWorkflowID AS PKeyId,
	srw.SampleRequestTradeID AS CalendarLinkId,
	sw.SampleWorkflow + N' (' + CAST(srw.Submit AS nVARCHAR(4)) + ') ' AS CalendarLinkSubId,
	srw.DueDate AS CalendarDate,
	'SampleRequest' AS CalendarType,
	srw.Status AS CalendarStatus,
	CASE WHEN srt.TradePartnerRelationshipLevelID IS NOT NULL
		THEN SUBSTRING(ISNULL('/' + tprl.AgentName, '') + ISNULL('/' + tprl.VendorName, '') + ISNULL('/' + tprl.FactoryName, ''), 2, 2000)
		ELSE '<b>A: </b>' + tp.TradePartnerCode + ' / <b>V: </b>' + tpv.VendorCode
	END + '<BR>' + sh.StyleNo + ' (' + sh.SizeClass + ') ' + sh.Description AS CalendarDescription,
	0 AS CalendarView,
	srt.IsBOM as CalendarSN,
	-- columns for search purposes
	tp.TradePartnerID, tpv.TradePartnerVendorID,
	tprl.AgentID, tprl.VendorID, tprl.FactoryID
INTO #tmpCal
FROM srt
INNER JOIN srw ON srt.SampleRequestTradeID = srw.SampleRequestTradeID
INNER JOIN pSampleWorkflow sw ON srw.SampleWorkflowID = sw.SampleWorkflowID
INNER JOIN pStyleHeader sh ON srt.StyleID = sh.StyleID
LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON srt.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
LEFT JOIN uTradePartner tp ON srt.TradePartnerID = tp.TradePartnerID AND srt.TradePartnerRelationshipLevelID IS NULL
LEFT JOIN uTradePartnerVendor tpv ON srt.TradePartnerVendorID = tpv.TradePartnerVendorID AND srt.TradePartnerRelationshipLevelID IS NULL
WHERE 
	((srw.DueDate BETWEEN @StartDate AND @EndDate AND srw.Status NOT IN (
			SELECT StatusID FROM pSampleRequestSubmitStatus WHERE ApprovedType = 1 OR StatusID = 4))
	OR (srw.Status = 1 AND srw.EndDate BETWEEN @StartDate AND @EndDate))
	AND srw.SampleWorkflowID IN (
		SELECT SampleWorkflowId FROM pSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId = @TeamId)
	AND sw.SampleWorkflowID IN (
		SELECT SampleTypeId FROM sAccessSampleFolder WITH (NOLOCK) 
		WHERE TeamId = @TeamId AND (AccessRoleId = 3 OR AccessView = 1))		
	AND (@TradePartnerId IS NULL OR @TradePartnerId IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID, tp.TradePartnerID))
ORDER BY srw.DueDate, sh.StyleNo, sw.SampleWorkflowID

exec(N'
INSERT INTO pStyleCalendarTemp(
	CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, 
	CalendarType, CalendarStatus, CalendarDescription, CalendarView, CalendarSN)
SELECT CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate,
	CalendarType, CalendarStatus, CalendarDescription, CalendarView, CalendarSN
FROM #tmpCal ' + @SearchCond)

DROP TABLE #tmpCal

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06772', GetDate())
GO
