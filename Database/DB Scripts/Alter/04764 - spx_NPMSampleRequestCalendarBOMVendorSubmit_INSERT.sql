/****** Object:  StoredProcedure [dbo].[spx_NPMSampleRequestCalendarBOMVendorSubmit_INSERT]    Script Date: 01/15/2013 17:13:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMSampleRequestCalendarBOMVendorSubmit_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMSampleRequestCalendarBOMVendorSubmit_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_NPMSampleRequestCalendarBOMVendorSubmit_INSERT]    Script Date: 01/15/2013 17:13:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_NPMSampleRequestCalendarBOMVendorSubmit_INSERT]
(@SampleRequestTradeId varchar(50),
@TradePartnerId varchar(50),
@CalendarId varchar(50),
@StartDate datetime,
@EndDate datetime,
@TeamID uniqueidentifier = NULL 
)
AS 

BEGIN

	INSERT INTO dbo.pStyleCalendarTemp
	(CalendarId, PKeyId, CalendarLinkId, 
	CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
	SELECT @CalendarId AS CalendarId, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleRequestTradeId, 
	pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestWorkflow.Submit AS varchar(4)) + ') ' AS CalendarLinkSubId, pSampleRequestWorkflow.DueDate, 'SampleRequest', 
	CASE 
		WHEN pSampleRequestWorkflow.Submit = 1 THEN 0
		ELSE  1
	END AS Status, 
		'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartner.TradePartnerName + '<BR>' + dbo.pStyleHeader.StyleNo +  
		case pSampleRequestWorkflow.StyleSet
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
					WHEN len (pStyleHeader.Pc4) IS NULL THEN ' / 4th '
					ELSE ' / ' + pStyleHeader.Pc4
				END 
		end
		+  ' (' + dbo.pStyleHeader.SizeClass + ') ' + dbo.pStyleHeader.Description AS CalendarDescription, 0
	FROM         dbo.pSampleRequestWorkflowBOM  pSampleRequestWorkflow  WITH (NOLOCK) INNER JOIN
		dbo.pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflow.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID INNER JOIN
		dbo.pStyleHeader WITH (NOLOCK) ON pSampleRequestWorkflow.StyleID = dbo.pStyleHeader.StyleID INNER JOIN
		dbo.uTradePartner WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerID = dbo.uTradePartner.TradePartnerID 
	WHERE  
		(pSampleRequestWorkflow.DueDate BETWEEN @StartDate AND @EndDate) 
		AND	( pSampleRequestWorkflow.Status NOT IN (SELECT StatusID FROM dbo.pSampleRequestSubmitStatus WHERE ApprovedType = 1 OR StatusID = 4)
		) 
		AND pSampleRequestWorkflow.TradePartnerID = @TradePartnerId
		AND	pSampleRequestWorkflow.SampleRequestTradeId = @SampleRequestTradeId 
		AND pStyleHeader.StyleType  in  (  SELECT  StyleTypeId from sAccessStyleFolder WITH (NOLOCK) where TeamID = @TeamID  AND ( AccessRoleId =  3 OR AccessView = 1) ) 
	ORDER BY pSampleRequestWorkflow.DueDate, dbo.pStyleHeader.StyleNo, dbo.pSampleWorkflow.SampleWorkflowID	

END 


BEGIN

	INSERT INTO dbo.pStyleCalendarTemp
	(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
	SELECT @CalendarId AS CalendarId, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleRequestTradeId, 
	pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestWorkflow.Submit AS varchar(4)) + ') ' AS CalendarLinkSubId, pSampleRequestWorkflow.DueDate, 'SampleRequest', pSampleRequestWorkflow.Status,  
		'<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartner.TradePartnerName + '<BR>' + dbo.pStyleHeader.StyleNo + 
		case pSampleRequestWorkflow.StyleSet
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
					WHEN len (pStyleHeader.Pc4) IS NULL THEN ' / 4th '
					ELSE ' / ' + pStyleHeader.Pc4
				END 
		end
		+ ' (' + dbo.pStyleHeader.SizeClass + ') ' + dbo.pStyleHeader.Description AS CalendarDescription, 0
	FROM         dbo.pSampleRequestWorkflowBOM pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
		dbo.pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflow.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID INNER JOIN
		dbo.pStyleHeader WITH (NOLOCK) ON pSampleRequestWorkflow.StyleID = dbo.pStyleHeader.StyleID INNER JOIN
		dbo.uTradePartner WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerID = dbo.uTradePartner.TradePartnerID 
	WHERE  
		(pSampleRequestWorkflow.EndDate BETWEEN @StartDate AND @EndDate) AND (pSampleRequestWorkflow.Status = 1) AND 
		pSampleRequestWorkflow.TradePartnerID = @TradePartnerId AND
		pSampleRequestWorkflow.SampleRequestTradeId = @SampleRequestTradeId 
		AND pStyleHeader.StyleType  in  (  SELECT  StyleTypeId from sAccessStyleFolder WITH (NOLOCK) where TeamID = @TeamID  AND ( AccessRoleId =  3 OR AccessView = 1) ) 
	ORDER BY pSampleRequestWorkflow.EndDate, dbo.pStyleHeader.StyleNo, dbo.pSampleWorkflow.SampleWorkflowID

END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04764', GetDate())
GO

