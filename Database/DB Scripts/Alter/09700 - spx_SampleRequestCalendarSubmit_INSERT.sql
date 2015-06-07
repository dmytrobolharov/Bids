IF OBJECT_ID(N'[dbo].[spx_SampleRequestCalendarSubmit_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_SampleRequestCalendarSubmit_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestCalendarSubmit_INSERT]
(@SampleRequestTradeId nvarchar(50),
@CalendarId nvarchar(50),
@StartDate datetime,
@EndDate datetime)
AS 


BEGIN
INSERT INTO pStyleCalendarTemp
	(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription,CalendarSN)
SELECT @CalendarId AS CalendarId, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleRequestTradeId, 
pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestWorkflow.Submit AS nvarchar(4)) + ') ' AS CalendarLinkSubId, pSampleRequestWorkflow.DueDate, 'SampleRequest', pSampleRequestWorkflow.Status, 
    '<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + sh.StyleNo + 
	' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription,
pSampleRequestWorkflow.StyleSet  
FROM pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
    pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflow.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID INNER JOIN
    pStyleHeader sh WITH (NOLOCK) ON pSampleRequestWorkflow.StyleID = sh.StyleID INNER JOIN
    uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID INNER JOIN
	uTradePartner WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerID = uTradePartner.TradePartnerID 
	LEFT JOIN pSizeClass sc ON sc.CustomId = sh.SizeClassId
WHERE     (pSampleRequestWorkflow.DueDate BETWEEN @StartDate AND @EndDate) AND 
(
	--pSampleRequestWorkflow.Status NOT IN (2, 3, 4)
	pSampleRequestWorkflow.Status NOT IN ( select StatusID  from pSampleRequestSubmitStatus WHERE ApprovedType = 1 OR StatusID = 4 )
) 
AND pSampleRequestWorkflow.SampleRequestTradeID = @SampleRequestTradeID
ORDER BY pSampleRequestWorkflow.DueDate, sh.StyleNo, pSampleWorkflow.SampleWorkflowID	
END 


BEGIN

INSERT INTO pStyleCalendarTemp
	(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription , CalendarSN)
SELECT @CalendarId AS CalendarId, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleRequestTradeId, 
pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestWorkflow.Submit AS nvarchar(4)) + ') ' AS CalendarLinkSubId, pSampleRequestWorkflow.DueDate, pSampleWorkflow.SampleWorkflow, pSampleRequestWorkflow.Status, 
    '<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + sh.StyleNo + 
	' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription,
pSampleRequestWorkflow.StyleSet  
FROM pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
    pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflow.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID INNER JOIN
    pStyleHeader sh WITH (NOLOCK) ON pSampleRequestWorkflow.StyleID = sh.StyleID INNER JOIN
    uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID INNER JOIN
	uTradePartner WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerID = uTradePartner.TradePartnerID 
	LEFT JOIN pSizeClass sc ON sc.CustomId = sh.SizeClassId
WHERE     (pSampleRequestWorkflow.EndDate BETWEEN @StartDate AND @EndDate) AND (pSampleRequestWorkflow.Status = 1) AND 
	 pSampleRequestWorkflow.SampleRequestTradeID = @SampleRequestTradeID
ORDER BY pSampleRequestWorkflow.EndDate, sh.StyleNo, pSampleWorkflow.SampleWorkflowID

END 


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09700', GetDate())
GO
