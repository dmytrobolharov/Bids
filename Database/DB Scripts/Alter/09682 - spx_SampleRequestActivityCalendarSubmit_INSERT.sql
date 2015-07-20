IF OBJECT_ID(N'[dbo].[spx_SampleRequestActivityCalendarSubmit_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_SampleRequestActivityCalendarSubmit_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestActivityCalendarSubmit_INSERT]
(@SampleRequestTradeID nvarchar(50),
@CalendarId nvarchar(50),
@StartDate datetime,
@EndDate datetime)
AS 

BEGIN
INSERT INTO pStyleCalendarTemp
      (CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
SELECT @CalendarId AS CalendarId, pSampleRequestSubmit.SampleRequestWorkflowID, pSampleRequestSubmit.SampleRequestTradeId, 
      pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestSubmit.Submit AS nvarchar(4)) + ') ' AS CalendarLinkSubId, 
      pSampleRequestActivity.CDate, 'SampleActivity' AS CalendarType, pSampleRequestActivity.ActivityType, 
      '<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + sh.StyleNo + ' (' +
       COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription, pSampleRequestSubmit.AgentView
FROM pSampleRequestSubmit WITH (NOLOCK) INNER JOIN
      pStyleHeader sh WITH (NOLOCK) ON pSampleRequestSubmit.StyleID = sh.StyleID INNER JOIN
      pSampleWorkflow WITH (NOLOCK) ON pSampleRequestSubmit.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID INNER JOIN
      pSampleRequestActivity WITH (NOLOCK) ON 
      pSampleRequestSubmit.SampleRequestSubmitID = pSampleRequestActivity.SampleRequestSubmitID INNER JOIN
      uTradePartner WITH (NOLOCK) ON pSampleRequestActivity.TradePartnerId = uTradePartner.TradePartnerID INNER JOIN
      uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestActivity.TradePartnerVendorId = uTradePartnerVendor.TradePartnerVendorID
	  LEFT JOIN pSizeClass sc ON sc.CustomId = sh.SizeClassId
WHERE     (pSampleRequestSubmit.SampleRequestTradeID = @SampleRequestTradeID) 
AND (pSampleRequestActivity.TradePartner = 0)
AND     (pSampleRequestActivity.CDate BETWEEN @StartDate AND @EndDate) 
AND pSampleRequestActivity.ActivityType <> 'V'
ORDER BY  sh.StyleNo, pSampleWorkflow.SampleWorkflowID, pSampleRequestActivity.Cdate ASC	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09682', GetDate())
GO
