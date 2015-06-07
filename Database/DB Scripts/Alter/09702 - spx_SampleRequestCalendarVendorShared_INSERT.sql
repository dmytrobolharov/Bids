IF OBJECT_ID(N'[dbo].[spx_SampleRequestCalendarVendorShared_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_SampleRequestCalendarVendorShared_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestCalendarVendorShared_INSERT]
(@TradePartnerId nvarchar(50),
@TradePartnerVendorId nvarchar(50),
@CalendarId nvarchar(50),
@StartDate datetime,
@EndDate datetime)
AS 


BEGIN
INSERT INTO dbo.pStyleCalendarTemp
  (CalendarId, PKeyId, CalendarLinkId, 
  CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
SELECT     @CalendarId AS CalendarId, dbo.pSampleRequestWorkflow.SampleRequestWorkflowID, dbo.pSampleRequestWorkflow.SampleRequestTradeID, 
                      dbo.pSampleWorkflow.SampleWorkflow + N' (' + CAST(dbo.pSampleRequestWorkflow.Submit AS nvarchar(4)) + ') ' AS CalendarLinkSubId, 
                      dbo.pSampleRequestWorkflow.DueDate, 'SampleRequest' AS Expr1, dbo.pSampleRequestWorkflow.Status, 
                      '<b>A: </b>' + dbo.uTradePartner.TradePartnerCode + ' / <b>V: </b>' + dbo.uTradePartnerVendor.VendorCode + '<BR>' + sh.StyleNo + ' (' +
                       COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription, 0 AS Expr2
FROM         dbo.pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
                      dbo.pSampleWorkflow WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID INNER JOIN
                      dbo.pStyleHeader sh WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.StyleID = sh.StyleID INNER JOIN
                      dbo.uTradePartnerVendor WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
                      dbo.uTradePartner WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.TradePartnerID = dbo.uTradePartner.TradePartnerID INNER JOIN
                      dbo.pSampleRequestTrade WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.SampleRequestTradeID = dbo.pSampleRequestTrade.SampleRequestTradeID
					  LEFT JOIN pSizeClass sc ON sc.CustomId = sh.SizeClassId
WHERE     (dbo.pSampleRequestWorkflow.DueDate BETWEEN @StartDate AND @EndDate) 
--AND (dbo.pSampleRequestWorkflow.Status NOT IN (2, 3, 4)) 
AND (dbo.pSampleRequestWorkflow.Status NOT IN ( SELECT StatusID FROM dbo.pSampleRequestSubmitStatus WHERE ApprovedType = 1 OR StatusID = 4  )) 
AND (dbo.pSampleRequestWorkflow.TradePartnerID = @TradePartnerId) AND 
                      (dbo.pSampleRequestWorkflow.TradePartnerVendorID = @TradePartnerVendorId) AND (dbo.pSampleRequestTrade.SampleRequestShare = 1)
ORDER BY dbo.pSampleRequestWorkflow.DueDate, sh.StyleNo, dbo.pSampleWorkflow.SampleWorkflowID
END 


BEGIN

INSERT INTO dbo.pStyleCalendarTemp
  (CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
SELECT     @CalendarId AS CalendarId, dbo.pSampleRequestWorkflow.SampleRequestWorkflowID, dbo.pSampleRequestWorkflow.SampleRequestTradeID, 
                      dbo.pSampleWorkflow.SampleWorkflow + N' (' + CAST(dbo.pSampleRequestWorkflow.Submit AS nvarchar(4)) + ') ' AS CalendarLinkSubId, 
                      dbo.pSampleRequestWorkflow.DueDate, 'SampleRequest' AS Expr1, dbo.pSampleRequestWorkflow.Status, 
                      '<b>A: </b>' + dbo.uTradePartner.TradePartnerCode + ' / <b>V: </b>' + dbo.uTradePartnerVendor.VendorCode + '<BR>' + sh.StyleNo + ' (' +
                       COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription, 0 AS Expr2
FROM         dbo.pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
                      dbo.pSampleWorkflow WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID INNER JOIN
                      dbo.pStyleHeader sh WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.StyleID = sh.StyleID INNER JOIN
                      dbo.uTradePartnerVendor WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
                      dbo.uTradePartner WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.TradePartnerID = dbo.uTradePartner.TradePartnerID INNER JOIN
                      dbo.pSampleRequestTrade WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.SampleRequestTradeID = dbo.pSampleRequestTrade.SampleRequestTradeID
					  LEFT JOIN pSizeClass sc ON sc.CustomId = sh.SizeClassId
WHERE     (dbo.pSampleRequestWorkflow.Status = 1) AND (dbo.pSampleRequestWorkflow.TradePartnerID = @TradePartnerId) AND 
                      (dbo.pSampleRequestWorkflow.TradePartnerVendorID = @TradePartnerVendorId) AND (dbo.pSampleRequestWorkflow.EndDate BETWEEN 
                      @StartDate AND @EndDate) AND (dbo.pSampleRequestTrade.SampleRequestShare = 1)
ORDER BY dbo.pSampleRequestWorkflow.EndDate, sh.StyleNo, dbo.pSampleWorkflow.SampleWorkflowID
END 


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09702', GetDate())
GO
