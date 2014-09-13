/****** Object:  StoredProcedure [dbo].[spx_NPMSampleRequestActivityCalendarAgentShared_INSERT]    Script Date: 01/17/2013 16:14:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMSampleRequestActivityCalendarAgentShared_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMSampleRequestActivityCalendarAgentShared_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_NPMSampleRequestActivityCalendarAgentShared_INSERT]    Script Date: 01/17/2013 16:14:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_NPMSampleRequestActivityCalendarAgentShared_INSERT]
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
INSERT INTO pStyleCalendarTemp(
	CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, 
	CalendarDate, CalendarType, CalendarStatus, CalendarDescription, 
	CalendarView, CalendarSN, CalendarSubmit)
SELECT     @CalendarId AS CalendarId, a.SampleRequestWorkflowID, a.SampleRequestTradeID, 
    c.SampleWorkflow + N' (' + CAST(a.Submit AS varchar(4)) + ') ' AS CalendarLinkSubId, 
    d.CDate, 'SampleActivity' AS CalendarType, d.ActivityType, 
    '<b>TP: </b>' + partners.TradePartnerCode + '<BR>' + b.StyleNo + ' (' +
    b.SizeClass + ') ' + b.Description AS CalendarDescription, a.AgentView , a.StyleSet, a.Submit
FROM  pSampleRequestSubmit a WITH (NOLOCK) INNER JOIN pStyleHeader b WITH (NOLOCK) ON a.StyleID = b.StyleID 
	INNER JOIN pSampleWorkflow c WITH (NOLOCK) ON a.SampleWorkflowID = c.SampleWorkflowID 
	INNER JOIN pSampleRequestActivity d WITH (NOLOCK) ON a.SampleRequestSubmitID = d.SampleRequestSubmitID 
	INNER JOIN partners WITH (NOLOCK) ON d.TradePartnerId = partners.TradePartnerID 
	-- INNER JOIN uTradePartnerVendor e WITH (NOLOCK) ON d.TradePartnerVendorId = e.TradePartnerVendorID 
	INNER JOIN pSampleRequestTrade f WITH (NOLOCK) ON a.SampleRequestTradeID = f.SampleRequestTradeID 
	INNER JOIN pSampleRequestWorkflow g WITH (NOLOCK) ON g.SampleRequestWorkflowID = a.SampleRequestWorkflowID
 WHERE     -- (d.TradePartnerId = @TradePartnerId) AND	
		(d.TradePartner = 0)
	AND (d.CDate BETWEEN @StartDate AND @EndDate) 
	AND d.ActivityType IN ( 'R', 'A', 'SD' ) 
	AND f.SampleRequestShare = 1
END




set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04799', GetDate())
GO