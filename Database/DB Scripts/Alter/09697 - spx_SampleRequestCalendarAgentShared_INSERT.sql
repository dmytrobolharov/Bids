IF OBJECT_ID(N'[dbo].[spx_SampleRequestCalendarAgentShared_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_SampleRequestCalendarAgentShared_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestCalendarAgentShared_INSERT]
(@TradePartnerId nvarchar(50),
@CalendarId nvarchar(50),
@StartDate datetime,
@EndDate datetime)
AS 

/*
@SubmitStatusId
Open =				0
Resubmit =			1
Apv w/ Correction = 2
Approved =			3
Dropped =			4
*/


BEGIN
INSERT INTO dbo.pStyleCalendarTemp
  (CalendarId, PKeyId, CalendarLinkId, 
  CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView, CalendarSN, CalendarSubmit )
SELECT     @CalendarId AS CalendarId, dbo.pSampleRequestWorkflow.SampleRequestWorkflowID, dbo.pSampleRequestWorkflow.SampleRequestTradeID, 
        dbo.pSampleWorkflow.SampleWorkflow + N' (' + CAST(dbo.pSampleRequestWorkflow.Submit AS nvarchar(4)) + ') ' AS CalendarLinkSubId, 
        dbo.pSampleRequestWorkflow.DueDate, 'SampleRequest' AS CalendarType, 
		CASE 
			WHEN  dbo.pSampleRequestWorkflow.Submit  > 1 THEN 1
			ELSE 0
		END
		AS Status, 
        '<b>A: </b>' + dbo.uTradePartner.TradePartnerCode + ' / <b>V: </b>' + dbo.uTradePartnerVendor.VendorCode + '<BR>' + sh.StyleNo + ' (' +
        COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription, 0 AS CalendarView , dbo.pSampleRequestWorkflow.StyleSet,
		dbo.pSampleRequestWorkflow.Submit 
FROM         dbo.pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
        dbo.pSampleWorkflow WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID INNER JOIN
        dbo.pStyleHeader sh WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.StyleID = sh.StyleID INNER JOIN
        dbo.uTradePartnerVendor WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
        dbo.uTradePartner WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.TradePartnerID = dbo.uTradePartner.TradePartnerID INNER JOIN
        dbo.pSampleRequestTrade WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.SampleRequestTradeID = dbo.pSampleRequestTrade.SampleRequestTradeID
		LEFT JOIN pSizeClass sc ON sc.CustomId = sh.SizeClassId
WHERE     (dbo.pSampleRequestWorkflow.DueDate BETWEEN @StartDate AND @EndDate) AND 
		dbo.pSampleRequestWorkflow.Status IN (0,1) AND 
		--(dbo.pSampleRequestWorkflow.Status NOT IN (2, 3, 4)) AND 
        (dbo.pSampleRequestWorkflow.TradePartnerID = @TradePartnerId) AND (dbo.pSampleRequestTrade.SampleRequestShare = 1)
ORDER BY dbo.pSampleRequestWorkflow.DueDate, sh.StyleNo, dbo.pSampleWorkflow.SampleWorkflowID	

END 


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09697', GetDate())
GO
