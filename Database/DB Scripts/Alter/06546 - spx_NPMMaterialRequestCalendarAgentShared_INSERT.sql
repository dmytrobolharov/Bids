IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMMaterialRequestCalendarAgentShared_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMMaterialRequestCalendarAgentShared_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_NPMMaterialRequestCalendarAgentShared_INSERT]
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

DECLARE @iPartnerLevel INT
SELECT @iPartnerLevel = TradePartnerLevel FROM uTradePartner tp
		LEFT JOIN uTradePartnerRelationshipType rt ON tp.TradePartnerRelationshipType = rt.TradePartnerRelationshipTypeID 
		WHERE tp.TradePartnerID = @TradePartnerId
		

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
    '<b>TP: </b>' + SUBSTRING(ISNULL('/' + tprl.AgentCode, '') + ISNULL('/' + tprl.VendorCode,'') + ISNULL ('/' + tprl.FactoryCode, ''), 2, 1000) + ' ' + '<BR>' + ISNULL(pMaterial.MaterialNo,'') + 
    + ' ' + ISNULL(pMaterial.MaterialName,'') AS CalendarDescription, 0 AS CalendarView, pMaterialRequestSubmitWorkflow.Submit,
    1
FROM pMaterialTradePartnerColor
	INNER JOIN pMaterialTradePartner ON pMaterialTradePartnerColor.MaterialTradePartnerID = pMaterialTradePartner.MaterialTradePartnerId	
	INNER JOIN pMaterialRequestWorkflow
	INNER JOIN pMaterialRequestSubmitWorkflow ON pMaterialRequestWorkflow.MaterialRequestWorkflowID = pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID
	ON pMaterialTradePartnerColor.MaterialTradePartnerColorID = pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID
	INNER JOIN pMaterial WITH (NOLOCK) ON pMaterialTradePartner.MaterialId = pMaterial.MaterialID
	LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON tprl.TradePartnerRelationshipLevelID = pMaterialTradePartner.TradePartnerRelationshipLevelID
	INNER JOIN pMaterialTradePartnerShare ON pMaterialTradePartner.MaterialTradePartnerId = pMaterialTradePartnerShare.MaterialTradePartnerID AND pMaterialTradePartnerShare.TradePartnerID = @TradePartnerID 
	INNER JOIN pMaterialRequestSubmitWorkflowShare ON pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID = pMaterialRequestSubmitWorkflowShare.MaterialRequestSubmitWorkflowID AND pMaterialRequestSubmitWorkflowShare.TradePartnerID = @TradePartnerID
	LEFT JOIN uTradePartnerType ON pMaterialRequestSubmitWorkflow.MaterialRequestPartnerTypeID = uTradePartnerType.CustomId	
WHERE (pMaterialRequestSubmitWorkflow.DueDate BETWEEN @StartDate AND @EndDate) AND 
		pMaterialRequestSubmitWorkflow.Status IN (0,1) AND 
		CONVERT(INT, uTradePartnerType.CustomKey) >= @iPartnerLevel
ORDER BY pMaterialRequestSubmitWorkflow.DueDate, MaterialNo, pMaterialRequestWorkflow.MaterialRequestWorkflowID
		

END 

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06546', GetDate())
GO
