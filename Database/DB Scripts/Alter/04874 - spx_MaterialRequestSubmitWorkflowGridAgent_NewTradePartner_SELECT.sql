/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitWorkflowGridAgent_NewTradePartner_SELECT]    Script Date: 01/24/2013 15:41:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitWorkflowGridAgent_NewTradePartner_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowGridAgent_NewTradePartner_SELECT]
GO


/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitWorkflowGridAgent_NewTradePartner_SELECT]    Script Date: 01/24/2013 15:41:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowGridAgent_NewTradePartner_SELECT]
@TradePartnerID uniqueidentifier, 
@FilterExp nvarchar(max)
AS 

SELECT
	pMaterialTradePartnerColor.MaterialTradePartnerColorID
	, pMaterialTradePartner.MaterialTradePartnerId
	, pMaterial.MaterialID
	, uTradePartner.TradePartnerID
	, pMaterial.MaterialNo, pMaterial.MaterialName
	, pMaterialTradePartnerColor.ColorCode
	, pMaterialTradePartnerColor.ColorNo
	, pMaterialTradePartnerColor.ColorName
	, pMaterialTradePartnerColor.VendorColorCode
	, pMaterialTradePartnerColor.VendorColorNo
	, pMaterialTradePartnerColor.VendorColorName
	, uTradePartner.TradePartnerName
	, pMaterialRequestWorkflow.MaterialRequestWorkflowID
	, CAST(pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID AS VARCHAR(40)) AS MaterialRequestSubmitWorkflowID
	, pMaterialRequestWorkflow.GroupName
	, pMaterialRequestWorkflow.GroupID
	, vwx_MaterialSize_SEL.MaterialSize
	, tprl.AgentID
	, tprl.VendorID
	, tprl.FactoryID
	, tprl.AgentName
	, tprl.VendorName
	, tprl.FactoryName
INTO
	#tmpMaterialRequestSubmitWorkflow
FROM
	vwx_MaterialSize_SEL
	INNER JOIN pMaterialTradePartnerColor
		INNER JOIN pMaterialTradePartner ON pMaterialTradePartnerColor.MaterialTradePartnerID = pMaterialTradePartner.MaterialTradePartnerId
		INNER JOIN uTradePartner ON pMaterialTradePartner.TradepartnerId = uTradePartner.TradePartnerID
		INNER JOIN pMaterial ON pMaterialTradePartner.MaterialId = pMaterial.MaterialID
	ON vwx_MaterialSize_SEL.MaterialSizeID = pMaterialTradePartnerColor.MaterialSizeID
	INNER JOIN pMaterialRequestWorkflow
	INNER JOIN pMaterialRequestSubmitWorkflow ON pMaterialRequestWorkflow.MaterialRequestWorkflowID = pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID
	ON pMaterialTradePartnerColor.MaterialTradePartnerColorID = pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID
	LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON tprl.TradePartnerRelationshipLevelID = pMaterialTradePartner.TradePartnerRelationshipLevelID
WHERE
	uTradePartner.Active = 1
	AND pMaterialTradePartnerColor.MaterialRequestShare=1
	AND @TradePartnerID IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID)

ORDER BY
	uTradePartner.TradePartnerName
	, pMaterialTradePartnerColor.ColorCode

DECLARE @selStr NVARCHAR(MAX)
SET @selStr = 'SELECT * FROM #tmpMaterialRequestSubmitWorkflow ' + @FilterExp

EXECUTE spx_Crosstab 
@selStr,
NULL,
NULL,
'MaterialRequestWorkflowID',
'MaterialRequestSubmitWorkflowID',
'MAX'



DROP TABLE #tmpMaterialRequestSubmitWorkflow

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04874', GetDate())
GO
