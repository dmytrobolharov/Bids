IF OBJECT_ID(N'[dbo].[spx_SampleRequestCalendarAgentLate_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_SampleRequestCalendarAgentLate_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestCalendarAgentLate_INSERT]
(@TradePartnerId nvarchar(50),
@CalendarId nvarchar(50),
@StartDate datetime,
@EndDate datetime)
AS 

BEGIN
INSERT INTO dbo.pStyleCalendarTemp
  (CalendarId, PKeyId, CalendarLinkId, 
  CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription , CalendarSN )
SELECT TOP 100 @CalendarId AS CalendarId, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleRequestTradeId, 
pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestWorkflow.Submit AS nvarchar(4)) + ') ' AS CalendarLinkSubId, dbo.pSampleRequestWorkflow.DueDate, 'SampleRequest', pSampleRequestWorkflow.Status, 
    '<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + sh.StyleNo + ' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription ,
pSampleRequestWorkflow.StyleSet
FROM pSampleRequestWorkflow WITH (NOLOCK) 
INNER JOIN pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflow.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID 
INNER JOIN pStyleHeader sh WITH (NOLOCK) ON pSampleRequestWorkflow.StyleID = sh.StyleID 
INNER JOIN uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID 
INNER JOIN uTradePartner WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerID = uTradePartner.TradePartnerID 
INNER JOIN pSampleRequestTrade WITH (NOLOCK) ON pSampleRequestWorkflow.SampleRequestTradeID = pSampleRequestTrade.SampleRequestTradeID
LEFT JOIN pSizeClass sc ON sc.CustomId = sh.SizeClassId
WHERE     (dbo.pSampleRequestWorkflow.DueDate BETWEEN @StartDate AND @EndDate) AND (dbo.pSampleRequestTrade.SampleRequestShare = 1) AND 
(dbo.pSampleRequestWorkflow.Status IN (0, 1)) AND pSampleRequestWorkflow.TradePartnerID = @TradePartnerId 
ORDER BY pSampleRequestWorkflow.DueDate, sh.StyleNo, dbo.pSampleWorkflow.SampleWorkflowID	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09696', GetDate())
GO
