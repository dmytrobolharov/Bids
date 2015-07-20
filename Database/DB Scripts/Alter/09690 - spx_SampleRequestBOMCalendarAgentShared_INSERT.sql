IF OBJECT_ID(N'[dbo].[spx_SampleRequestBOMCalendarAgentShared_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_SampleRequestBOMCalendarAgentShared_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestBOMCalendarAgentShared_INSERT]
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
  CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView, CalendarSN, CalendarSubmit,StyleID )
SELECT     @CalendarId AS CalendarId, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleRequestTradeID, 
        dbo.pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestWorkflow.Submit AS nvarchar(4)) + ') ' AS CalendarLinkSubId, 
        pSampleRequestWorkflow.DueDate, 'SampleRequest' AS CalendarType, 
		CASE 
			WHEN  pSampleRequestWorkflow.Submit  > 1 THEN 1
			ELSE 0
		END
		AS Status, 
        '<b>A: </b>' + dbo.uTradePartner.TradePartnerCode + ' / <b>V: </b>' + dbo.uTradePartnerVendor.VendorCode + '<BR>' + sh.StyleNo + ' (' +
        COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription, 0 AS CalendarView ,pSampleRequestWorkflow.StyleSet,
		pSampleRequestWorkflow.Submit,pSampleRequestWorkflow.StyleID 
FROM         pSampleRequestWorkflowBOM pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
        dbo.pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflow.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID INNER JOIN
        dbo.pStyleHeader sh WITH (NOLOCK) ON pSampleRequestWorkflow.StyleID = sh.StyleID INNER JOIN
        dbo.uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
        dbo.uTradePartner WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerID = dbo.uTradePartner.TradePartnerID INNER JOIN
        dbo.pSampleRequestBOMTrade WITH (NOLOCK) ON pSampleRequestWorkflow.SampleRequestTradeID = pSampleRequestBOMTrade.SampleRequestTradeID
		LEFT JOIN pSizeClass sc ON sc.CustomId = sh.SizeClassId
WHERE     (pSampleRequestWorkflow.DueDate BETWEEN @StartDate AND @EndDate) AND 
		pSampleRequestWorkflow.Status IN (0,1) AND 
        (pSampleRequestWorkflow.TradePartnerID = @TradePartnerId) AND (pSampleRequestBOMTrade.SampleRequestShare = 1)
ORDER BY pSampleRequestWorkflow.DueDate, sh.StyleNo, dbo.pSampleWorkflow.SampleWorkflowID	

END 


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09690', GetDate())
GO
