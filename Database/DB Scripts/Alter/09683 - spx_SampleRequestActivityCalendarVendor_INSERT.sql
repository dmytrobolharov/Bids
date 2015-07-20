IF OBJECT_ID(N'[dbo].[spx_SampleRequestActivityCalendarVendor_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_SampleRequestActivityCalendarVendor_INSERT]
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
			'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + sh.StyleNo + ' (' +
			COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription, pSampleRequestSubmit.AgentView
		FROM pSampleRequestSubmit WITH (NOLOCK) INNER JOIN
			pStyleHeader sh WITH (NOLOCK) ON pSampleRequestSubmit.StyleID = sh.StyleID INNER JOIN
			pSampleWorkflow WITH (NOLOCK) ON pSampleRequestSubmit.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID INNER JOIN
			pSampleRequestActivity WITH (NOLOCK) ON 
			pSampleRequestSubmit.SampleRequestSubmitID = pSampleRequestActivity.SampleRequestSubmitID INNER JOIN
			uTradePartner WITH (NOLOCK) ON pSampleRequestActivity.TradePartnerId = uTradePartner.TradePartnerID INNER JOIN
			uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestActivity.TradePartnerVendorId = uTradePartnerVendor.TradePartnerVendorID INNER JOIN
			pSampleRequestTrade WITH (NOLOCK) ON pSampleRequestSubmit.SampleRequestTradeID = pSampleRequestTrade.SampleRequestTradeID INNER JOIN 
			fnx_Permissions_GetIntProductType_WorkflowPermissions(@TeamID, 5, NULL) access ON access.WorkflowId = pSampleWorkflow.SampleWorkflowGUID AND access.ProductTypeID = sh.StyleType
			LEFT JOIN pSizeClass sc ON sc.CustomId = sh.SizeClassId
		WHERE (pSampleRequestActivity.TradePartnerId = @TradePartnerId)
			AND (pSampleRequestActivity.TradePartnerVendorId = @TradePartnerVendorId)    
			AND (pSampleRequestActivity.TradePartner = 0)
			AND (pSampleRequestActivity.CDate BETWEEN @StartDate AND @EndDate) 
			AND (pSampleRequestActivity.ActivityType NOT IN ('V','U')) 
			AND (PermissionRoleId = 3 OR PermissionView = 1)
		ORDER BY  pSampleRequestActivity.Cdate DESC, sh.StyleNo, pSampleWorkflow.SampleWorkflowID

	END
ELSE
	BEGIN

		INSERT INTO pStyleCalendarTemp
			  (CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
		SELECT @CalendarId AS CalendarId, pSampleRequestSubmit.SampleRequestWorkflowID, pSampleRequestSubmit.SampleRequestTradeID, 
			pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestSubmit.Submit AS nvarchar(4)) + ') ' AS CalendarLinkSubId, 
			pSampleRequestActivity.CDate, 'SampleActivity' AS CalendarType, pSampleRequestActivity.ActivityType, 
			'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + sh.StyleNo + ' (' +
			COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription, pSampleRequestSubmit.AgentView
		FROM pSampleRequestSubmit WITH (NOLOCK) INNER JOIN
			pStyleHeader sh WITH (NOLOCK) ON pSampleRequestSubmit.StyleID = sh.StyleID INNER JOIN
			pSampleWorkflow WITH (NOLOCK) ON pSampleRequestSubmit.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID INNER JOIN
			pSampleRequestActivity WITH (NOLOCK) ON 
			pSampleRequestSubmit.SampleRequestSubmitID = pSampleRequestActivity.SampleRequestSubmitID INNER JOIN
			uTradePartner WITH (NOLOCK) ON pSampleRequestActivity.TradePartnerId = uTradePartner.TradePartnerID INNER JOIN
			uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestActivity.TradePartnerVendorId = uTradePartnerVendor.TradePartnerVendorID INNER JOIN
			pSampleRequestTrade WITH (NOLOCK) ON pSampleRequestSubmit.SampleRequestTradeID = pSampleRequestTrade.SampleRequestTradeID INNER JOIN 
			fnx_Permissions_GetIntProductType_WorkflowPermissions(@TeamID, 5, NULL) access ON access.WorkflowId = pSampleWorkflow.SampleWorkflowGUID AND access.ProductTypeID = sh.StyleType
			LEFT JOIN pSizeClass sc ON sc.CustomId = sh.SizeClassId
		WHERE (pSampleRequestActivity.TradePartnerVendorId = @TradePartnerVendorId) 
			AND (pSampleRequestActivity.TradePartner = 0)
			AND (pSampleRequestActivity.CDate BETWEEN @StartDate AND @EndDate) 
			AND (pSampleRequestActivity.ActivityType NOT IN ('V','U')) 
			AND (PermissionRoleId = 3 OR PermissionView = 1)
		ORDER BY  pSampleRequestActivity.Cdate DESC, sh.StyleNo, pSampleWorkflow.SampleWorkflowID

	END



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09683', GetDate())
GO
