/****** Object:  StoredProcedure [dbo].[spx_NPMSampleRequestBOMCalendarAgentShared_INSERT]    Script Date: 01/17/2013 14:58:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMSampleRequestBOMCalendarAgentShared_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMSampleRequestBOMCalendarAgentShared_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_NPMSampleRequestBOMCalendarAgentShared_INSERT]    Script Date: 01/17/2013 14:58:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
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

;WITH partners AS (
	SELECT *, 0 as Level FROM vwx_Sourcing_TradePartner_REL_SEL
	WHERE TradePartnerMasterID IS NULL	
	AND TradePartnerID = @TradePartnerID

	UNION ALL 

	SELECT tp.*, Level + 1 FROM vwx_Sourcing_TradePartner_REL_SEL tp
	INNER JOIN partners p ON p.TradePartnerID = tp.TradePartnerMasterID
	WHERE Level < 3
) 
INSERT INTO dbo.pStyleCalendarTemp
  (CalendarId, PKeyId, CalendarLinkId, 
  CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView, CalendarSN, CalendarSubmit,StyleID )
SELECT     @CalendarId AS CalendarId, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleRequestTradeID, 
        dbo.pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestWorkflow.Submit AS varchar(4)) + ') ' AS CalendarLinkSubId, 
        pSampleRequestWorkflow.DueDate, 'SampleRequest' AS CalendarType, 
		CASE 
			WHEN  pSampleRequestWorkflow.Submit  > 1 THEN 1
			ELSE 0
		END
		AS Status, 
        '<b>TP: </b>' + partners.TradePartnerCode + ' ' + '<BR>' + dbo.pStyleHeader.StyleNo + ' (' +
        dbo.pStyleHeader.SizeClass + ') ' + dbo.pStyleHeader.Description AS CalendarDescription, 0 AS CalendarView ,pSampleRequestWorkflow.StyleSet,
		pSampleRequestWorkflow.Submit,pSampleRequestWorkflow.StyleID 
FROM         pSampleRequestWorkflowBOM pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
        dbo.pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflow.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID INNER JOIN
        dbo.pStyleHeader WITH (NOLOCK) ON pSampleRequestWorkflow.StyleID = dbo.pStyleHeader.StyleID INNER JOIN        
        partners WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerID = partners.TradePartnerID INNER JOIN
        dbo.pSampleRequestBOMTrade WITH (NOLOCK) ON pSampleRequestWorkflow.SampleRequestTradeID = pSampleRequestBOMTrade.SampleRequestTradeID
WHERE     (pSampleRequestWorkflow.DueDate BETWEEN @StartDate AND @EndDate) AND 
		pSampleRequestWorkflow.Status IN (0,1) AND 
        --(pSampleRequestWorkflow.TradePartnerID = @TradePartnerId) AND 
        (pSampleRequestBOMTrade.SampleRequestShare = 1)
ORDER BY pSampleRequestWorkflow.DueDate, dbo.pStyleHeader.StyleNo, dbo.pSampleWorkflow.SampleWorkflowID	

END 






set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON






GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04798', GetDate())
GO