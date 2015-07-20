IF OBJECT_ID(N'[dbo].[spx_SampleRequestCalendarVendor_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_SampleRequestCalendarVendor_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestCalendarVendor_INSERT]
(@TeamId nvarchar(50),
@TradePartnerId nvarchar(50) = NULL,
@TradePartnerVendorId nvarchar(50),
@CalendarId nvarchar(50),
@StartDate datetime,
@EndDate datetime)
AS 

IF @TradePartnerId IS NOT NULL
	BEGIN

		INSERT INTO dbo.pStyleCalendarTemp (CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
		SELECT @CalendarId AS CalendarId, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleRequestTradeId, 
			pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestWorkflow.Submit AS nvarchar(4)) + ') ' AS CalendarLinkSubId, dbo.pSampleRequestWorkflow.DueDate, 'SampleRequest', pSampleRequestWorkflow.Status, 
			'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + sh.StyleNo + 
			' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription, 0
		FROM dbo.pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
			dbo.pSampleWorkflow WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID INNER JOIN
			dbo.pStyleHeader sh WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.StyleID = sh.StyleID INNER JOIN
			dbo.uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
			dbo.uTradePartner WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerID = dbo.uTradePartner.TradePartnerID INNER JOIN
			fnx_Permissions_GetIntProductType_WorkflowPermissions(@TeamID, 5, NULL) access ON access.WorkflowId = pSampleWorkflow.SampleWorkflowGUID AND sh.StyleType = access.ProductTypeID
			LEFT JOIN pSizeClass sc ON sc.CustomId = sh.SizeClassId
		WHERE (dbo.pSampleRequestWorkflow.DueDate BETWEEN @StartDate AND @EndDate) 
			AND (dbo.pSampleRequestWorkflow.Status NOT IN (SELECT StatusID FROM dbo.pSampleRequestSubmitStatus WHERE ApprovedType = 1 OR StatusID = 4)) 
			AND (pSampleRequestWorkflow.TradePartnerID = @TradePartnerId ) 
			AND (pSampleRequestWorkflow.TradePartnerVendorID = @TradePartnerVendorId)
			AND (access.PermissionRoleId <> 0)
		ORDER BY dbo.pSampleRequestWorkflow.DueDate, sh.StyleNo, dbo.pSampleWorkflow.SampleWorkflowID	


		INSERT INTO dbo.pStyleCalendarTemp (CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
		SELECT @CalendarId AS CalendarId, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleRequestTradeId, 
			pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestWorkflow.Submit AS nvarchar(4)) + ') ' AS CalendarLinkSubId, dbo.pSampleRequestWorkflow.DueDate, 'SampleRequest', pSampleRequestWorkflow.Status,  
			'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + sh.StyleNo + 
			' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription, 0
		FROM dbo.pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
			dbo.pSampleWorkflow WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID INNER JOIN
			dbo.pStyleHeader sh WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.StyleID = sh.StyleID INNER JOIN
			dbo.uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
			dbo.uTradePartner WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerID = dbo.uTradePartner.TradePartnerID  INNER JOIN
			fnx_Permissions_GetIntProductType_WorkflowPermissions(@TeamID, 5, NULL) access ON access.WorkflowId = pSampleWorkflow.SampleWorkflowGUID AND sh.StyleType = access.ProductTypeID
			LEFT JOIN pSizeClass sc ON sc.CustomId = sh.SizeClassId
		WHERE (pSampleRequestWorkflow.EndDate BETWEEN @StartDate AND @EndDate) 
			AND (pSampleRequestWorkflow.Status = 1) 
			AND pSampleRequestWorkflow.TradePartnerID = @TradePartnerId 
			AND pSampleRequestWorkflow.TradePartnerVendorID = @TradePartnerVendorId  
			AND (access.PermissionRoleId <> 0)
		ORDER BY pSampleRequestWorkflow.EndDate, sh.StyleNo, dbo.pSampleWorkflow.SampleWorkflowID

	END
ELSE
	BEGIN

		INSERT INTO dbo.pStyleCalendarTemp (CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
		SELECT @CalendarId AS CalendarId, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleRequestTradeId, 
			pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestWorkflow.Submit AS nvarchar(4)) + ') ' AS CalendarLinkSubId, dbo.pSampleRequestWorkflow.DueDate, 'SampleRequest', pSampleRequestWorkflow.Status, 
			'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + sh.StyleNo + 
			' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription, 0
		FROM dbo.pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
			dbo.pSampleWorkflow WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID INNER JOIN
			dbo.pStyleHeader sh WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.StyleID = sh.StyleID INNER JOIN
			dbo.uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
			dbo.uTradePartner WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerID = dbo.uTradePartner.TradePartnerID INNER JOIN
			fnx_Permissions_GetIntProductType_WorkflowPermissions(@TeamID, 5, NULL) access ON access.WorkflowId = pSampleWorkflow.SampleWorkflowGUID AND sh.StyleType = access.ProductTypeID
			LEFT JOIN pSizeClass sc ON sc.CustomId = sh.SizeClassId
		WHERE (dbo.pSampleRequestWorkflow.DueDate BETWEEN @StartDate AND @EndDate) 
			AND (dbo.pSampleRequestWorkflow.Status NOT IN (SELECT StatusID FROM dbo.pSampleRequestSubmitStatus WHERE ApprovedType = 1 OR StatusID = 4)) 
			AND (pSampleRequestWorkflow.TradePartnerVendorID = @TradePartnerVendorId)
			AND (access.PermissionRoleId <> 0)
		ORDER BY dbo.pSampleRequestWorkflow.DueDate, sh.StyleNo, dbo.pSampleWorkflow.SampleWorkflowID	


		INSERT INTO dbo.pStyleCalendarTemp (CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
		SELECT @CalendarId AS CalendarId, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleRequestTradeId, 
			pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestWorkflow.Submit AS nvarchar(4)) + ') ' AS CalendarLinkSubId, dbo.pSampleRequestWorkflow.DueDate, 'SampleRequest', pSampleRequestWorkflow.Status,  
			'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + sh.StyleNo + 
			' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription, 0
		FROM dbo.pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
			dbo.pSampleWorkflow WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID INNER JOIN
			dbo.pStyleHeader sh WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.StyleID = sh.StyleID INNER JOIN
			dbo.uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
			dbo.uTradePartner WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerID = dbo.uTradePartner.TradePartnerID INNER JOIN
			fnx_Permissions_GetIntProductType_WorkflowPermissions(@TeamID, 5, NULL) access ON access.WorkflowId = pSampleWorkflow.SampleWorkflowGUID AND sh.StyleType = access.ProductTypeID
			LEFT JOIN pSizeClass sc ON sc.CustomId = sh.SizeClassId
		WHERE (pSampleRequestWorkflow.EndDate BETWEEN @StartDate AND @EndDate) 
			AND (pSampleRequestWorkflow.Status = 1) 
			AND pSampleRequestWorkflow.TradePartnerVendorID = @TradePartnerVendorId  
			AND (access.PermissionRoleId <> 0)
		ORDER BY pSampleRequestWorkflow.EndDate, sh.StyleNo, dbo.pSampleWorkflow.SampleWorkflowID

	END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09701', GetDate())
GO
