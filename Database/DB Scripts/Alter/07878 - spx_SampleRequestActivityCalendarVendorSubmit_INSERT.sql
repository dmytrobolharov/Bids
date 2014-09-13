/****** Object:  StoredProcedure [dbo].[spx_SampleRequestActivityCalendarVendorSubmit_INSERT]    Script Date: 06/04/2014 12:53:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestActivityCalendarVendorSubmit_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestActivityCalendarVendorSubmit_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestActivityCalendarVendorSubmit_INSERT]    Script Date: 06/04/2014 12:53:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestActivityCalendarVendorSubmit_INSERT]
(@SampleRequestTradeId nvarchar(50),
@TradePartnerId nvarchar(50),
@TradePartnerVendorId nvarchar(50),
@CalendarId nvarchar(50),
@StartDate datetime,
@EndDate datetime,
@TeamID uniqueidentifier 
)
AS 



BEGIN
	INSERT INTO dbo.pStyleCalendarTemp
		(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
	SELECT @CalendarId AS CalendarId, pSampleRequestSubmit.SampleRequestWorkflowID, pSampleRequestSubmit.SampleRequestTradeId, 
		dbo.pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestSubmit.Submit AS nvarchar(4)) + ') ' AS CalendarLinkSubId, 
		dbo.pSampleRequestActivity.CDate, 'SampleActivity' AS CalendarType, dbo.pSampleRequestActivity.ActivityType, 
		'<b>A: </b>' + dbo.uTradePartner.TradePartnerCode + ' / <b>V: </b>' + dbo.uTradePartnerVendor.VendorCode + '<BR>' + dbo.pStyleHeader.StyleNo + 
		case pSampleRequestSubmit.StyleSet
			when 1 then 
				CASE 
					WHEN len (pStyleHeader.Pc1) = 0 THEN ' / 1st '
					WHEN len (pStyleHeader.Pc1) IS NULL THEN ' / 1st '
					ELSE ' / ' + pStyleHeader.Pc1
				END 
			when 2 then 
				CASE 
					WHEN len (pStyleHeader.Pc2) = 0 THEN ' / 2nd '
					WHEN len (pStyleHeader.Pc2) IS NULL THEN ' / 2nd '
					ELSE ' / ' + pStyleHeader.Pc2
				END 
			when 3 then 
				CASE 
					WHEN len (pStyleHeader.Pc3) = 0 THEN ' / 3rd '
					WHEN len (pStyleHeader.Pc3) IS NULL THEN ' / 3rd '
					ELSE ' / ' + pStyleHeader.Pc3
				END 
			when 4 then 
				CASE 
					WHEN len (pStyleHeader.Pc4) = 0 THEN ' / 4th '
					WHEN len (pStyleHeader.Pc4) IS NULL THEN ' / 4thd '
					ELSE ' / ' + pStyleHeader.Pc4
				END 
		end
		+  ' (' +
		dbo.pStyleHeader.SizeClass + ') ' + dbo.pStyleHeader.Description AS CalendarDescription, pSampleRequestSubmit.AgentView 
	FROM dbo.pSampleRequestSubmit WITH (NOLOCK) INNER JOIN
		dbo.pStyleHeader WITH (NOLOCK) ON dbo.pSampleRequestSubmit.StyleID = dbo.pStyleHeader.StyleID INNER JOIN
		dbo.pSampleWorkflow WITH (NOLOCK) ON dbo.pSampleRequestSubmit.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID INNER JOIN
		dbo.pSampleRequestActivity WITH (NOLOCK) ON 
		dbo.pSampleRequestSubmit.SampleRequestSubmitID = dbo.pSampleRequestActivity.SampleRequestSubmitID INNER JOIN
		dbo.uTradePartner WITH (NOLOCK) ON dbo.pSampleRequestActivity.TradePartnerId = dbo.uTradePartner.TradePartnerID INNER JOIN
		dbo.uTradePartnerVendor WITH (NOLOCK) ON dbo.pSampleRequestActivity.TradePartnerVendorId = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
		fnx_Permissions_GetIntProductTypePermissions(@TeamID, 2) access ON access.ProductTypeId = pStyleHeader.StyleType
	WHERE (dbo.pSampleRequestActivity.TradePartnerId = @TradePartnerId)
	AND (pSampleRequestActivity.TradePartnerVendorId = @TradePartnerVendorId)   
	AND (dbo.pSampleRequestActivity.TradePartner = 0)
	AND  (dbo.pSampleRequestActivity.CDate BETWEEN @StartDate AND @EndDate) 
	AND pSampleRequestActivity.ActivityType <> 'V'
	AND pSampleRequestSubmit.SampleRequestTradeId = @SampleRequestTradeId
	AND ( access.PermissionRoleId =  3 OR access.PermissionView = 1)
	ORDER BY pSampleRequestActivity.Cdate DESC, dbo.pStyleHeader.StyleNo, dbo.pSampleWorkflow.SampleWorkflowID 
END





set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07878', GetDate())
GO