
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
/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMCalendarAgentLate_INSERT]    Script Date: 12/23/2011 00:07:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMCalendarAgentLate_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMCalendarAgentLate_INSERT]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMCalendarAgentLate_INSERT]    Script Date: 12/23/2011 00:07:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleRequestBOMCalendarAgentLate_INSERT]
(
	@TradePartnerId VARCHAR(50),
	@CalendarId VARCHAR(50),
	@StartDate DATETIME,
	@EndDate DATETIME
)
AS 
BEGIN
	INSERT INTO dbo.pStyleCalendarTemp
	(
		CalendarId, PKeyId, CalendarLinkId, 
		CalendarLinkSubId, CalendarDate, CalendarType, 
		CalendarStatus, CalendarDescription, CalendarSN 
	)
	SELECT TOP 100 
		@CalendarId AS CalendarId, pSampleRequestWorkflowBOM.SampleRequestWorkflowID, pSampleRequestWorkflowBOM.SampleRequestTradeId, 
		pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestWorkflowBOM.Submit AS varchar(4)) + ') ' AS CalendarLinkSubId, 
		dbo.pSampleRequestWorkflowBOM.DueDate, 'SampleRequest', pSampleRequestWorkflowBOM.Status, 
		'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + dbo.pStyleHeader.StyleNo + ' (' + dbo.pStyleHeader.SizeClass + ') ' + dbo.pStyleHeader.Description AS CalendarDescription ,
		pSampleRequestWorkflowBOM.StyleSet
	FROM         
		pSampleRequestWorkflowBOM WITH (NOLOCK) 
			INNER JOIN pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflowBOM.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID 
			INNER JOIN pStyleHeader WITH (NOLOCK) ON pSampleRequestWorkflowBOM.StyleID = pStyleHeader.StyleID 
			INNER JOIN uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestWorkflowBOM.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID 
			INNER JOIN uTradePartner WITH (NOLOCK) ON pSampleRequestWorkflowBOM.TradePartnerID = uTradePartner.TradePartnerID 
			INNER JOIN pSampleRequestBOMTrade WITH (NOLOCK) ON pSampleRequestWorkflowBOM.SampleRequestTradeID = pSampleRequestBOMTrade.SampleRequestTradeID
	WHERE     
		(dbo.pSampleRequestWorkflowBOM.DueDate BETWEEN @StartDate AND @EndDate) 
		AND (dbo.pSampleRequestBOMTrade.SampleRequestShare = 1) 
		AND (dbo.pSampleRequestWorkflowBOM.Status IN (0, 1)) 
		AND pSampleRequestWorkflowBOM.TradePartnerID = @TradePartnerId 
	ORDER BY 
		pSampleRequestWorkflowBOM.DueDate, dbo.pStyleHeader.StyleNo, 
		dbo.pSampleWorkflow.SampleWorkflowID	
END



GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02504'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02504', GetDate())
END

GO

