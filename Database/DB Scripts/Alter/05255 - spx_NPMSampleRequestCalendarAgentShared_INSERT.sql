/****** Object:  StoredProcedure [dbo].[spx_NPMSampleRequestCalendarAgentShared_INSERT]    Script Date: 03/06/2013 16:56:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMSampleRequestCalendarAgentShared_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMSampleRequestCalendarAgentShared_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_NPMSampleRequestCalendarAgentShared_INSERT]
(@TradePartnerId varchar(50),
@CalendarId varchar(50),
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

INSERT INTO dbo.pStyleCalendarTemp(
	CalendarId, PKeyId, CalendarLinkId, 
	CalendarLinkSubId, CalendarDate, CalendarType, 
	CalendarStatus, CalendarDescription, CalendarView, CalendarSN, CalendarSubmit)
SELECT @CalendarId AS CalendarId, dbo.pSampleRequestWorkflow.SampleRequestWorkflowID, dbo.pSampleRequestWorkflow.SampleRequestTradeID, 
    dbo.pSampleWorkflow.SampleWorkflow + N' (' + CAST(dbo.pSampleRequestWorkflow.Submit AS varchar(4)) + ') ' AS CalendarLinkSubId, 
    dbo.pSampleRequestWorkflow.DueDate, 'SampleRequest' AS CalendarType, 
	CASE 
		WHEN  dbo.pSampleRequestWorkflow.Submit  > 1 THEN 1
		ELSE 0
	END
	AS Status, 
    '<b>TP: </b>' + COALESCE(tprl.FactoryCode, tprl.VendorCode, tprl.AgentCode) + ' ' + '<BR>' + dbo.pStyleHeader.StyleNo + ' (' +
    dbo.pStyleHeader.SizeClass + ') ' + dbo.pStyleHeader.Description AS CalendarDescription, 0 AS CalendarView , dbo.pSampleRequestWorkflow.StyleSet,
	dbo.pSampleRequestWorkflow.Submit
FROM dbo.pSampleRequestWorkflow WITH (NOLOCK) 
INNER JOIN pSampleRequestShare srs ON srs.SampleRequestTradeID = pSampleRequestWorkflow.SampleRequestTradeID AND srs.TradePartnerID = @TradePartnerId
INNER JOIN dbo.pSampleWorkflow WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID 
INNER JOIN dbo.pStyleHeader WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.StyleID = dbo.pStyleHeader.StyleID 
INNER JOIN pSampleRequestTrade srt ON pSampleRequestWorkflow.SampleRequestTradeID = srt.SampleRequestTradeID
INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON srt.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
WHERE     (dbo.pSampleRequestWorkflow.DueDate BETWEEN @StartDate AND @EndDate) AND 
		dbo.pSampleRequestWorkflow.Status IN (0,1)
ORDER BY DueDate, StyleNo, pSampleWorkflow.SampleWorkflowID

	
	

END 






set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05255', GetDate())
GO
