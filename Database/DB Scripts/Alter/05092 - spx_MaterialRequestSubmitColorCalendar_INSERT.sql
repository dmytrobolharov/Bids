/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitColorCalendar_INSERT]    Script Date: 02/21/2013 16:39:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitColorCalendar_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitColorCalendar_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitColorCalendar_INSERT]    Script Date: 02/21/2013 16:39:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_MaterialRequestSubmitColorCalendar_INSERT]
(	@MaterialTradePartnerColorID varchar(50),
	@TradePartnerID varchar(50),
	@TradePartnerVendorID varchar(50),
	@CalendarId varchar(50),
	@StartDate datetime,
	@EndDate datetime)
AS 

BEGIN
	
	INSERT INTO pStyleCalendarTemp(
		CalendarId, PKeyId, CalendarLinkId, 
		CalendarLinkSubId, 
		CalendarDate, CalendarType, CalendarStatus, 
		CalendarDescription, 
		CalendarLinkSubId1)
	SELECT @CalendarId AS CalendarId, sw.MaterialRequestWorkflowID, sw.MaterialTradePartnerID, 
		rw.MaterialRequestWorkflow + N' (' + CAST(sw.Submit AS varchar(4)) + ') ' AS CalendarLinkSubId, 
		sw.DueDate, 'SampleRequest' AS Expr1, sw.Status, 
		rw.MaterialRequestWorkflow + N' (' + CAST(sw.Submit AS varchar(4)) + ') ' AS CalendarDescription,
		sw.MaterialTradePartnerColorID
	FROM pMaterialRequestSubmitWorkflow sw WITH (NOLOCK) 
		INNER JOIN pMaterialRequestWorkflow rw WITH (NOLOCK) ON sw.MaterialRequestWorkflowID = rw.MaterialRequestWorkflowID 
		INNER JOIN pMaterial WITH (NOLOCK) ON sw.MaterialID = pMaterial.MaterialID
	WHERE sw.DueDate BETWEEN @StartDate AND @EndDate
		AND sw.Status NOT IN (
				SELECT  StatusID FROM pSampleRequestSubmitStatus 
				WHERE (ApprovedType = 1) OR (StatusID = 4))
		AND sw.MaterialTradePartnerColorID = @MaterialTradePartnerColorID
	ORDER BY sw.DueDate, sw.MaterialRequestWorkflowID
END 


--BEGIN

--INSERT INTO pStyleCalendarTemp
--	(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription)
--SELECT @CalendarId AS CalendarId, pSampleRequestWorkflow.SampleRequestWorkflowID, pSampleRequestWorkflow.SampleRequestTradeId, 
--pSampleWorkflow.SampleWorkflow + N' (' + CAST(pSampleRequestWorkflow.Submit AS varchar(4)) + ') ' AS CalendarLinkSubId, pSampleRequestWorkflow.DueDate, pSampleWorkflow.SampleWorkflow, pSampleRequestWorkflow.Status, 
--    '<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + pStyleHeader.StyleNo + ' (' + pStyleHeader.SizeClass + ') ' + pStyleHeader.Description AS CalendarDescription
--FROM pSampleRequestWorkflow WITH (NOLOCK) INNER JOIN
--    pSampleWorkflow WITH (NOLOCK) ON pSampleRequestWorkflow.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID INNER JOIN
--    pStyleHeader WITH (NOLOCK) ON pSampleRequestWorkflow.StyleID = pStyleHeader.StyleID INNER JOIN
--    uTradePartnerVendor WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID INNER JOIN
--	uTradePartner WITH (NOLOCK) ON pSampleRequestWorkflow.TradePartnerID = uTradePartner.TradePartnerID 
--WHERE     (pSampleRequestWorkflow.EndDate BETWEEN @StartDate AND @EndDate) AND (pSampleRequestWorkflow.Status = 1) AND 
--	 pSampleRequestWorkflow.SampleRequestTradeID = @SampleRequestTradeID
--ORDER BY pSampleRequestWorkflow.EndDate, pStyleHeader.StyleNo, pSampleWorkflow.SampleWorkflowID

--END 





set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05092', GetDate())
GO
