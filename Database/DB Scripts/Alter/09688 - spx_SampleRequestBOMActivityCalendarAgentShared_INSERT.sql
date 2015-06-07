IF OBJECT_ID(N'[dbo].[spx_SampleRequestBOMActivityCalendarAgentShared_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_SampleRequestBOMActivityCalendarAgentShared_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestBOMActivityCalendarAgentShared_INSERT]
(@TradePartnerId nvarchar(50),
@CalendarId nvarchar(50),
@StartDate datetime,
@EndDate datetime)
AS 

BEGIN
INSERT INTO pStyleCalendarTemp
      (CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, 
	CalendarView, CalendarSN, CalendarSubmit,StyleID )
SELECT     @CalendarId AS CalendarId, a.SampleRequestWorkflowID, a.SampleRequestTradeID, 
    c.SampleWorkflow + N' (' + CAST(a.Submit AS nvarchar(4)) + ') ' AS CalendarLinkSubId, 
    d.CDate, 'SampleActivity' AS CalendarType, d.ActivityType, 
    '<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + e.VendorCode + '<BR>' + b.StyleNo + ' (' +
    COALESCE(sc.Custom, b.SizeClass) + ') ' + b.Description AS CalendarDescription, a.AgentView , a.StyleSet, a.Submit,a.StyleID
FROM  pSampleRequestSubmitBOM a WITH (NOLOCK) INNER JOIN pStyleHeader b WITH (NOLOCK) ON a.StyleID = b.StyleID 
	INNER JOIN pSampleWorkflow c WITH (NOLOCK) ON a.SampleWorkflowID = c.SampleWorkflowID 
	INNER JOIN pSampleRequestBOMActivity d WITH (NOLOCK) ON a.SampleRequestSubmitID = d.SampleRequestSubmitID 
	INNER JOIN uTradePartner WITH (NOLOCK) ON d.TradePartnerId = uTradePartner.TradePartnerID 
	INNER JOIN uTradePartnerVendor e WITH (NOLOCK) ON d.TradePartnerVendorId = e.TradePartnerVendorID 
	INNER JOIN pSampleRequestBOMTrade f WITH (NOLOCK) ON a.SampleRequestTradeID = f.SampleRequestTradeID 
	INNER JOIN pSampleRequestWorkflowBOM g WITH (NOLOCK) ON g.SampleRequestWorkflowID = a.SampleRequestWorkflowID
	LEFT JOIN pSizeClass sc ON sc.CustomId = b.SizeClassId
 WHERE     (d.TradePartnerId = @TradePartnerId) 
	AND (d.TradePartner = 0)
	AND (d.CDate BETWEEN @StartDate AND @EndDate) 
	AND d.ActivityType IN ( 'R', 'A', 'SD' ) 
	AND f.SampleRequestShare = 1
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09688', GetDate())
GO
