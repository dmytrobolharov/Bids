/****** Object:  StoredProcedure [dbo].[spx_NPMSampleRequestActivityCalendarAgentShared_INSERT]    Script Date: 03/06/2013 17:24:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMSampleRequestActivityCalendarAgentShared_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMSampleRequestActivityCalendarAgentShared_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_NPMSampleRequestActivityCalendarAgentShared_INSERT]
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
    '<b>TP: </b>' + COALESCE(tprl.FactoryCode, tprl.VendorCode, tprl.AgentCode) + '<BR>' + b.StyleNo + ' (' +
    b.SizeClass + ') ' + b.Description AS CalendarDescription, a.AgentView , a.StyleSet, a.Submit
FROM  pSampleRequestSubmit a WITH (NOLOCK) INNER JOIN pStyleHeader b WITH (NOLOCK) ON a.StyleID = b.StyleID 
INNER JOIN pSampleWorkflow c WITH (NOLOCK) ON a.SampleWorkflowID = c.SampleWorkflowID 
INNER JOIN pSampleRequestActivity d WITH (NOLOCK) ON a.SampleRequestSubmitID = d.SampleRequestSubmitID 
-- INNER JOIN uTradePartnerVendor e WITH (NOLOCK) ON d.TradePartnerVendorId = e.TradePartnerVendorID 
INNER JOIN pSampleRequestTrade f WITH (NOLOCK) ON a.SampleRequestTradeID = f.SampleRequestTradeID 
INNER JOIN pSampleRequestShare srs ON f.SampleRequestTradeID = srs.SampleRequestTradeID AND srs.TradePartnerID = @TradePartnerId
INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON tprl.TradePartnerRelationshipLevelID = f.TradePartnerRelationshipLevelID
INNER JOIN pSampleRequestWorkflow g WITH (NOLOCK) ON g.SampleRequestWorkflowID = a.SampleRequestWorkflowID
WHERE -- (d.TradePartnerId = @TradePartnerId) AND	
		(d.TradePartner = 0)
	AND (d.CDate BETWEEN @StartDate AND @EndDate) 
	AND d.ActivityType IN ( 'R', 'A', 'SD' ) 

END




set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05257', GetDate())
GO
