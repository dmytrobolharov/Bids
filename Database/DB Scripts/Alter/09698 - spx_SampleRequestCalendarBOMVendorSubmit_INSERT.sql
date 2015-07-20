IF OBJECT_ID(N'[dbo].[spx_SampleRequestCalendarBOMVendorSubmit_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_SampleRequestCalendarBOMVendorSubmit_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestCalendarBOMVendorSubmit_INSERT]
(@SampleRequestTradeId nvarchar(50),
@TradePartnerId nvarchar(50),
@TradePartnerVendorId nvarchar(50),
@CalendarId nvarchar(50),
@StartDate datetime,
@EndDate datetime,
@TeamID uniqueidentifier = NULL 
)
AS 

BEGIN

	INSERT INTO dbo.pStyleCalendarTemp
	(CalendarId, PKeyId, CalendarLinkId, 
	CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
	SELECT @CalendarId AS CalendarId, pSampleRequestWorkflow.SampleRequestWorkflowID, 
	pSampleRequestWorkflow.SampleRequestTradeId, 
	pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestWorkflow.Submit AS nvarchar(4)) + ') ' AS CalendarLinkSubId, 
	pSampleRequestWorkflow.DueDate, 'SampleRequest', 
	CASE 
		WHEN pSampleRequestWorkflow.Submit = 1 THEN 0
		ELSE  1
	END AS Status, 
		'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + sh.StyleNo +  
		case pSampleRequestWorkflow.StyleSet
			when 1 then 
				CASE 
					WHEN len (sh.Pc1) = 0 THEN ' / 1st '
					WHEN len (sh.Pc1) IS NULL THEN ' / 1st '
					ELSE ' / ' + sh.Pc1
				END 
			when 2 then 
				CASE 
					WHEN len (sh.Pc2) = 0 THEN ' / 2nd '
					WHEN len (sh.Pc2) IS NULL THEN ' / 2nd '
					ELSE ' / ' + sh.Pc2
				END 
			when 3 then 
				CASE 
					WHEN len (sh.Pc3) = 0 THEN ' / 3rd '
					WHEN len (sh.Pc3) IS NULL THEN ' / 3rd '
					ELSE ' / ' + sh.Pc3
				END 
			when 4 then 
				CASE 
					WHEN len (sh.Pc4) = 0 THEN ' / 4th '
					WHEN len (sh.Pc4) IS NULL THEN ' / 4th '
					ELSE ' / ' + sh.Pc4
				END 
		end
		+  ' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription, 0
	FROM         dbo.pSampleRequestWorkflowBOM  pSampleRequestWorkflow  WITH (NOLOCK) INNER JOIN
		dbo.pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflow.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID INNER JOIN
		dbo.pStyleHeader sh WITH (NOLOCK) ON pSampleRequestWorkflow.StyleID = sh.StyleID INNER JOIN
		dbo.uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
		dbo.uTradePartner WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerID = dbo.uTradePartner.TradePartnerID INNER JOIN 
		fnx_Permissions_GetIntProductTypePermissions(@TeamID, 2) access ON access.ProductTypeId = sh.StyleType
		LEFT JOIN pSizeClass sc ON sc.CustomId = sh.SizeClassId
	WHERE  
		(pSampleRequestWorkflow.DueDate BETWEEN @StartDate AND @EndDate) 
		AND	( pSampleRequestWorkflow.Status NOT IN (SELECT StatusID FROM dbo.pSampleRequestSubmitStatus WHERE ApprovedType = 1 OR StatusID = 4)
		) 
		AND pSampleRequestWorkflow.TradePartnerID = @TradePartnerId 
		AND pSampleRequestWorkflow.TradePartnerVendorID = @TradePartnerVendorId 
		AND	pSampleRequestWorkflow.SampleRequestTradeId = @SampleRequestTradeId 
		AND (access.PermissionRoleId = 3 OR access.PermissionView = 1)
	ORDER BY pSampleRequestWorkflow.DueDate, sh.StyleNo, dbo.pSampleWorkflow.SampleWorkflowID	

END 


BEGIN

	INSERT INTO dbo.pStyleCalendarTemp
	(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
	SELECT @CalendarId AS CalendarId, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleRequestTradeId, 
	pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestWorkflow.Submit AS nvarchar(4)) + ') ' AS CalendarLinkSubId, pSampleRequestWorkflow.DueDate, 'SampleRequest', pSampleRequestWorkflow.Status,  
		'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + sh.StyleNo + 
		case pSampleRequestWorkflow.StyleSet
			when 1 then 
				CASE 
					WHEN len (sh.Pc1) = 0 THEN ' / 1st '
					WHEN len (sh.Pc1) IS NULL THEN ' / 1st '
					ELSE ' / ' + sh.Pc1
				END 
			when 2 then 
				CASE 
					WHEN len (sh.Pc2) = 0 THEN ' / 2nd '
					WHEN len (sh.Pc2) IS NULL THEN ' / 2nd '
					ELSE ' / ' + sh.Pc2
				END 
			when 3 then 
				CASE 
					WHEN len (sh.Pc3) = 0 THEN ' / 3rd '
					WHEN len (sh.Pc3) IS NULL THEN ' / 3rd '
					ELSE ' / ' + sh.Pc3
				END 
			when 4 then 
				CASE 
					WHEN len (sh.Pc4) = 0 THEN ' / 4th '
					WHEN len (sh.Pc4) IS NULL THEN ' / 4th '
					ELSE ' / ' + sh.Pc4
				END 
		end
		+ ' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription, 0
	FROM         dbo.pSampleRequestWorkflowBOM pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
		dbo.pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflow.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID INNER JOIN
		dbo.pStyleHeader sh WITH (NOLOCK) ON pSampleRequestWorkflow.StyleID = sh.StyleID INNER JOIN
		dbo.uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerVendorID = dbo.uTradePartnerVendor.TradePartnerVendorID INNER JOIN
		dbo.uTradePartner WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerID = dbo.uTradePartner.TradePartnerID INNER JOIN
		fnx_Permissions_GetIntProductTypePermissions(@TeamID, 2) access ON access.ProductTypeId = sh.StyleType
		LEFT JOIN pSizeClass sc ON sc.CustomId = sh.SizeClassId
	WHERE  
		(pSampleRequestWorkflow.EndDate BETWEEN @StartDate AND @EndDate) AND (pSampleRequestWorkflow.Status = 1) AND 
		pSampleRequestWorkflow.TradePartnerID = @TradePartnerId AND pSampleRequestWorkflow.TradePartnerVendorID = @TradePartnerVendorId AND
		pSampleRequestWorkflow.SampleRequestTradeId = @SampleRequestTradeId 
		AND( access.PermissionRoleId =  3 OR access.PermissionView = 1) 
	ORDER BY pSampleRequestWorkflow.EndDate, sh.StyleNo, dbo.pSampleWorkflow.SampleWorkflowID

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09698', GetDate())
GO
