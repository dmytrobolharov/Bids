/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitWorkflowGridAgent_SELECT]    Script Date: 06/9/2011 19:14:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitWorkflowGridAgent_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowGridAgent_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitWorkflowGridAgent_SELECT]    Script Date: 06/9/2011 19:14:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowGridAgent_SELECT](@TradePartnerID uniqueidentifier)
AS 

SELECT pMaterialTradePartnerColor.MaterialTradePartnerColorID, pMaterialTradePartner.MaterialTradePartnerId, pMaterial.MaterialID, 
  uTradePartner.TradePartnerID, uTradePartnerVendor.TradePartnerVendorID, pMaterial.MaterialNo, pMaterial.MaterialName, 
  pMaterialTradePartnerColor.ColorCode, pMaterialTradePartnerColor.ColorNo, pMaterialTradePartnerColor.ColorName, 
  pMaterialTradePartnerColor.VendorColorCode, pMaterialTradePartnerColor.VendorColorNo, pMaterialTradePartnerColor.VendorColorName, 
  uTradePartner.TradePartnerName, uTradePartnerVendor.VendorName, pMaterialRequestWorkflow.MaterialRequestWorkflowID, 
  CAST(pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID AS VARCHAR(40)) AS MaterialRequestSubmitWorkflowID, 
  pMaterialRequestWorkflow.GroupName, pMaterialRequestWorkflow.GroupID, vwx_MaterialSize_SEL.MaterialSize
INTO #tmpMaterialRequestSubmitWorkflow
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
	and uTradePartnerVendor.Active=1 
ORDER BY uTradePartnerVendor.VendorName, pMaterialTradePartnerColor.ColorCode


EXECUTE spx_Crosstab 
'SELECT * FROM #tmpMaterialRequestSubmitWorkflow',
NULL,
NULL,
'MaterialRequestWorkflowID',
'MaterialRequestSubmitWorkflowID',
'MAX'



DROP TABLE #tmpMaterialRequestSubmitWorkflow

--SELECT * FROM #tmpMaterialRequestSubmitWorkflow
Go
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01909'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01909', GetDate())
END	