
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 23 Dec 2011                                                                               */
-- * WorkItem #5307                                                                             */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMCalendarAgentShared_INSERT]    Script Date: 12/23/2011 00:11:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMCalendarAgentShared_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMCalendarAgentShared_INSERT]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMCalendarAgentShared_INSERT]    Script Date: 12/23/2011 00:11:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestBOMCalendarAgentShared_INSERT]
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
        '<b>A: </b>' + dbo.uTradePartner.TradePartnerCode + ' / <b>V: </b>' + dbo.uTradePartnerVendor.VendorCode + '<BR>' + dbo.pStyleHeader.StyleNo + ' (' +
        dbo.pStyleHeader.SizeClass + ') ' + dbo.pStyleHeader.Description AS CalendarDescription, 0 AS CalendarView ,pSampleRequestWorkflow.StyleSet,
		pSampleRequestWorkflow.Submit,pSampleRequestWorkflow.StyleID 
FROM         pSampleRequestWorkflowBOM pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
        dbo.pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflow.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID INNER JOIN
        dbo.pStyleHeader WITH (NOLOCK) ON pSampleRequestWorkflow.StyleID = dbo.pStyleHeader.StyleID INNER JOIN
        dbo.uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
        dbo.uTradePartner WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerID = dbo.uTradePartner.TradePartnerID INNER JOIN
        dbo.pSampleRequestBOMTrade WITH (NOLOCK) ON pSampleRequestWorkflow.SampleRequestTradeID = pSampleRequestBOMTrade.SampleRequestTradeID
WHERE     (pSampleRequestWorkflow.DueDate BETWEEN @StartDate AND @EndDate) AND 
		pSampleRequestWorkflow.Status IN (0,1) AND 
        (pSampleRequestWorkflow.TradePartnerID = @TradePartnerId) AND (pSampleRequestBOMTrade.SampleRequestShare = 1)
ORDER BY pSampleRequestWorkflow.DueDate, dbo.pStyleHeader.StyleNo, dbo.pSampleWorkflow.SampleWorkflowID	

END 






set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON




GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02513'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02513', GetDate())
END

GO

