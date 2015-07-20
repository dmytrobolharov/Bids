IF OBJECT_ID(N'[dbo].[spx_NPMSampleRequestCalendarAgentShared_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_NPMSampleRequestCalendarAgentShared_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_NPMSampleRequestCalendarAgentShared_INSERT]
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

DECLARE @iPartnerLevel INT
SELECT @iPartnerLevel = TradePartnerLevel FROM uTradePartner tp
		LEFT JOIN uTradePartnerRelationshipType rt ON tp.TradePartnerRelationshipType = rt.TradePartnerRelationshipTypeID 
		WHERE tp.TradePartnerID = @TradePartnerId
		

INSERT INTO dbo.pStyleCalendarTemp(
	CalendarId, PKeyId, CalendarLinkId, 
	CalendarLinkSubId, CalendarDate, CalendarType, 
	CalendarStatus, CalendarDescription, CalendarView, CalendarSN, CalendarSubmit)
SELECT @CalendarId AS CalendarId, dbo.pSampleRequestWorkflow.SampleRequestWorkflowID, dbo.pSampleRequestWorkflow.SampleRequestTradeID, 
    dbo.pSampleWorkflow.SampleWorkflow + N' (' + CAST(dbo.pSampleRequestWorkflow.Submit AS nvarchar(4)) + ') ' AS CalendarLinkSubId, 
    dbo.pSampleRequestWorkflow.DueDate, 'SampleRequest' AS CalendarType, 
	CASE 
		WHEN  dbo.pSampleRequestWorkflow.Submit  > 1 THEN 1
		ELSE 0
	END
	AS Status, 
    '<b>TP: </b>' + SUBSTRING(ISNULL('/' + tprl.AgentCode, '') + ISNULL('/' + tprl.VendorCode,'') + ISNULL ('/' + tprl.FactoryCode, ''), 2, 1000) + ' ' + '<BR>' + sh.StyleNo + ' (' +
    COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription, 0 AS CalendarView , dbo.pSampleRequestWorkflow.StyleSet,
	dbo.pSampleRequestWorkflow.Submit
FROM dbo.pSampleRequestWorkflow WITH (NOLOCK) 
INNER JOIN pSampleRequestShare srs ON srs.SampleRequestTradeID = pSampleRequestWorkflow.SampleRequestTradeID AND srs.TradePartnerID = @TradePartnerId
INNER JOIN dbo.pSampleWorkflow WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID 
INNER JOIN dbo.pStyleHeader sh WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.StyleID = sh.StyleID 
INNER JOIN pSampleRequestTrade srt ON pSampleRequestWorkflow.SampleRequestTradeID = srt.SampleRequestTradeID
INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON srt.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID 
LEFT JOIN uTradePartnerType ON pSampleRequestWorkflow.SampleWorkflowPartnerTypeID = uTradePartnerType.CustomId
LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
WHERE     (dbo.pSampleRequestWorkflow.DueDate BETWEEN @StartDate AND @EndDate) AND 
		dbo.pSampleRequestWorkflow.Status IN (0,1) AND 
		CONVERT(INT, uTradePartnerType.CustomKey) >= @iPartnerLevel
ORDER BY DueDate, StyleNo, pSampleWorkflow.SampleWorkflowID

END 

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09647', GetDate())
GO
