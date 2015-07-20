IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMSampleRequestBOMCalendarAgentShared_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMSampleRequestBOMCalendarAgentShared_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_NPMSampleRequestBOMCalendarAgentShared_INSERT]
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

DECLARE @iPartnerLevel INT
SELECT @iPartnerLevel = TradePartnerLevel FROM uTradePartner tp
		LEFT JOIN uTradePartnerRelationshipType rt ON tp.TradePartnerRelationshipType = rt.TradePartnerRelationshipTypeID 
		WHERE tp.TradePartnerID = @TradePartnerId


INSERT INTO dbo.pStyleCalendarTemp(
	CalendarId, PKeyId, CalendarLinkId, 
	CalendarLinkSubId, CalendarDate, CalendarType, 
	CalendarStatus, CalendarDescription, CalendarView, CalendarSN, CalendarSubmit)
SELECT @CalendarId AS CalendarId, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleRequestTradeID, 
    dbo.pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestWorkflow.Submit AS varchar(4)) + ') ' AS CalendarLinkSubId, 
    pSampleRequestWorkflow.DueDate, 'SampleRequest' AS CalendarType, 
	CASE 
		WHEN  pSampleRequestWorkflow.Submit  > 1 THEN 1
		ELSE 0
	END
	AS Status, 
    '<b>TP: </b>' + SUBSTRING(ISNULL('/' + tprl.AgentCode, '') + ISNULL('/' + tprl.VendorCode,'') + ISNULL ('/' + tprl.FactoryCode, ''), 2, 1000) + ' ' + '<BR>' + dbo.pStyleHeader.StyleNo + ' (' +
    dbo.pStyleHeader.SizeClass + ') ' + dbo.pStyleHeader.Description AS CalendarDescription, 0 AS CalendarView , pSampleRequestWorkflow.StyleSet,
	pSampleRequestWorkflow.Submit
FROM pSampleRequestWorkflowBOM pSampleRequestWorkflow WITH (NOLOCK) 
INNER JOIN pSampleRequestShare srs ON srs.SampleRequestTradeID = pSampleRequestWorkflow.SampleRequestTradeID AND srs.TradePartnerID = @TradePartnerId
INNER JOIN dbo.pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflow.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID 
INNER JOIN dbo.pStyleHeader WITH (NOLOCK) ON pSampleRequestWorkflow.StyleID = dbo.pStyleHeader.StyleID 
INNER JOIN pSampleRequestBOMTrade srt ON pSampleRequestWorkflow.SampleRequestTradeID = srt.SampleRequestTradeID
INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON srt.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
LEFT JOIN uTradePartnerType ON pSampleRequestWorkflow.SampleWorkflowPartnerTypeID = uTradePartnerType.CustomId
WHERE     (pSampleRequestWorkflow.DueDate BETWEEN @StartDate AND @EndDate) AND 
		pSampleRequestWorkflow.Status IN (0,1) AND
		CONVERT(INT, uTradePartnerType.CustomKey) >= @iPartnerLevel
ORDER BY DueDate, StyleNo, pSampleWorkflow.SampleWorkflowID

END 
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05368', GetDate())
GO
