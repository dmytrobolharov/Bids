/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitWorkflowGrid_NewTradePartner_SELECT]    Script Date: 01/17/2013 15:44:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitWorkflowGrid_NewTradePartner_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowGrid_NewTradePartner_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitWorkflowGrid_NewTradePartner_SELECT]    Script Date: 01/17/2013 15:44:55 ******/
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
	vwx_MaterialSize_SEL.MaterialSize, tpm.AgentID, tpm.VendorID, tpm.FactoryID, tpm.AgentName, tpm.VendorName, tpm.FactoryName
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
LEFT JOIN vwx_TradePartnerMgmt_SEL tpm ON tpm.RelationshipLevelID = pMaterialTradePartner.TradePartnerRelationshipLevelID
WHERE pMaterialTradePartner.MaterialId = @MaterialId
ORDER BY CASE WHEN AgentName IS NULL THEN 1 ELSE 0 END,
		AgentName,
		VendorName,
		FactoryName,
		pColorPalette.ColorCode

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
VALUES     ('DB_Version', '5.0.0000', '04783', GetDate())
GO
