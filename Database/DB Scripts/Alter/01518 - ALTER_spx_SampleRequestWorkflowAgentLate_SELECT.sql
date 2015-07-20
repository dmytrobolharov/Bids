-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 7 July 2011                                                                                */
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

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_SampleRequestWorkflowAgentLate_SELECT')
   DROP PROCEDURE spx_SampleRequestWorkflowAgentLate_SELECT
GO

CREATE PROCEDURE spx_SampleRequestWorkflowAgentLate_SELECT
(@SampleWorkflowId varchar(5),
@TradePartnerID uniqueidentifier = NULL)
AS 

IF @TradepartnerID IS NOT NULL
	BEGIN
		SELECT dbo.pSampleRequestWorkflow.SampleRequestWorkflowID, dbo.pSampleRequestWorkflow.SampleWorkflowID, 
			dbo.pSampleRequestWorkflow.SampleRequestTradeID, dbo.pSampleRequestWorkflow.TradePartnerVendorID, dbo.pSampleRequestWorkflow.StyleID, 
			dbo.pSampleRequestWorkflow.StyleColorID, dbo.pSampleRequestWorkflow.StyleSet, dbo.pSampleRequestWorkflow.Status, 
			dbo.pSampleRequestWorkflow.Submit, dbo.pSampleRequestWorkflow.TechPackID, dbo.pSampleRequestWorkflow.StartDate, 
			dbo.pSampleRequestWorkflow.DueDate, dbo.pSampleRequestWorkflow.EndDate, dbo.pSampleWorkflow.SampleWorkflow, 
			dbo.pSampleWorkflow.SampleWorkflowSort, dbo.pSampleWorkflow.GroupName, dbo.pSampleRequestWorkflow.AssignedTo, dbo.Users.FirstName, 
			dbo.Users.LastName, dbo.pStyleHeader.StyleNo, 
			dbo.pSampleWorkflow.SampleWorkflow + N' (' + CAST(dbo.pSampleRequestWorkflow.Submit AS varchar(4)) + ') ' AS LateHeader, 
			'<b>A: </b>' + dbo.uTradePartner.TradePartnerCode + ' / <b>V: </b>' + dbo.uTradePartnerVendor.VendorCode + '<BR>' + dbo.pStyleHeader.StyleNo + ' (' +
			dbo.pStyleHeader.SizeClass + ') ' + dbo.pStyleHeader.Description AS LateDescription
		FROM dbo.pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
			dbo.pSampleWorkflow WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID INNER JOIN
			dbo.pStyleHeader WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.StyleID = dbo.pStyleHeader.StyleID INNER JOIN
			dbo.uTradePartner WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.TradePartnerID = dbo.uTradePartner.TradePartnerID INNER JOIN
			dbo.uTradePartnerVendor WITH (NOLOCK) ON 
			dbo.pSampleRequestWorkflow.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID LEFT OUTER JOIN
			dbo.Users WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.AssignedTo = dbo.Users.UserId
		WHERE (dbo.pSampleRequestWorkflow.DueDate <= GETDATE()) 
			AND (dbo.pSampleRequestWorkflow.Status NOT IN (2, 3, 4)) 
			AND (dbo.pSampleRequestWorkflow.TradePartnerID = @TradePartnerID) 
			AND (dbo.pSampleWorkflow.SampleWorkflowID = @SampleWorkflowId)
		ORDER BY dbo.pSampleRequestWorkflow.DueDate, dbo.pStyleHeader.StyleNo
	END
ELSE
	BEGIN
		SELECT dbo.pSampleRequestWorkflow.SampleRequestWorkflowID, dbo.pSampleRequestWorkflow.SampleWorkflowID, 
			dbo.pSampleRequestWorkflow.SampleRequestTradeID, dbo.pSampleRequestWorkflow.TradePartnerVendorID, dbo.pSampleRequestWorkflow.StyleID, 
			dbo.pSampleRequestWorkflow.StyleColorID, dbo.pSampleRequestWorkflow.StyleSet, dbo.pSampleRequestWorkflow.Status, 
			dbo.pSampleRequestWorkflow.Submit, dbo.pSampleRequestWorkflow.TechPackID, dbo.pSampleRequestWorkflow.StartDate, 
			dbo.pSampleRequestWorkflow.DueDate, dbo.pSampleRequestWorkflow.EndDate, dbo.pSampleWorkflow.SampleWorkflow, 
			dbo.pSampleWorkflow.SampleWorkflowSort, dbo.pSampleWorkflow.GroupName, dbo.pSampleRequestWorkflow.AssignedTo, dbo.Users.FirstName, 
			dbo.Users.LastName, dbo.pStyleHeader.StyleNo, 
			dbo.pSampleWorkflow.SampleWorkflow + N' (' + CAST(dbo.pSampleRequestWorkflow.Submit AS varchar(4)) + ') ' AS LateHeader, 
			'<b>A: </b>' + dbo.uTradePartner.TradePartnerCode + ' / <b>V: </b>' + dbo.uTradePartnerVendor.VendorCode + '<BR>' + dbo.pStyleHeader.StyleNo + ' (' +
			dbo.pStyleHeader.SizeClass + ') ' + dbo.pStyleHeader.Description AS LateDescription
		FROM dbo.pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
			dbo.pSampleWorkflow WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID INNER JOIN
			dbo.pStyleHeader WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.StyleID = dbo.pStyleHeader.StyleID INNER JOIN
			dbo.uTradePartner WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.TradePartnerID = dbo.uTradePartner.TradePartnerID INNER JOIN
			dbo.uTradePartnerVendor WITH (NOLOCK) ON 
			dbo.pSampleRequestWorkflow.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID LEFT OUTER JOIN
			dbo.Users WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.AssignedTo = dbo.Users.UserId
		WHERE (dbo.pSampleRequestWorkflow.DueDate <= GETDATE()) 
			AND (dbo.pSampleRequestWorkflow.Status NOT IN (2, 3, 4)) 
			AND (dbo.pSampleWorkflow.SampleWorkflowID = @SampleWorkflowId)
		ORDER BY dbo.pSampleRequestWorkflow.DueDate, dbo.pStyleHeader.StyleNo
	END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '01518', GetDate())
GO
