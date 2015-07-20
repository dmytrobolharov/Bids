/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitWorkflowGridAgent_NewTradePartner_SELECT]    Script Date: 01/10/2013 12:33:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitWorkflowGridAgent_NewTradePartner_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowGridAgent_NewTradePartner_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitWorkflowGridAgent_NewTradePartner_SELECT]    Script Date: 01/10/2013 12:33:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowGridAgent_NewTradePartner_SELECT]
@TradePartnerID uniqueidentifier, 
@FilterExp nvarchar(max)
AS 

CREATE TABLE #tmpChildVendors
(
	TradePartnerID UNIQUEIDENTIFIER,
	TradePartnerName NVARCHAR(200),
	TradePartnerRelationshipID UNIQUEIDENTIFIER
)

-- Selecting all children of given trade partner
;WITH partners AS (
SELECT *, 0 as Level FROM vwx_Sourcing_TradePartner_REL_SEL
WHERE TradePartnerMasterID IS NULL	
AND TradePartnerID = @TradePartnerID

UNION ALL 

SELECT tp.*, Level + 1 FROM vwx_Sourcing_TradePartner_REL_SEL tp
INNER JOIN partners p ON p.TradePartnerID = tp.TradePartnerMasterID
WHERE Level < 3
) 
INSERT INTO #tmpChildVendors (TradePartnerID, TradePartnerName, TradePartnerRelationshipID)
SELECT p.TradePartnerID, tp.TradePartnerName, TradePartnerRelationshipID FROM partners p
LEFT JOIN uTradePartner tp ON tp.TradePartnerID = p.TradePartnerID

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
	INNER JOIN #tmpChildVendors ON #tmpChildVendors.TradePartnerID = uTradePartner.TradePartnerID
WHERE
	 uTradePartner.Active = 1
	AND pMaterialTradePartnerColor.MaterialRequestShare=1
ORDER BY
	uTradePartner.TradePartnerName
	, pMaterialTradePartnerColor.ColorCode

DECLARE @selStr nvarchar(1000)

SET @selStr = 'SELECT * FROM #tmpMaterialRequestSubmitWorkflow ' + @FilterExp

EXECUTE spx_Crosstab 
@selStr,
NULL,
NULL,
'MaterialRequestWorkflowID',
'MaterialRequestSubmitWorkflowID',
'MAX'



DROP TABLE #tmpMaterialRequestSubmitWorkflow
DROP TABLE #tmpChildVendors


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04735', GetDate())
GO
