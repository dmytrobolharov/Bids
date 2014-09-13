-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 8 July 2011                                                                                */
-- *                                                                                            */
-- * Copyright (c) 2002-2011 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_SampleRequestCalendarVendor_INSERT')
   DROP PROCEDURE spx_SampleRequestCalendarVendor_INSERT
GO

CREATE PROCEDURE spx_SampleRequestCalendarVendor_INSERT
(@TeamId varchar(50),
@TradePartnerId varchar(50) = NULL,
@TradePartnerVendorId varchar(50),
@CalendarId varchar(50),
@StartDate datetime,
@EndDate datetime)
AS 

IF @TradePartnerId IS NOT NULL
	BEGIN

		INSERT INTO dbo.pStyleCalendarTemp (CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
		SELECT @CalendarId AS CalendarId, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleRequestTradeId, 
			pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestWorkflow.Submit AS varchar(4)) + ') ' AS CalendarLinkSubId, dbo.pSampleRequestWorkflow.DueDate, 'SampleRequest', pSampleRequestWorkflow.Status, 
			'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + dbo.pStyleHeader.StyleNo + ' (' + dbo.pStyleHeader.SizeClass + ') ' + dbo.pStyleHeader.Description AS CalendarDescription, 0
		FROM dbo.pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
			dbo.pSampleWorkflow WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID INNER JOIN
			dbo.pStyleHeader WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.StyleID = dbo.pStyleHeader.StyleID INNER JOIN
			dbo.uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
			dbo.uTradePartner WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerID = dbo.uTradePartner.TradePartnerID 
		WHERE (dbo.pSampleRequestWorkflow.DueDate BETWEEN @StartDate AND @EndDate) 
			AND (dbo.pSampleRequestWorkflow.Status NOT IN (SELECT StatusID FROM dbo.pSampleRequestSubmitStatus WHERE ApprovedType = 1 OR StatusID = 4)) 
			AND (pSampleRequestWorkflow.TradePartnerID = @TradePartnerId ) 
			AND (pSampleRequestWorkflow.TradePartnerVendorID = @TradePartnerVendorId)
			AND pSampleWorkflow.SampleWorkflowID in ( SELECT SampleTypeId FROM sAccessSampleFolder WITH (NOLOCK) WHERE TeamId = @TeamId AND ( AccessRoleId = 3 OR AccessView = 1) ) 
		ORDER BY dbo.pSampleRequestWorkflow.DueDate, dbo.pStyleHeader.StyleNo, dbo.pSampleWorkflow.SampleWorkflowID	


		INSERT INTO dbo.pStyleCalendarTemp (CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
		SELECT @CalendarId AS CalendarId, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleRequestTradeId, 
			pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestWorkflow.Submit AS varchar(4)) + ') ' AS CalendarLinkSubId, dbo.pSampleRequestWorkflow.DueDate, 'SampleRequest', pSampleRequestWorkflow.Status,  
			'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + dbo.pStyleHeader.StyleNo + ' (' + dbo.pStyleHeader.SizeClass + ') ' + dbo.pStyleHeader.Description AS CalendarDescription, 0
		FROM dbo.pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
			dbo.pSampleWorkflow WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID INNER JOIN
			dbo.pStyleHeader WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.StyleID = dbo.pStyleHeader.StyleID INNER JOIN
			dbo.uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
			dbo.uTradePartner WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerID = dbo.uTradePartner.TradePartnerID 
		WHERE (pSampleRequestWorkflow.EndDate BETWEEN @StartDate AND @EndDate) 
			AND (pSampleRequestWorkflow.Status = 1) 
			AND pSampleRequestWorkflow.TradePartnerID = @TradePartnerId 
			AND pSampleRequestWorkflow.TradePartnerVendorID = @TradePartnerVendorId  
			AND pSampleWorkflow.SampleWorkflowID IN ( SELECT SampleTypeId FROM sAccessSampleFolder WITH (NOLOCK) WHERE TeamId = @TeamId AND ( AccessRoleId = 3 OR AccessView = 1) ) 
		ORDER BY pSampleRequestWorkflow.EndDate, dbo.pStyleHeader.StyleNo, dbo.pSampleWorkflow.SampleWorkflowID

	END
ELSE
	BEGIN

		INSERT INTO dbo.pStyleCalendarTemp (CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
		SELECT @CalendarId AS CalendarId, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleRequestTradeId, 
			pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestWorkflow.Submit AS varchar(4)) + ') ' AS CalendarLinkSubId, dbo.pSampleRequestWorkflow.DueDate, 'SampleRequest', pSampleRequestWorkflow.Status, 
			'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + dbo.pStyleHeader.StyleNo + ' (' + dbo.pStyleHeader.SizeClass + ') ' + dbo.pStyleHeader.Description AS CalendarDescription, 0
		FROM dbo.pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
			dbo.pSampleWorkflow WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID INNER JOIN
			dbo.pStyleHeader WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.StyleID = dbo.pStyleHeader.StyleID INNER JOIN
			dbo.uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
			dbo.uTradePartner WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerID = dbo.uTradePartner.TradePartnerID 
		WHERE (dbo.pSampleRequestWorkflow.DueDate BETWEEN @StartDate AND @EndDate) 
			AND (dbo.pSampleRequestWorkflow.Status NOT IN (SELECT StatusID FROM dbo.pSampleRequestSubmitStatus WHERE ApprovedType = 1 OR StatusID = 4)) 
			AND (pSampleRequestWorkflow.TradePartnerVendorID = @TradePartnerVendorId)
			AND pSampleWorkflow.SampleWorkflowID in ( SELECT SampleTypeId FROM sAccessSampleFolder WITH (NOLOCK) WHERE TeamId = @TeamId AND ( AccessRoleId = 3 OR AccessView = 1) ) 
		ORDER BY dbo.pSampleRequestWorkflow.DueDate, dbo.pStyleHeader.StyleNo, dbo.pSampleWorkflow.SampleWorkflowID	


		INSERT INTO dbo.pStyleCalendarTemp (CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
		SELECT @CalendarId AS CalendarId, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleRequestTradeId, 
			pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestWorkflow.Submit AS varchar(4)) + ') ' AS CalendarLinkSubId, dbo.pSampleRequestWorkflow.DueDate, 'SampleRequest', pSampleRequestWorkflow.Status,  
			'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + dbo.pStyleHeader.StyleNo + ' (' + dbo.pStyleHeader.SizeClass + ') ' + dbo.pStyleHeader.Description AS CalendarDescription, 0
		FROM dbo.pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
			dbo.pSampleWorkflow WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID INNER JOIN
			dbo.pStyleHeader WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.StyleID = dbo.pStyleHeader.StyleID INNER JOIN
			dbo.uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
			dbo.uTradePartner WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerID = dbo.uTradePartner.TradePartnerID 
		WHERE (pSampleRequestWorkflow.EndDate BETWEEN @StartDate AND @EndDate) 
			AND (pSampleRequestWorkflow.Status = 1) 
			AND pSampleRequestWorkflow.TradePartnerVendorID = @TradePartnerVendorId  
			AND pSampleWorkflow.SampleWorkflowID IN ( SELECT SampleTypeId FROM sAccessSampleFolder WITH (NOLOCK) WHERE TeamId = @TeamId AND ( AccessRoleId = 3 OR AccessView = 1) ) 
		ORDER BY pSampleRequestWorkflow.EndDate, dbo.pStyleHeader.StyleNo, dbo.pSampleWorkflow.SampleWorkflowID

	END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '01521', GetDate())
GO
