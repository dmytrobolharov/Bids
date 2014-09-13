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

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_SampleRequestActivityCalendarVendor_INSERT')
   DROP PROCEDURE spx_SampleRequestActivityCalendarVendor_INSERT
GO

CREATE PROCEDURE spx_SampleRequestActivityCalendarVendor_INSERT
(@TeamId varchar(50),
@TradePartnerId varchar(50) = NULL,
@TradePartnerVendorId varchar(50),
@CalendarId varchar(50),
@StartDate datetime,
@EndDate datetime)
AS 

IF @TradePartnerId IS NOT NULL
	BEGIN

		INSERT INTO pStyleCalendarTemp
			  (CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
		SELECT @CalendarId AS CalendarId, pSampleRequestSubmit.SampleRequestWorkflowID, pSampleRequestSubmit.SampleRequestTradeID, 
			pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestSubmit.Submit AS varchar(4)) + ') ' AS CalendarLinkSubId, 
			pSampleRequestActivity.CDate, 'SampleActivity' AS CalendarType, pSampleRequestActivity.ActivityType, 
			'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + pStyleHeader.StyleNo + ' (' +
			pStyleHeader.SizeClass + ') ' + pStyleHeader.Description AS CalendarDescription, pSampleRequestSubmit.AgentView
		FROM pSampleRequestSubmit WITH (NOLOCK) INNER JOIN
			pStyleHeader WITH (NOLOCK) ON pSampleRequestSubmit.StyleID = pStyleHeader.StyleID INNER JOIN
			pSampleWorkflow WITH (NOLOCK) ON pSampleRequestSubmit.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID INNER JOIN
			pSampleRequestActivity WITH (NOLOCK) ON 
			pSampleRequestSubmit.SampleRequestSubmitID = pSampleRequestActivity.SampleRequestSubmitID INNER JOIN
			uTradePartner WITH (NOLOCK) ON pSampleRequestActivity.TradePartnerId = uTradePartner.TradePartnerID INNER JOIN
			uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestActivity.TradePartnerVendorId = uTradePartnerVendor.TradePartnerVendorID INNER JOIN
			pSampleRequestTrade WITH (NOLOCK) ON pSampleRequestSubmit.SampleRequestTradeID = pSampleRequestTrade.SampleRequestTradeID 
		WHERE (pSampleRequestActivity.TradePartnerId = @TradePartnerId)
			AND (pSampleRequestActivity.TradePartnerVendorId = @TradePartnerVendorId)    
			AND (pSampleRequestActivity.TradePartner = 0)
			AND (pSampleRequestActivity.CDate BETWEEN @StartDate AND @EndDate) 
			AND (pSampleRequestActivity.ActivityType NOT IN ('V','U')) 
			-- AND (pSampleRequestSubmit.SampleWorkflowID IN (SELECT SampleWorkflowId FROM pSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId = @TeamId)) 
			AND pSampleWorkflow.SampleWorkflowID in  (  SELECT  SampleTypeId from sAccessSampleFolder WITH (NOLOCK) where TeamId = @TeamId  AND ( AccessRoleId =  3 OR AccessView = 1) ) 
		ORDER BY  pSampleRequestActivity.Cdate DESC, pStyleHeader.StyleNo, pSampleWorkflow.SampleWorkflowID

	END
ELSE
	BEGIN

		INSERT INTO pStyleCalendarTemp
			  (CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
		SELECT @CalendarId AS CalendarId, pSampleRequestSubmit.SampleRequestWorkflowID, pSampleRequestSubmit.SampleRequestTradeID, 
			pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestSubmit.Submit AS varchar(4)) + ') ' AS CalendarLinkSubId, 
			pSampleRequestActivity.CDate, 'SampleActivity' AS CalendarType, pSampleRequestActivity.ActivityType, 
			'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + pStyleHeader.StyleNo + ' (' +
			pStyleHeader.SizeClass + ') ' + pStyleHeader.Description AS CalendarDescription, pSampleRequestSubmit.AgentView
		FROM pSampleRequestSubmit WITH (NOLOCK) INNER JOIN
			pStyleHeader WITH (NOLOCK) ON pSampleRequestSubmit.StyleID = pStyleHeader.StyleID INNER JOIN
			pSampleWorkflow WITH (NOLOCK) ON pSampleRequestSubmit.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID INNER JOIN
			pSampleRequestActivity WITH (NOLOCK) ON 
			pSampleRequestSubmit.SampleRequestSubmitID = pSampleRequestActivity.SampleRequestSubmitID INNER JOIN
			uTradePartner WITH (NOLOCK) ON pSampleRequestActivity.TradePartnerId = uTradePartner.TradePartnerID INNER JOIN
			uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestActivity.TradePartnerVendorId = uTradePartnerVendor.TradePartnerVendorID INNER JOIN
			pSampleRequestTrade WITH (NOLOCK) ON pSampleRequestSubmit.SampleRequestTradeID = pSampleRequestTrade.SampleRequestTradeID 
		WHERE (pSampleRequestActivity.TradePartnerVendorId = @TradePartnerVendorId) 
			AND (pSampleRequestActivity.TradePartner = 0)
			AND (pSampleRequestActivity.CDate BETWEEN @StartDate AND @EndDate) 
			AND (pSampleRequestActivity.ActivityType NOT IN ('V','U')) 
			-- AND (pSampleRequestSubmit.SampleWorkflowID IN (SELECT SampleWorkflowId FROM pSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId = @TeamId)) 
			AND pSampleWorkflow.SampleWorkflowID in  (  SELECT  SampleTypeId from sAccessSampleFolder WITH (NOLOCK) where TeamId = @TeamId  AND ( AccessRoleId =  3 OR AccessView = 1) ) 
		ORDER BY  pSampleRequestActivity.Cdate DESC, pStyleHeader.StyleNo, pSampleWorkflow.SampleWorkflowID

	END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '01523', GetDate())
GO
