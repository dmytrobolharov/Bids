/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitWorkflowGrid_NewTradePartner_SELECT]    Script Date: 01/09/2013 13:10:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitWorkflowGrid_NewTradePartner_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowGrid_NewTradePartner_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitWorkflowGrid_NewTradePartner_SELECT]    Script Date: 01/09/2013 13:10:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowGrid_NewTradePartner_SELECT](@MaterialId uniqueidentifier)
AS 

SELECT uTradePartner.TradePartnerName, pMaterialTradePartnerColor.ColorName, 
	pMaterialTradePartnerColor.MaterialTradePartnerColorID, pMaterialTradePartner.MaterialTradePartnerId, pMaterial.MaterialID, 
	uTradePartner.TradePartnerID, pMaterial.MaterialNo, pMaterial.MaterialName, 
	pColorPalette.ColorCode, pMaterialTradePartnerColor.ColorNo, 
	pMaterialTradePartnerColor.VendorColorCode, pMaterialTradePartnerColor.VendorColorNo, pMaterialTradePartnerColor.VendorColorName, 
	pMaterialRequestWorkflow.MaterialRequestWorkflowID, 
	CAST(pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID AS VARCHAR(40)) AS MaterialRequestSubmitWorkflowID, 
	vwx_MaterialSize_SEL.MaterialSize
INTO #tmpMaterialRequestSubmitWorkflow
FROM vwx_MaterialSize_SEL 
INNER JOIN  pMaterialTradePartnerColor 
INNER JOIN  pMaterialTradePartner ON pMaterialTradePartnerColor.MaterialTradePartnerID = pMaterialTradePartner.MaterialTradePartnerId 
INNER JOIN  uTradePartner ON pMaterialTradePartner.TradepartnerId = uTradePartner.TradePartnerID 
INNER JOIN  pMaterial ON pMaterialTradePartner.MaterialId = pMaterial.MaterialID ON   vwx_MaterialSize_SEL.MaterialSizeID = pMaterialTradePartnerColor.MaterialSizeID 
LEFT OUTER JOIN pMaterialColor ON pMaterialColor.MaterialColorID = pMaterialTradePartnerColor.MaterialColorID 
LEFT OUTER JOIN pColorPalette ON pColorPalette.ColorPaletteID = pMaterialColor.ColorPaletteID 
LEFT OUTER JOIN  pMaterialRequestWorkflow 
INNER JOIN pMaterialRequestSubmitWorkflow ON   pMaterialRequestWorkflow.MaterialRequestWorkflowID = pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID ON   pMaterialTradePartnerColor.MaterialTradePartnerColorID = pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID
WHERE pMaterialTradePartner.MaterialId = @MaterialId
ORDER BY uTradePartner.TradePartnerName, pColorPalette.ColorCode

EXECUTE spx_Crosstab 
'SELECT * FROM #tmpMaterialRequestSubmitWorkflow',
NULL,
NULL,
'MaterialRequestWorkflowID',
'MaterialRequestSubmitWorkflowID',
'MAX'


DROP TABLE #tmpMaterialRequestSubmitWorkflow



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04734', GetDate())
GO
