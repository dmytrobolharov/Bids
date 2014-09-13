IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMSampleRequestActivityCalendarBOMVendorSubmit_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMSampleRequestActivityCalendarBOMVendorSubmit_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_NPMSampleRequestActivityCalendarBOMVendorSubmit_INSERT]
(@SampleRequestTradeId varchar(50),
@TradePartnerId varchar(50),
@CalendarId varchar(50),
@StartDate datetime,
@EndDate datetime,
@TeamID uniqueidentifier 
)
AS 

BEGIN
	INSERT INTO dbo.pStyleCalendarTemp
		(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
	SELECT @CalendarId AS CalendarId, pSampleRequestSubmit.SampleRequestWorkflowID, pSampleRequestSubmit.SampleRequestTradeId, 
		dbo.pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestSubmit.Submit AS varchar(4)) + ') ' AS CalendarLinkSubId, 
		pSampleRequestActivity.CDate, 'SampleActivity' AS CalendarType,pSampleRequestActivity.ActivityType, 
		'<b>TP: </b>' + dbo.uTradePartner.TradePartnerName + '<BR>' + dbo.pStyleHeader.StyleNo + 
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
	FROM dbo.pSampleRequestSubmitBOM as pSampleRequestSubmit WITH (NOLOCK) INNER JOIN
		dbo.pStyleHeader WITH (NOLOCK) ON pSampleRequestSubmit.StyleID = dbo.pStyleHeader.StyleID INNER JOIN
		dbo.pSampleWorkflow WITH (NOLOCK) ON pSampleRequestSubmit.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID INNER JOIN
		dbo.pSampleRequestBOMActivity as pSampleRequestActivity WITH (NOLOCK) ON 
		pSampleRequestSubmit.SampleRequestSubmitID = pSampleRequestActivity.SampleRequestSubmitID INNER JOIN
		dbo.uTradePartner WITH (NOLOCK) ON pSampleRequestActivity.TradePartnerId = dbo.uTradePartner.TradePartnerID
	WHERE (pSampleRequestActivity.TradePartnerId = @TradePartnerId)  
	AND (pSampleRequestActivity.TradePartner = 0)
	AND  (pSampleRequestActivity.CDate BETWEEN @StartDate AND @EndDate) 
	AND pSampleRequestActivity.ActivityType <> 'V'
	AND pSampleRequestSubmit.SampleRequestTradeId = @SampleRequestTradeId
AND pStyleHeader.StyleType  in  (  SELECT  StyleTypeId from sAccessStyleFolder WITH (NOLOCK) where TeamID = @TeamID  AND ( AccessRoleId =  3 OR AccessView = 1) ) 
	ORDER BY pSampleRequestActivity.Cdate DESC, dbo.pStyleHeader.StyleNo, dbo.pSampleWorkflow.SampleWorkflowID 
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05723', GetDate())
GO
