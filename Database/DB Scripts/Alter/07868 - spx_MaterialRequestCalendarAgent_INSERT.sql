/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestCalendarAgent_INSERT]    Script Date: 06/04/2014 12:01:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestCalendarAgent_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestCalendarAgent_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestCalendarAgent_INSERT]    Script Date: 06/04/2014 12:01:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[spx_MaterialRequestCalendarAgent_INSERT]
(@TeamId nvarchar(50),
@TradePartnerId nvarchar(50),
@CalendarId nvarchar(50),
@StartDate datetime,
@EndDate datetime)
AS 


/*Holiday's INSERT SELECT Statement.*/
INSERT INTO pStyleCalendarTemp
		(CalendarID, PKeyID, CalendarLinkID, CalendarLinkSubID, CalendarDate, CalendarType, CalendarStatus, CalendarDescription)
SELECT	@CalendarID AS CalendarID, '00000000-0000-0000-0000-000000000000' AS PKeyID, '00000000-0000-0000-0000-000000000000' AS CalendarLinkID, 
	'00000000-0000-0000-0000-000000000000' AS CalendarLinkSubID, CalendarEventDate AS CalendarDate, 'Holiday' AS CalendarType, 0 AS CalendarStatus,
	CalendarEventCountry +  ' - ' + CalendarEventName as CalendarDescription
FROM	cCalendarEvent WITH (NOLOCK)




BEGIN
INSERT INTO pStyleCalendarTemp
  (CalendarId, PKeyId, CalendarLinkId, 
  CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
SELECT @CalendarId AS CalendarId, pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID, pMaterialTradePartnerColor.MaterialTradePartnerColorID, 
  pMaterialRequestWorkflow.MaterialRequestWorkflow + N' (' + CAST(pMaterialRequestSubmitWorkflow.Submit AS nvarchar(4)) + ') ' AS CalendarLinkSubId, 
  pMaterialRequestSubmitWorkflow.DueDate, 'MaterialRequest' AS CalendarType, pMaterialRequestSubmitWorkflow.Status, 
  '<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + pMaterial.MaterialNo + ' (' + pMaterial.MaterialNo
   + ') ' + pMaterial.MaterialName AS CalendarDescription, 0 AS CalendarView
FROM pMaterialRequestSubmitWorkflow INNER JOIN
  pMaterialRequestWorkflow ON 
  pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = pMaterialRequestWorkflow.MaterialRequestWorkflowID INNER JOIN
  pMaterialTradePartnerColor ON 
  pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID = pMaterialTradePartnerColor.MaterialTradePartnerColorID INNER JOIN
  uTradePartnerVendor ON pMaterialRequestSubmitWorkflow.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID INNER JOIN
  vwx_MaterialSize_SEL ON pMaterialTradePartnerColor.MaterialSizeID = vwx_MaterialSize_SEL.MaterialSizeID INNER JOIN
  uTradePartner ON pMaterialRequestSubmitWorkflow.TradePartnerID = uTradePartner.TradePartnerID INNER JOIN
  pMaterial ON pMaterialRequestSubmitWorkflow.MaterialID = pMaterial.MaterialID
WHERE (pMaterialRequestSubmitWorkflow.DueDate BETWEEN @StartDate AND @EndDate) 
AND (pMaterialRequestSubmitWorkflow.Status NOT IN ( SELECT StatusID FROM pMaterialRequestSubmitStatus WHERE ApprovedType = 1 OR StatusID = 4 )) 
AND   (uTradePartnerVendor.TradePartnerID = @TradePartnerId) 
ORDER BY pMaterialRequestSubmitWorkflow.DueDate, pMaterial.MaterialNo, pMaterialRequestWorkflow.MaterialRequestWorkflowID	
END 


BEGIN

INSERT INTO pStyleCalendarTemp
  (CalendarId, PKeyId, CalendarLinkId, 
  CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, CalendarView)
SELECT @CalendarId AS CalendarId, pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID, pMaterialTradePartnerColor.MaterialTradePartnerColorID, 
  pMaterialRequestWorkflow.MaterialRequestWorkflow + N' (' + CAST(pMaterialRequestSubmitWorkflow.Submit AS nvarchar(4)) + ') ' AS CalendarLinkSubId, 
  pMaterialRequestSubmitWorkflow.DueDate, 'MaterialRequest' AS CalendarType, pMaterialRequestSubmitWorkflow.Status, 
  '<b>A: </b>' + uTradePartner.TradePartnerCode + ' / <b>V: </b>' + uTradePartnerVendor.VendorCode + '<BR>' + pMaterial.MaterialNo + ' (' + pMaterial.MaterialNo
   + ') ' + pMaterial.MaterialName AS CalendarDescription, 0 AS CalendarView
FROM pMaterialRequestSubmitWorkflow INNER JOIN
  pMaterialRequestWorkflow ON 
  pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID = pMaterialRequestWorkflow.MaterialRequestWorkflowID INNER JOIN
  pMaterialTradePartnerColor ON 
  pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID = pMaterialTradePartnerColor.MaterialTradePartnerColorID INNER JOIN
  uTradePartnerVendor ON pMaterialRequestSubmitWorkflow.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID INNER JOIN
  vwx_MaterialSize_SEL ON pMaterialTradePartnerColor.MaterialSizeID = vwx_MaterialSize_SEL.MaterialSizeID INNER JOIN
  uTradePartner ON pMaterialRequestSubmitWorkflow.TradePartnerID = uTradePartner.TradePartnerID INNER JOIN
  pMaterial ON pMaterialRequestSubmitWorkflow.MaterialID = pMaterial.MaterialID
WHERE (pMaterialRequestSubmitWorkflow.DueDate BETWEEN @StartDate AND @EndDate) 
AND (pMaterialRequestSubmitWorkflow.Status = 1) 
AND   (uTradePartnerVendor.TradePartnerID = @TradePartnerId) AND 
    (pMaterialRequestSubmitWorkflow.EndDate BETWEEN @StartDate AND @EndDate)  
ORDER BY pMaterialRequestSubmitWorkflow.DueDate, pMaterial.MaterialNo, pMaterialRequestWorkflow.MaterialRequestWorkflowID	
END 


set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07868', GetDate())
GO