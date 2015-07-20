IF OBJECT_ID(N'[dbo].[spx_SampleRequestActivityCalendar_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_SampleRequestActivityCalendar_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestActivityCalendar_INSERT]
(@CalendarId nvarchar(50),
@StartDate datetime,
@EndDate datetime)
AS 

BEGIN
INSERT INTO dbo.pStyleCalendarTemp
      (CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
SELECT @CalendarId AS CalendarId, pSampleRequestSubmit.SampleRequestWorkflowID, pSampleRequestSubmit.SampleRequestTradeId, 
       dbo.pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestSubmit.Submit AS nvarchar(4)) + ') ' AS CalendarLinkSubId, 
       dbo.pSampleRequestActivity.CDate, 'SampleActivity' AS CalendarType, dbo.pSampleRequestActivity.ActivityType, 
       '<b>A: </b>' + dbo.uTradePartner.TradePartnerCode + ' / <b>V: </b>' + dbo.uTradePartnerVendor.VendorCode + '<BR>' + sh.StyleNo + ' (' +
       COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription, pSampleRequestSubmit.AgentView 
FROM dbo.pSampleRequestSubmit WITH (NOLOCK) INNER JOIN
      dbo.pStyleHeader sh WITH (NOLOCK) ON dbo.pSampleRequestSubmit.StyleID = sh.StyleID INNER JOIN
      dbo.pSampleWorkflow WITH (NOLOCK) ON dbo.pSampleRequestSubmit.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID INNER JOIN
      dbo.pSampleRequestActivity WITH (NOLOCK) ON 
      dbo.pSampleRequestSubmit.SampleRequestSubmitID = dbo.pSampleRequestActivity.SampleRequestSubmitID INNER JOIN
      dbo.uTradePartner WITH (NOLOCK) ON dbo.pSampleRequestActivity.TradePartnerId = dbo.uTradePartner.TradePartnerID INNER JOIN
      dbo.uTradePartnerVendor WITH (NOLOCK) ON dbo.pSampleRequestActivity.TradePartnerVendorId = dbo.uTradePartnerVendor.TradePartnerVendorID
	  LEFT JOIN pSizeClass sc ON sc.CustomId = sh.SizeClassId
WHERE (dbo.pSampleRequestActivity.CDate BETWEEN @StartDate AND @EndDate) 
AND pSampleRequestActivity.ActivityType <> 'V'
ORDER BY  sh.StyleNo, dbo.pSampleWorkflow.SampleWorkflowID, pSampleRequestActivity.Cdate ASC	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09678', GetDate())
GO
