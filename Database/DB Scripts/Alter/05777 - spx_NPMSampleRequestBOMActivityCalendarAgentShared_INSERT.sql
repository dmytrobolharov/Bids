IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMSampleRequestBOMActivityCalendarAgentShared_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMSampleRequestBOMActivityCalendarAgentShared_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_NPMSampleRequestBOMActivityCalendarAgentShared_INSERT]
(@TradePartnerId varchar(50),
@CalendarId varchar(50),
@StartDate datetime,
@EndDate datetime)
AS 

BEGIN

INSERT INTO pStyleCalendarTemp(
	CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, 
	CalendarDate, CalendarType, CalendarStatus, CalendarDescription, 
	CalendarView, CalendarSN, CalendarSubmit)
SELECT     @CalendarId AS CalendarId, a.SampleRequestWorkflowID, a.SampleRequestTradeID, 
    c.SampleWorkflow + N' (' + CAST(a.Submit AS varchar(4)) + ') ' AS CalendarLinkSubId, 
    d.CDate, 'SampleActivity' AS CalendarType, d.ActivityType, 
    '<b>TP: </b>' + SUBSTRING(ISNULL('/' + tprl.AgentCode, '') + ISNULL('/' + tprl.VendorCode,'') + ISNULL ('/' + tprl.FactoryCode, ''), 2, 1000) + ' ' + '<BR>' + b.StyleNo + ' (' +
    b.SizeClass + ') ' + b.Description AS CalendarDescription, a.AgentView , a.StyleSet, a.Submit
FROM  pSampleRequestSubmitBOM a WITH (NOLOCK) INNER JOIN pStyleHeader b WITH (NOLOCK) ON a.StyleID = b.StyleID 
INNER JOIN pSampleWorkflow c WITH (NOLOCK) ON a.SampleWorkflowID = c.SampleWorkflowID 
INNER JOIN pSampleRequestBOMActivity d WITH (NOLOCK) ON a.SampleRequestSubmitID = d.SampleRequestSubmitID 
INNER JOIN pSampleRequestBOMTrade f WITH (NOLOCK) ON a.SampleRequestTradeID = f.SampleRequestTradeID 
INNER JOIN pSampleRequestShare srs ON f.SampleRequestTradeID = srs.SampleRequestTradeID AND srs.TradePartnerID = @TradePartnerId
INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON tprl.TradePartnerRelationshipLevelID = f.TradePartnerRelationshipLevelID
INNER JOIN pSampleRequestWorkflowBOM g WITH (NOLOCK) ON g.SampleRequestWorkflowID = a.SampleRequestWorkflowID
WHERE -- (d.TradePartnerId = @TradePartnerId) AND	
		(d.TradePartner = 0)
	AND (d.CDate BETWEEN @StartDate AND @EndDate) 
	AND d.ActivityType IN ( 'R', 'A', 'SD' ) 	

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05777', GetDate())
GO
