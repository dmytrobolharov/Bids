IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitColorCalendar_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitColorCalendar_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialRequestSubmitColorCalendar_INSERT]
(	@MaterialTradePartnerColorID nvarchar(50),
	@TradePartnerID nvarchar(50),
	@TradePartnerVendorID nvarchar(50),
	@CalendarId nvarchar(50),
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
	SELECT @CalendarId AS CalendarId, mrs.MaterialRequestSubmitID, sw.MaterialTradePartnerID, 
		rw.MaterialRequestWorkflow + N' (' + CAST(sw.Submit AS nvarchar(4)) + ') ' AS CalendarLinkSubId, 
		sw.DueDate, 'MaterialRequestSubmit' AS Expr1, sw.Status, 
		rw.MaterialRequestWorkflow + N' (' + CAST(sw.Submit AS nvarchar(4)) + ') ' AS CalendarDescription,
		sw.MaterialTradePartnerColorID
	FROM pMaterialRequestSubmitWorkflow sw WITH (NOLOCK) 
		INNER JOIN pMaterialRequestSubmit mrs ON sw.MaterialRequestSubmitWorkflowID = mrs.MaterialRequestSubmitWorkflowID AND sw.Submit = mrs.Submit
		INNER JOIN pMaterialRequestWorkflow rw WITH (NOLOCK) ON sw.MaterialRequestWorkflowID = rw.MaterialRequestWorkflowID 
		INNER JOIN pMaterial WITH (NOLOCK) ON sw.MaterialID = pMaterial.MaterialID
	WHERE sw.DueDate BETWEEN @StartDate AND @EndDate
		AND sw.Status NOT IN (
				SELECT  StatusID FROM pSampleRequestSubmitStatus 
				WHERE (ApprovedType = 1) OR (StatusID = 4))
		AND sw.MaterialTradePartnerColorID = @MaterialTradePartnerColorID
	ORDER BY sw.DueDate, sw.MaterialRequestWorkflowID
END 


set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07988', GetDate())
GO
