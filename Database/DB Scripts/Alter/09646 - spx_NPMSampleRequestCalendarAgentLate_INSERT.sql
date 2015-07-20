IF OBJECT_ID(N'[dbo].[spx_NPMSampleRequestCalendarAgentLate_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_NPMSampleRequestCalendarAgentLate_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_NPMSampleRequestCalendarAgentLate_INSERT]
(@TradePartnerId nvarchar(50),
@CalendarId nvarchar(50),
@StartDate datetime,
@EndDate datetime)
AS 

BEGIN

INSERT INTO dbo.pStyleCalendarTemp(
	CalendarId, PKeyId, CalendarLinkId, 
	CalendarLinkSubId, CalendarDate, CalendarType, 
	CalendarStatus, CalendarDescription , CalendarSN)
SELECT TOP 100 
	t.CalendarId, t.SampleRequestWorkflowID, t.SampleRequestTradeId, 
	t.CalendarLinkSubId, t.DueDate, t.SampleRequest, 
	t.Status, t.CalendarDescription, t.StyleSet
FROM (
	-- not BOM sample requests
	SELECT 
		@CalendarId AS CalendarId, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleRequestTradeId, pSampleWorkflow.SampleWorkflowID, 
		pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestWorkflow.Submit AS nvarchar(4)) + ') ' AS CalendarLinkSubId, pSampleRequestWorkflow.DueDate, 'SampleRequest' as SampleRequest, 
		pSampleRequestWorkflow.Status, '<b>TP: </b>' + (ISNULL(tprl.AgentName, '') + ISNULL('/' + tprl.VendorName,'') + ISNULL ('/' + tprl.FactoryName, '')) + '<br />' + sh.StyleNo + ' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription ,
		pSampleRequestWorkflow.StyleSet, sh.StyleNo
	FROM pSampleRequestWorkflow WITH (NOLOCK) 
		INNER JOIN pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflow.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID 
		INNER JOIN pStyleHeader sh WITH (NOLOCK) ON pSampleRequestWorkflow.StyleID = sh.StyleID 
		INNER JOIN pSampleRequestTrade ON pSampleRequestWorkflow.SampleRequestTradeID = pSampleRequestTrade.SampleRequestTradeID
		INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl WITH (NOLOCK) ON pSampleRequestTrade.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID 	
		INNER JOIN pSampleRequestShare ON pSampleRequestTrade.SampleRequestTradeID = pSampleRequestShare.SampleRequestTradeID AND pSampleRequestShare.TradePartnerID = @TradePartnerId
		LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
	WHERE (pSampleRequestWorkflow.DueDate BETWEEN @StartDate AND @EndDate)
		AND (pSampleRequestWorkflow.Status IN (0, 1))
	UNION
	-- BOM sample requests
	SELECT 
		@CalendarId AS CalendarId, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleRequestTradeId, pSampleWorkflow.SampleWorkflowID, 
		pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestWorkflow.Submit AS nvarchar(4)) + ') ' AS CalendarLinkSubId, pSampleRequestWorkflow.DueDate, 'SampleRequest' as SampleRequest, 
		pSampleRequestWorkflow.Status, '<b>TP: </b>' + (ISNULL(tprl.AgentName, '') + ISNULL('/' + tprl.VendorName,'') + ISNULL ('/' + tprl.FactoryName, '')) + '<br />' + sh.StyleNo + ' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription ,
		pSampleRequestWorkflow.StyleSet, sh.StyleNo
	FROM pSampleRequestWorkflowBOM pSampleRequestWorkflow WITH (NOLOCK) 
		INNER JOIN pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflow.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID 
		INNER JOIN pStyleHeader sh WITH (NOLOCK) ON pSampleRequestWorkflow.StyleID = sh.StyleID 
		INNER JOIN pSampleRequestBOMTrade pSampleRequestTrade ON pSampleRequestWorkflow.SampleRequestTradeID = pSampleRequestTrade.SampleRequestTradeID
		INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl WITH (NOLOCK) ON pSampleRequestTrade.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID 	
		INNER JOIN pSampleRequestShare ON pSampleRequestTrade.SampleRequestTradeID = pSampleRequestShare.SampleRequestTradeID AND pSampleRequestShare.TradePartnerID = @TradePartnerId
		LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
	WHERE (pSampleRequestWorkflow.DueDate BETWEEN @StartDate AND @EndDate)
		AND (pSampleRequestWorkflow.Status IN (0, 1))
) t
ORDER BY t.DueDate, t.StyleNo, t.SampleWorkflowID	

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09646', GetDate())
GO
