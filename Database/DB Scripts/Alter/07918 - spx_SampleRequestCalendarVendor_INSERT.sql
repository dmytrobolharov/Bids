/****** Object:  StoredProcedure [dbo].[spx_SampleRequestCalendarVendor_INSERT]    Script Date: 06/05/2014 15:33:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestCalendarVendor_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestCalendarVendor_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestCalendarVendor_INSERT]    Script Date: 06/05/2014 15:33:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
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
			'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + dbo.pStyleHeader.StyleNo + ' (' + dbo.pStyleHeader.SizeClass + ') ' + dbo.pStyleHeader.Description AS CalendarDescription, 0
		FROM dbo.pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
			dbo.pSampleWorkflow WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID INNER JOIN
			dbo.pStyleHeader WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.StyleID = dbo.pStyleHeader.StyleID INNER JOIN
			dbo.uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
			dbo.uTradePartner WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerID = dbo.uTradePartner.TradePartnerID INNER JOIN
			fnx_Permissions_GetStringProductTypePermissions(@TeamID, 5) access ON access.ProductTypeId = pSampleWorkflow.SampleWorkflowID 
		WHERE (dbo.pSampleRequestWorkflow.DueDate BETWEEN @StartDate AND @EndDate) 
			AND (dbo.pSampleRequestWorkflow.Status NOT IN (SELECT StatusID FROM dbo.pSampleRequestSubmitStatus WHERE ApprovedType = 1 OR StatusID = 4)) 
			AND (pSampleRequestWorkflow.TradePartnerID = @TradePartnerId ) 
			AND (pSampleRequestWorkflow.TradePartnerVendorID = @TradePartnerVendorId)
			AND (access.PermissionRoleId <> 0)
		ORDER BY dbo.pSampleRequestWorkflow.DueDate, dbo.pStyleHeader.StyleNo, dbo.pSampleWorkflow.SampleWorkflowID	


		INSERT INTO dbo.pStyleCalendarTemp (CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
		SELECT @CalendarId AS CalendarId, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleRequestTradeId, 
			pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestWorkflow.Submit AS nvarchar(4)) + ') ' AS CalendarLinkSubId, dbo.pSampleRequestWorkflow.DueDate, 'SampleRequest', pSampleRequestWorkflow.Status,  
			'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + dbo.pStyleHeader.StyleNo + ' (' + dbo.pStyleHeader.SizeClass + ') ' + dbo.pStyleHeader.Description AS CalendarDescription, 0
		FROM dbo.pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
			dbo.pSampleWorkflow WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID INNER JOIN
			dbo.pStyleHeader WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.StyleID = dbo.pStyleHeader.StyleID INNER JOIN
			dbo.uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
			dbo.uTradePartner WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerID = dbo.uTradePartner.TradePartnerID  INNER JOIN
			fnx_Permissions_GetStringProductTypePermissions(@TeamID, 5) access ON access.ProductTypeId = pSampleWorkflow.SampleWorkflowID 
		WHERE (pSampleRequestWorkflow.EndDate BETWEEN @StartDate AND @EndDate) 
			AND (pSampleRequestWorkflow.Status = 1) 
			AND pSampleRequestWorkflow.TradePartnerID = @TradePartnerId 
			AND pSampleRequestWorkflow.TradePartnerVendorID = @TradePartnerVendorId  
			AND (access.PermissionRoleId <> 0)
		ORDER BY pSampleRequestWorkflow.EndDate, dbo.pStyleHeader.StyleNo, dbo.pSampleWorkflow.SampleWorkflowID

	END
ELSE
	BEGIN

		INSERT INTO dbo.pStyleCalendarTemp (CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
		SELECT @CalendarId AS CalendarId, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleRequestTradeId, 
			pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestWorkflow.Submit AS nvarchar(4)) + ') ' AS CalendarLinkSubId, dbo.pSampleRequestWorkflow.DueDate, 'SampleRequest', pSampleRequestWorkflow.Status, 
			'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + dbo.pStyleHeader.StyleNo + ' (' + dbo.pStyleHeader.SizeClass + ') ' + dbo.pStyleHeader.Description AS CalendarDescription, 0
		FROM dbo.pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
			dbo.pSampleWorkflow WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID INNER JOIN
			dbo.pStyleHeader WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.StyleID = dbo.pStyleHeader.StyleID INNER JOIN
			dbo.uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
			dbo.uTradePartner WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerID = dbo.uTradePartner.TradePartnerID INNER JOIN
			fnx_Permissions_GetStringProductTypePermissions(@TeamID, 5) access ON access.ProductTypeId = pSampleWorkflow.SampleWorkflowID 
		WHERE (dbo.pSampleRequestWorkflow.DueDate BETWEEN @StartDate AND @EndDate) 
			AND (dbo.pSampleRequestWorkflow.Status NOT IN (SELECT StatusID FROM dbo.pSampleRequestSubmitStatus WHERE ApprovedType = 1 OR StatusID = 4)) 
			AND (pSampleRequestWorkflow.TradePartnerVendorID = @TradePartnerVendorId)
			AND (access.PermissionRoleId <> 0)
		ORDER BY dbo.pSampleRequestWorkflow.DueDate, dbo.pStyleHeader.StyleNo, dbo.pSampleWorkflow.SampleWorkflowID	


		INSERT INTO dbo.pStyleCalendarTemp (CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
		SELECT @CalendarId AS CalendarId, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleRequestTradeId, 
			pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestWorkflow.Submit AS nvarchar(4)) + ') ' AS CalendarLinkSubId, dbo.pSampleRequestWorkflow.DueDate, 'SampleRequest', pSampleRequestWorkflow.Status,  
			'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + dbo.pStyleHeader.StyleNo + ' (' + dbo.pStyleHeader.SizeClass + ') ' + dbo.pStyleHeader.Description AS CalendarDescription, 0
		FROM dbo.pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
			dbo.pSampleWorkflow WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID INNER JOIN
			dbo.pStyleHeader WITH (NOLOCK) ON dbo.pSampleRequestWorkflow.StyleID = dbo.pStyleHeader.StyleID INNER JOIN
			dbo.uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
			dbo.uTradePartner WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerID = dbo.uTradePartner.TradePartnerID INNER JOIN
			fnx_Permissions_GetStringProductTypePermissions(@TeamID, 5) access ON access.ProductTypeId = pSampleWorkflow.SampleWorkflowID 
		WHERE (pSampleRequestWorkflow.EndDate BETWEEN @StartDate AND @EndDate) 
			AND (pSampleRequestWorkflow.Status = 1) 
			AND pSampleRequestWorkflow.TradePartnerVendorID = @TradePartnerVendorId  
			AND (access.PermissionRoleId <> 0)
		ORDER BY pSampleRequestWorkflow.EndDate, dbo.pStyleHeader.StyleNo, dbo.pSampleWorkflow.SampleWorkflowID

	END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07918', GetDate())
GO