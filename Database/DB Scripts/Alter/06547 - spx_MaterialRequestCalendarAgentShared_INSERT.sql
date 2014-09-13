IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestCalendarAgentShared_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestCalendarAgentShared_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_MaterialRequestCalendarAgentShared_INSERT]
(@TradePartnerId nvarchar(50),
@CalendarId nvarchar(50),
@StartDate datetime,
@EndDate datetime)
AS 

/*
@SubmitStatusId
Open =				0
Resubmit =			1
Apv w/ Correction = 2
Approved =			3
Dropped =			4
*/


BEGIN


INSERT INTO dbo.pStyleCalendarTemp(
	CalendarId, PKeyId, CalendarLinkId, 
	CalendarLinkSubId, CalendarDate, CalendarType, 
	CalendarStatus, CalendarDescription, CalendarView, CalendarSN, CalendarSubmit)
SELECT @CalendarId AS CalendarId, pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID, pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID, 
    pMaterialRequestWorkflow.MaterialRequestWorkflow + N' (' + CAST(pMaterialRequestSubmitWorkflow.Submit AS nvarchar(4)) + ') ' AS CalendarLinkSubId, 
    pMaterialRequestSubmitWorkflow.DueDate, 'MaterialRequest' AS CalendarType, 
	CASE 
		WHEN  pMaterialRequestSubmitWorkflow.Submit  > 1 THEN 1
		ELSE 0
	END
	AS Status, 
    '<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + ISNULL(pMaterial.MaterialNo,'') +
    + ' ' + ISNULL(pMaterial.MaterialName,'') AS CalendarDescription, 0 AS CalendarView, pMaterialRequestSubmitWorkflow.Submit,
    1
FROM pMaterialTradePartnerColor
	INNER JOIN pMaterialTradePartner ON pMaterialTradePartnerColor.MaterialTradePartnerID = pMaterialTradePartner.MaterialTradePartnerId	
	INNER JOIN uTradePartnerVendor ON pMaterialTradePartner.TradepartnerVendorId = uTradePartnerVendor.TradePartnerVendorID
	INNER JOIN uTradePartner ON pMaterialTradePartner.TradepartnerId = uTradePartner.TradePartnerID
	INNER JOIN pMaterialRequestWorkflow
	INNER JOIN pMaterialRequestSubmitWorkflow ON pMaterialRequestWorkflow.MaterialRequestWorkflowID = pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID
	ON pMaterialTradePartnerColor.MaterialTradePartnerColorID = pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID
	INNER JOIN pMaterial WITH (NOLOCK) ON pMaterialTradePartner.MaterialId = pMaterial.MaterialID
WHERE (pMaterialRequestSubmitWorkflow.DueDate BETWEEN @StartDate AND @EndDate) AND 
		pMaterialRequestSubmitWorkflow.Status IN (0,1) AND
		pMaterialTradePartnerColor.MaterialRequestShare = 1 AND 
		pMaterialTradePartner.TradepartnerId = @TradePartnerID 
ORDER BY pMaterialRequestSubmitWorkflow.DueDate, MaterialNo, pMaterialRequestWorkflow.MaterialRequestWorkflowID
		

END 

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06547', GetDate())
GO
