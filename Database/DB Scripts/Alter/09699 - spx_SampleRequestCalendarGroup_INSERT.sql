IF OBJECT_ID(N'[dbo].[spx_SampleRequestCalendarGroup_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_SampleRequestCalendarGroup_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestCalendarGroup_INSERT]
(@CalendarId nvarchar(50),
@StartDate datetime,
@EndDate datetime)
AS 


BEGIN
INSERT INTO dbo.pStyleCalendarTemp
	(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription)
SELECT @CalendarId AS CalendarId, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleRequestTradeId, 
pSampleWorkflow.SampleWorkflow, dbo.pSampleRequestWorkflow.DueDate, 'SampleRequest', pSampleRequestWorkflow.Status, 
    '<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + sh.StyleNo + 
	' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription
FROM         dbo.pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
    dbo.pSampleWorkflow WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID INNER JOIN
    dbo.pStyleHeader sh WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.StyleID = sh.StyleID INNER JOIN
    dbo.uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
	dbo.uTradePartner WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerID = dbo.uTradePartner.TradePartnerID 
	LEFT JOIN pSizeClass sc ON sc.CustomId = sh.SizeClassId
WHERE     (dbo.pSampleRequestWorkflow.DueDate BETWEEN @StartDate AND @EndDate) 
--AND (dbo.pSampleRequestWorkflow.Status NOT IN (2, 3, 4)) 
AND (dbo.pSampleRequestWorkflow.Status NOT IN ( SELECT StatusID FROM dbo.pSampleRequestSubmitStatus WHERE ApprovedType = 1 OR StatusID = 4 )) 
ORDER BY dbo.pSampleRequestWorkflow.DueDate, sh.StyleNo, dbo.pSampleWorkflow.SampleWorkflowID	
END 


BEGIN

INSERT INTO dbo.pStyleCalendarTemp
	(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription)
SELECT @CalendarId AS CalendarId, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleRequestTradeId, 
sh.DevelopmentID, dbo.pSampleRequestWorkflow.DueDate, pSampleWorkflow.SampleWorkflow, pSampleRequestWorkflow.Status, 
    '<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + sh.StyleNo + 
	' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription
FROM         dbo.pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
    dbo.pSampleWorkflow WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID INNER JOIN
    dbo.pStyleHeader sh WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.StyleID = sh.StyleID INNER JOIN
    dbo.uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
	dbo.uTradePartner WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerID = dbo.uTradePartner.TradePartnerID 
	LEFT JOIN pSizeClass sc ON sc.CustomId = sh.SizeClassId
WHERE     (pSampleRequestWorkflow.EndDate BETWEEN @StartDate AND @EndDate) AND (pSampleRequestWorkflow.Status = 1) 
ORDER BY pSampleRequestWorkflow.EndDate, sh.StyleNo, dbo.pSampleWorkflow.SampleWorkflowID

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09699', GetDate())
GO
