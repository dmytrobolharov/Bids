IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestAgent_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestAgent_SELECT]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_MaterialRequestAgent_SELECT](@TradePartnerID uniqueidentifier)
AS 

SELECT uTradePartner.TradePartnerName
INTO #MaterialRequestAgent
FROM vwx_MaterialSize_SEL INNER JOIN
  pMaterialTradePartnerColor INNER JOIN
  pMaterialTradePartner ON pMaterialTradePartnerColor.MaterialTradePartnerID = pMaterialTradePartner.MaterialTradePartnerId INNER JOIN
  uTradePartnerVendor ON pMaterialTradePartner.TradepartnerVendorId = uTradePartnerVendor.TradePartnerVendorID INNER JOIN
  uTradePartner ON pMaterialTradePartner.TradepartnerId = uTradePartner.TradePartnerID INNER JOIN
  pMaterial ON pMaterialTradePartner.MaterialId = pMaterial.MaterialID ON 
  vwx_MaterialSize_SEL.MaterialSizeID = pMaterialTradePartnerColor.MaterialSizeID INNER JOIN
  pMaterialRequestWorkflow INNER JOIN
  pMaterialRequestSubmitWorkflow ON 
  pMaterialRequestWorkflow.MaterialRequestWorkflowID = pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID ON 
  pMaterialTradePartnerColor.MaterialTradePartnerColorID = pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID
WHERE pMaterialTradePartner.TradepartnerId = @TradePartnerID
ORDER BY uTradePartnerVendor.VendorName, pMaterialTradePartnerColor.ColorCode

SELECT distinct * FROM #MaterialRequestAgent

DROP TABLE #MaterialRequestAgent

Go
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01806'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01806', GetDate())

END

GO 

