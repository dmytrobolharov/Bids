
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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMActivityCalendarAgentShared_INSERT]    Script Date: 12/23/2011 00:10:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMActivityCalendarAgentShared_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMActivityCalendarAgentShared_INSERT]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMActivityCalendarAgentShared_INSERT]    Script Date: 12/23/2011 00:10:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestBOMActivityCalendarAgentShared_INSERT]
(@TradePartnerId varchar(50),
@CalendarId varchar(50),
@StartDate datetime,
@EndDate datetime)
AS 

BEGIN
INSERT INTO pStyleCalendarTemp
      (CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, 
	CalendarView, CalendarSN, CalendarSubmit,StyleID )
SELECT     @CalendarId AS CalendarId, a.SampleRequestWorkflowID, a.SampleRequestTradeID, 
    c.SampleWorkflow + N' (' + CAST(a.Submit AS varchar(4)) + ') ' AS CalendarLinkSubId, 
    d.CDate, 'SampleActivity' AS CalendarType, d.ActivityType, 
    '<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + e.VendorCode + '<BR>' + b.StyleNo + ' (' +
    b.SizeClass + ') ' + b.Description AS CalendarDescription, a.AgentView , a.StyleSet, a.Submit,a.StyleID
FROM  pSampleRequestSubmitBOM a WITH (NOLOCK) INNER JOIN pStyleHeader b WITH (NOLOCK) ON a.StyleID = b.StyleID 
	INNER JOIN pSampleWorkflow c WITH (NOLOCK) ON a.SampleWorkflowID = c.SampleWorkflowID 
	INNER JOIN pSampleRequestBOMActivity d WITH (NOLOCK) ON a.SampleRequestSubmitID = d.SampleRequestSubmitID 
	INNER JOIN uTradePartner WITH (NOLOCK) ON d.TradePartnerId = uTradePartner.TradePartnerID 
	INNER JOIN uTradePartnerVendor e WITH (NOLOCK) ON d.TradePartnerVendorId = e.TradePartnerVendorID 
	INNER JOIN pSampleRequestBOMTrade f WITH (NOLOCK) ON a.SampleRequestTradeID = f.SampleRequestTradeID 
	INNER JOIN pSampleRequestWorkflowBOM g WITH (NOLOCK) ON g.SampleRequestWorkflowID = a.SampleRequestWorkflowID
 WHERE     (d.TradePartnerId = @TradePartnerId) 
	AND (d.TradePartner = 0)
	AND (d.CDate BETWEEN @StartDate AND @EndDate) 
	AND d.ActivityType IN ( 'R', 'A', 'SD' ) 
	AND f.SampleRequestShare = 1
END




set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON




GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02512'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02512', GetDate())
END

GO

