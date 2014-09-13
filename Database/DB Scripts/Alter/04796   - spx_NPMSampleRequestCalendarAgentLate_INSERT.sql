/****** Object:  StoredProcedure [dbo].[spx_NPMSampleRequestCalendarAgentLate_INSERT]    Script Date: 01/17/2013 14:43:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMSampleRequestCalendarAgentLate_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMSampleRequestCalendarAgentLate_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_NPMSampleRequestCalendarAgentLate_INSERT]    Script Date: 01/17/2013 14:43:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_NPMSampleRequestCalendarAgentLate_INSERT]
(@TradePartnerId varchar(50),
@CalendarId varchar(50),
@StartDate datetime,
@EndDate datetime)
AS 

BEGIN

;WITH partners AS (
	SELECT *, 0 as Level FROM vwx_Sourcing_TradePartner_REL_SEL
	WHERE TradePartnerMasterID IS NULL	
	AND TradePartnerID = @TradePartnerID

	UNION ALL 

	SELECT tp.*, Level + 1 FROM vwx_Sourcing_TradePartner_REL_SEL tp
	INNER JOIN partners p ON p.TradePartnerID = tp.TradePartnerMasterID
	WHERE Level < 3
) 
INSERT INTO dbo.pStyleCalendarTemp(
	CalendarId, PKeyId, CalendarLinkId, 
	CalendarLinkSubId, CalendarDate, CalendarType, 
	CalendarStatus, CalendarDescription , CalendarSN)
SELECT TOP 100 
	@CalendarId AS CalendarId, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleRequestTradeId, 
	pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestWorkflow.Submit AS varchar(4)) + ') ' AS CalendarLinkSubId, dbo.pSampleRequestWorkflow.DueDate, 'SampleRequest', 
	pSampleRequestWorkflow.Status, '<b>TP: </b>' + partners.TradePartnerCode + '<br />' + dbo.pStyleHeader.StyleNo + ' (' + dbo.pStyleHeader.SizeClass + ') ' + dbo.pStyleHeader.Description AS CalendarDescription ,
pSampleRequestWorkflow.StyleSet
FROM pSampleRequestWorkflow WITH (NOLOCK) 
	INNER JOIN pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflow.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID 
	INNER JOIN pStyleHeader WITH (NOLOCK) ON pSampleRequestWorkflow.StyleID = pStyleHeader.StyleID 
	INNER JOIN partners WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerID = partners.TradePartnerID 	
	INNER JOIN pSampleRequestTrade WITH (NOLOCK) ON pSampleRequestWorkflow.SampleRequestTradeID = pSampleRequestTrade.SampleRequestTradeID
WHERE (dbo.pSampleRequestWorkflow.DueDate BETWEEN @StartDate AND @EndDate) AND (dbo.pSampleRequestTrade.SampleRequestShare = 1) 
	AND (dbo.pSampleRequestWorkflow.Status IN (0, 1))
ORDER BY pSampleRequestWorkflow.DueDate, dbo.pStyleHeader.StyleNo, dbo.pSampleWorkflow.SampleWorkflowID	
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04796', GetDate())
GO