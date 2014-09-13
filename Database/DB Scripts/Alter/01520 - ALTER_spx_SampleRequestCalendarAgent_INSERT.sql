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

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_SampleRequestCalendarAgent_INSERT')
   DROP PROCEDURE spx_SampleRequestCalendarAgent_INSERT
GO

CREATE PROCEDURE spx_SampleRequestCalendarAgent_INSERT
(@TeamId varchar(50),
@TradePartnerId varchar(50) = NULL,
@CalendarId varchar(50),
@StartDate datetime,
@EndDate datetime)
AS 

/*Holiday's INSERT SELECT Statement.*/
INSERT INTO pStyleCalendarTemp
	(CalendarID, PKeyID, CalendarLinkID, CalendarLinkSubID, CalendarDate, CalendarType, CalendarStatus, CalendarDescription)
SELECT @CalendarID AS CalendarID, '00000000-0000-0000-0000-000000000000' AS PKeyID, '00000000-0000-0000-0000-000000000000' AS CalendarLinkID, 
	'00000000-0000-0000-0000-000000000000' AS CalendarLinkSubID, CalendarEventDate AS CalendarDate, 'Holiday' AS CalendarType, 0 AS CalendarStatus,
	CalendarEventCountry +  ' - ' + CalendarEventName as CalendarDescription
FROM cCalendarEvent WITH (NOLOCK)

IF @TradePartnerId IS NOT NULL
	BEGIN

		INSERT INTO pStyleCalendarTemp
		  (CalendarId, PKeyId, CalendarLinkId, 
		  CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
		SELECT @CalendarId AS CalendarId, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleRequestTradeID, 
			pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestWorkflow.Submit AS varchar(4)) + ') ' AS CalendarLinkSubId, 
			pSampleRequestWorkflow.DueDate, 'SampleRequest' AS CalendarType, pSampleRequestWorkflow.Status, 
			'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + pStyleHeader.StyleNo + ' (' +
			pStyleHeader.SizeClass + ') ' + pStyleHeader.Description AS CalendarDescription, 0 AS CalendarView
		FROM pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
			pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflow.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID INNER JOIN
			pStyleHeader WITH (NOLOCK) ON pSampleRequestWorkflow.StyleID = pStyleHeader.StyleID INNER JOIN
			uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID INNER JOIN
			uTradePartner WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerID = uTradePartner.TradePartnerID INNER JOIN
			pSampleRequestTrade WITH (NOLOCK) ON pSampleRequestWorkflow.SampleRequestTradeID = pSampleRequestTrade.SampleRequestTradeID
		WHERE (pSampleRequestWorkflow.DueDate BETWEEN @StartDate AND @EndDate) 
		  AND (pSampleRequestWorkflow.Status NOT IN ( SELECT StatusID FROM dbo.pSampleRequestSubmitStatus WHERE ApprovedType = 1 OR StatusID = 4 )) 
		  AND (pSampleRequestWorkflow.TradePartnerID = @TradePartnerId) 
		  -- AND (pSampleRequestWorkflow.SampleWorkflowID IN (SELECT SampleWorkflowId FROM pSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId = @TeamId)) 
		  AND pSampleWorkflow.SampleWorkflowID in ( SELECT SampleTypeId FROM sAccessSampleFolder WITH (NOLOCK) WHERE TeamId = @TeamId AND ( AccessRoleId =  3 OR AccessView = 1) ) 
		ORDER BY pSampleRequestWorkflow.DueDate, pStyleHeader.StyleNo, pSampleWorkflow.SampleWorkflowID	


		INSERT INTO pStyleCalendarTemp
		  (CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
		SELECT @CalendarId AS CalendarId, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleRequestTradeID, 
			pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestWorkflow.Submit AS varchar(4)) + ') ' AS CalendarLinkSubId, 
			pSampleRequestWorkflow.DueDate, 'SampleRequest' AS CalendarType, pSampleRequestWorkflow.Status, 
			'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + pStyleHeader.StyleNo + ' (' +
			pStyleHeader.SizeClass + ') ' + pStyleHeader.Description AS CalendarDescription, 0 AS CalendarView
		FROM pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
			pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflow.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID INNER JOIN
			pStyleHeader WITH (NOLOCK) ON pSampleRequestWorkflow.StyleID = pStyleHeader.StyleID INNER JOIN
			uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID INNER JOIN
			uTradePartner WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerID = uTradePartner.TradePartnerID INNER JOIN
			pSampleRequestTrade WITH (NOLOCK) ON pSampleRequestWorkflow.SampleRequestTradeID = pSampleRequestTrade.SampleRequestTradeID
		WHERE (pSampleRequestWorkflow.Status = 1) 
		  AND (pSampleRequestWorkflow.TradePartnerID = @TradePartnerId) 
		  AND (pSampleRequestWorkflow.EndDate BETWEEN @StartDate AND @EndDate) 
		  -- AND (pSampleRequestWorkflow.SampleWorkflowID IN (SELECT SampleWorkflowId FROM pSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId = @TeamId)) 
		  AND pSampleWorkflow.SampleWorkflowID in ( SELECT SampleTypeId FROM sAccessSampleFolder WITH (NOLOCK) WHERE TeamId = @TeamId AND ( AccessRoleId = 3 OR AccessView = 1) ) 
		ORDER BY pSampleRequestWorkflow.EndDate, pStyleHeader.StyleNo, pSampleWorkflow.SampleWorkflowID

	END
ELSE
	BEGIN

		INSERT INTO pStyleCalendarTemp
		  (CalendarId, PKeyId, CalendarLinkId, 
		  CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
		SELECT @CalendarId AS CalendarId, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleRequestTradeID, 
			pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestWorkflow.Submit AS varchar(4)) + ') ' AS CalendarLinkSubId, 
			pSampleRequestWorkflow.DueDate, 'SampleRequest' AS CalendarType, pSampleRequestWorkflow.Status, 
			'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + pStyleHeader.StyleNo + ' (' +
			pStyleHeader.SizeClass + ') ' + pStyleHeader.Description AS CalendarDescription, 0 AS CalendarView
		FROM pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
			pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflow.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID INNER JOIN
			pStyleHeader WITH (NOLOCK) ON pSampleRequestWorkflow.StyleID = pStyleHeader.StyleID INNER JOIN
			uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID INNER JOIN
			uTradePartner WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerID = uTradePartner.TradePartnerID INNER JOIN
			pSampleRequestTrade WITH (NOLOCK) ON pSampleRequestWorkflow.SampleRequestTradeID = pSampleRequestTrade.SampleRequestTradeID
		WHERE (pSampleRequestWorkflow.DueDate BETWEEN @StartDate AND @EndDate) 
		  AND (pSampleRequestWorkflow.Status NOT IN ( SELECT StatusID FROM dbo.pSampleRequestSubmitStatus WHERE ApprovedType = 1 OR StatusID = 4 )) 
		  -- AND (pSampleRequestWorkflow.SampleWorkflowID IN (SELECT SampleWorkflowId FROM pSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId = @TeamId)) 
		  AND pSampleWorkflow.SampleWorkflowID in ( SELECT SampleTypeId FROM sAccessSampleFolder WITH (NOLOCK) WHERE TeamId = @TeamId AND ( AccessRoleId =  3 OR AccessView = 1) ) 
		ORDER BY pSampleRequestWorkflow.DueDate, pStyleHeader.StyleNo, pSampleWorkflow.SampleWorkflowID	


		INSERT INTO pStyleCalendarTemp
		  (CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
		SELECT @CalendarId AS CalendarId, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleRequestTradeID, 
			pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestWorkflow.Submit AS varchar(4)) + ') ' AS CalendarLinkSubId, 
			pSampleRequestWorkflow.DueDate, 'SampleRequest' AS CalendarType, pSampleRequestWorkflow.Status, 
			'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + pStyleHeader.StyleNo + ' (' +
			pStyleHeader.SizeClass + ') ' + pStyleHeader.Description AS CalendarDescription, 0 AS CalendarView
		FROM pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
			pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflow.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID INNER JOIN
			pStyleHeader WITH (NOLOCK) ON pSampleRequestWorkflow.StyleID = pStyleHeader.StyleID INNER JOIN
			uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID INNER JOIN
			uTradePartner WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerID = uTradePartner.TradePartnerID INNER JOIN
			pSampleRequestTrade WITH (NOLOCK) ON pSampleRequestWorkflow.SampleRequestTradeID = pSampleRequestTrade.SampleRequestTradeID
		WHERE (pSampleRequestWorkflow.Status = 1) 
		  AND (pSampleRequestWorkflow.EndDate BETWEEN @StartDate AND @EndDate) 
		  -- AND (pSampleRequestWorkflow.SampleWorkflowID IN (SELECT SampleWorkflowId FROM pSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId = @TeamId)) 
		  AND pSampleWorkflow.SampleWorkflowID in ( SELECT SampleTypeId FROM sAccessSampleFolder WITH (NOLOCK) WHERE TeamId = @TeamId AND ( AccessRoleId = 3 OR AccessView = 1) ) 
		ORDER BY pSampleRequestWorkflow.EndDate, pStyleHeader.StyleNo, pSampleWorkflow.SampleWorkflowID

	END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '01520', GetDate())
GO
