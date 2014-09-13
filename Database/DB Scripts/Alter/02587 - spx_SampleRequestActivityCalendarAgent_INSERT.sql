

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestActivityCalendarAgent_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestActivityCalendarAgent_INSERT]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestActivityCalendarAgent_INSERT]    Script Date: 01/13/2012 02:33:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spx_SampleRequestActivityCalendarAgent_INSERT]
	@TeamId [varchar](50),
	@TradePartnerId [varchar](50)=null,
	@CalendarId [varchar](50),
	@StartDate [datetime],
	@EndDate [datetime]
WITH EXECUTE AS CALLER
AS
/*
BEGIN
	INSERT INTO dbo.pStyleCalendarTemp
		(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
	SELECT @CalendarId AS CalendarId, pSampleRequestSubmit.SampleRequestWorkflowID, pSampleRequestSubmit.SampleRequestTradeId, 
		dbo.pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestSubmit.Submit AS varchar(4)) + ') ' AS CalendarLinkSubId, 
		dbo.pSampleRequestActivity.CDate, 'SampleActivity' AS CalendarType, dbo.pSampleRequestActivity.ActivityType, 
		'<b>A: </b>' + dbo.uTradePartner.TradePartnerCode + ' / <b>V: </b>' + dbo.uTradePartnerVendor.VendorCode + '<BR>' + dbo.pStyleHeader.StyleNo + ' (' +
		dbo.pStyleHeader.SizeClass + ') ' + dbo.pStyleHeader.Description AS CalendarDescription, pSampleRequestSubmit.AgentView 
	FROM dbo.pSampleRequestSubmit WITH (NOLOCK) INNER JOIN
		dbo.pStyleHeader WITH (NOLOCK) ON dbo.pSampleRequestSubmit.StyleID = dbo.pStyleHeader.StyleID INNER JOIN
		dbo.pSampleWorkflow WITH (NOLOCK) ON dbo.pSampleRequestSubmit.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID INNER JOIN
		dbo.pSampleRequestActivity WITH (NOLOCK) ON 
		dbo.pSampleRequestSubmit.SampleRequestSubmitID = dbo.pSampleRequestActivity.SampleRequestSubmitID INNER JOIN
		dbo.uTradePartner WITH (NOLOCK) ON dbo.pSampleRequestActivity.TradePartnerId = dbo.uTradePartner.TradePartnerID INNER JOIN
		dbo.uTradePartnerVendor WITH (NOLOCK) ON dbo.pSampleRequestActivity.TradePartnerVendorId = dbo.uTradePartnerVendor.TradePartnerVendorID
	WHERE     (dbo.pSampleRequestActivity.TradePartnerId = @TradePartnerId) 
	AND (dbo.pSampleRequestActivity.TradePartner = 0)
	AND     (dbo.pSampleRequestActivity.CDate BETWEEN @StartDate AND @EndDate) 
	AND pSampleRequestActivity.ActivityType <> 'V'
	ORDER BY  dbo.pStyleHeader.StyleNo, dbo.pSampleWorkflow.SampleWorkflowID, pSampleRequestActivity.Cdate ASC	
END 
*/

IF @TradePartnerId IS NULL

BEGIN
INSERT INTO pStyleCalendarTemp
      (CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
SELECT     @CalendarId AS CalendarId, pSampleRequestSubmit.SampleRequestWorkflowID, pSampleRequestSubmit.SampleRequestTradeID, 
    pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestSubmit.Submit AS varchar(4)) + ') ' AS CalendarLinkSubId, 
    pSampleRequestActivity.CDate, 'SampleActivity' AS CalendarType, pSampleRequestActivity.ActivityType, 
    '<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + pStyleHeader.StyleNo + ' (' +
    pStyleHeader.SizeClass + ') ' + pStyleHeader.Description AS CalendarDescription, pSampleRequestSubmit.AgentView
FROM         pSampleRequestSubmit WITH (NOLOCK) INNER JOIN
    pStyleHeader WITH (NOLOCK) ON pSampleRequestSubmit.StyleID = pStyleHeader.StyleID INNER JOIN
    pSampleWorkflow WITH (NOLOCK) ON pSampleRequestSubmit.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID INNER JOIN
    pSampleRequestActivity WITH (NOLOCK) ON 
    pSampleRequestSubmit.SampleRequestSubmitID = pSampleRequestActivity.SampleRequestSubmitID INNER JOIN
    uTradePartner WITH (NOLOCK) ON pSampleRequestActivity.TradePartnerId = uTradePartner.TradePartnerID INNER JOIN
    uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestActivity.TradePartnerVendorId = uTradePartnerVendor.TradePartnerVendorID INNER JOIN
    pSampleRequestTrade WITH (NOLOCK) ON pSampleRequestSubmit.SampleRequestTradeID = pSampleRequestTrade.SampleRequestTradeID 
 WHERE  (pSampleRequestActivity.TradePartner = 0)
	AND (pSampleRequestActivity.CDate BETWEEN @StartDate AND @EndDate) 
	AND (pSampleRequestActivity.ActivityType NOT IN ('V','U')) 
	AND (pSampleRequestSubmit.SampleWorkflowID IN (SELECT SampleWorkflowId FROM  pSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId = @TeamId))  
	AND pSampleWorkflow.SampleWorkflowID in  (  SELECT  SampleTypeId from sAccessSampleFolder WITH (NOLOCK) where TeamId = @TeamId  AND ( AccessRoleId =  3 OR AccessView = 1) ) 
	ORDER BY pSampleRequestActivity.Cdate DESC, pStyleHeader.StyleNo, pSampleWorkflow.SampleWorkflowID 	
END
ELSE

BEGIN
INSERT INTO pStyleCalendarTemp
      (CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
SELECT     @CalendarId AS CalendarId, pSampleRequestSubmit.SampleRequestWorkflowID, pSampleRequestSubmit.SampleRequestTradeID, 
    pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestSubmit.Submit AS varchar(4)) + ') ' AS CalendarLinkSubId, 
    pSampleRequestActivity.CDate, 'SampleActivity' AS CalendarType, pSampleRequestActivity.ActivityType, 
    '<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + pStyleHeader.StyleNo + ' (' +
    pStyleHeader.SizeClass + ') ' + pStyleHeader.Description AS CalendarDescription, pSampleRequestSubmit.AgentView
FROM         pSampleRequestSubmit WITH (NOLOCK) INNER JOIN
    pStyleHeader WITH (NOLOCK) ON pSampleRequestSubmit.StyleID = pStyleHeader.StyleID INNER JOIN
    pSampleWorkflow WITH (NOLOCK) ON pSampleRequestSubmit.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID INNER JOIN
    pSampleRequestActivity WITH (NOLOCK) ON 
    pSampleRequestSubmit.SampleRequestSubmitID = pSampleRequestActivity.SampleRequestSubmitID INNER JOIN
    uTradePartner WITH (NOLOCK) ON pSampleRequestActivity.TradePartnerId = uTradePartner.TradePartnerID INNER JOIN
    uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestActivity.TradePartnerVendorId = uTradePartnerVendor.TradePartnerVendorID INNER JOIN
    pSampleRequestTrade WITH (NOLOCK) ON pSampleRequestSubmit.SampleRequestTradeID = pSampleRequestTrade.SampleRequestTradeID 
 WHERE     (pSampleRequestActivity.TradePartnerId = @TradePartnerId) 
	AND (pSampleRequestActivity.TradePartner = 0)
	AND (pSampleRequestActivity.CDate BETWEEN @StartDate AND @EndDate) 
	AND (pSampleRequestActivity.ActivityType NOT IN ('V','U')) 
	AND (pSampleRequestSubmit.SampleWorkflowID IN (SELECT SampleWorkflowId FROM  pSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId = @TeamId))  
	AND pSampleWorkflow.SampleWorkflowID in  (  SELECT  SampleTypeId from sAccessSampleFolder WITH (NOLOCK) where TeamId = @TeamId  AND ( AccessRoleId =  3 OR AccessView = 1) ) 
	ORDER BY pSampleRequestActivity.Cdate DESC, pStyleHeader.StyleNo, pSampleWorkflow.SampleWorkflowID 	
END




GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02587'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02587', GetDate())
END
GO