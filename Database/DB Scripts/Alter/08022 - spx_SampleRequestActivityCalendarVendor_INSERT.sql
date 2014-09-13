/****** Object:  StoredProcedure [dbo].[spx_SampleRequestActivityCalendarVendor_INSERT]    Script Date: 06/17/2014 14:03:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestActivityCalendarVendor_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestActivityCalendarVendor_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestActivityCalendarVendor_INSERT]    Script Date: 06/17/2014 14:03:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_SampleRequestActivityCalendarVendor_INSERT]
(@TeamId nvarchar(50),
@TradePartnerId nvarchar(50) = NULL,
@TradePartnerVendorId nvarchar(50),
@CalendarId nvarchar(50),
@StartDate datetime,
@EndDate datetime)
AS 

IF @TradePartnerId IS NOT NULL
	BEGIN

		INSERT INTO pStyleCalendarTemp
			  (CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
		SELECT @CalendarId AS CalendarId, pSampleRequestSubmit.SampleRequestWorkflowID, pSampleRequestSubmit.SampleRequestTradeID, 
			pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestSubmit.Submit AS nvarchar(4)) + ') ' AS CalendarLinkSubId, 
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
			pSampleRequestTrade WITH (NOLOCK) ON pSampleRequestSubmit.SampleRequestTradeID = pSampleRequestTrade.SampleRequestTradeID INNER JOIN 
			fnx_Permissions_GetIntProductType_WorkflowPermissions(@TeamID, 5, NULL) access ON access.WorkflowId = pSampleWorkflow.SampleWorkflowGUID AND access.ProductTypeID = pStyleHeader.StyleType
		WHERE (pSampleRequestActivity.TradePartnerId = @TradePartnerId)
			AND (pSampleRequestActivity.TradePartnerVendorId = @TradePartnerVendorId)    
			AND (pSampleRequestActivity.TradePartner = 0)
			AND (pSampleRequestActivity.CDate BETWEEN @StartDate AND @EndDate) 
			AND (pSampleRequestActivity.ActivityType NOT IN ('V','U')) 
			AND (PermissionRoleId = 3 OR PermissionView = 1)
		ORDER BY  pSampleRequestActivity.Cdate DESC, pStyleHeader.StyleNo, pSampleWorkflow.SampleWorkflowID

	END
ELSE
	BEGIN

		INSERT INTO pStyleCalendarTemp
			  (CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
		SELECT @CalendarId AS CalendarId, pSampleRequestSubmit.SampleRequestWorkflowID, pSampleRequestSubmit.SampleRequestTradeID, 
			pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestSubmit.Submit AS nvarchar(4)) + ') ' AS CalendarLinkSubId, 
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
			pSampleRequestTrade WITH (NOLOCK) ON pSampleRequestSubmit.SampleRequestTradeID = pSampleRequestTrade.SampleRequestTradeID INNER JOIN 
			fnx_Permissions_GetIntProductType_WorkflowPermissions(@TeamID, 5, NULL) access ON access.WorkflowId = pSampleWorkflow.SampleWorkflowGUID AND access.ProductTypeID = pStyleHeader.StyleType
		WHERE (pSampleRequestActivity.TradePartnerVendorId = @TradePartnerVendorId) 
			AND (pSampleRequestActivity.TradePartner = 0)
			AND (pSampleRequestActivity.CDate BETWEEN @StartDate AND @EndDate) 
			AND (pSampleRequestActivity.ActivityType NOT IN ('V','U')) 
			AND (PermissionRoleId = 3 OR PermissionView = 1)
		ORDER BY  pSampleRequestActivity.Cdate DESC, pStyleHeader.StyleNo, pSampleWorkflow.SampleWorkflowID

	END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08022', GetDate())
GO
