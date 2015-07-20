IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCostingBOM_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCostingBOM_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleCostingBOM_INSERT](
	@StyleCostingScenarioItemsId UNIQUEIDENTIFIER 
	,@StyleId UNIQUEIDENTIFIER 
	,@BOMWorkflowItemID UNIQUEIDENTIFIER 
	,@CreatedBy NVARCHAR(200)
	,@CreatedDate DATETIME
)

AS
BEGIN

DECLARE @StyleBOMDimensionId uniqueidentifier
DECLARE @ItemDim1Type uniqueidentifier
DECLARE @ItemDim2Type uniqueidentifier
DECLARE @ItemDim3Type uniqueidentifier
DECLARE @Count_DimItems int
DECLARE @Cost As decimal(18,3)

DECLARE @ExchangeRateItemID UNIQUEIDENTIFIER
DECLARE @ExchangeRateID UNIQUEIDENTIFIER
DECLARE @ConvCurrType NVARCHAR(5)
DECLARE @ConvCurrRate DECIMAL(18,4)

SELECT @StyleBOMDimensionId = StyleBOMDimensionID, @ExchangeRateItemID = ExchangeRateItemID FROM pStyleBOMDimension WHERE WorkFlowItemID = @BOMWorkflowItemID

-- Getting  Dimensions Types
SELECT @ItemDim1Type = ItemDim1TypeId, @ItemDim2Type = ItemDim2TypeId, @ItemDim3Type = ItemDim3TypeId FROM pStyleBOMDimension
WHERE StyleBOMDimensionID = @StyleBOMDimensionId

SELECT @ConvCurrType = CurrencyType, @ExchangeRateID = ExchangeRateID, @ConvCurrRate = Rate 
FROM sExchangeRateItem WHERE ExchangeRateItemID = @ExchangeRateItemID

-- Temporary table for average costing
CREATE TABLE #avTemp_BOM (
	StyleMaterialID uniqueidentifier,
	MaterialQuantity decimal(19,3),
	MaterialPrice decimal(19,3),
	Total decimal(19,3),
	MaterialBOM int,
	CurrencyType nvarchar(5),
	ConvTotal decimal(19,3),
	StyleBOMItemWeight int
)

	-- insert non-dimensional materials
	INSERT INTO #avTemp_BOM (StyleMaterialID, MaterialQuantity, MaterialPrice, Total, MaterialBOM, 
		CurrencyType, StyleBOMItemWeight) 
	SELECT StyleMaterialID, Qty, 
		MaterialPrice = CASE WHEN pMaterialTradePartnerColor.MaterialTradePartnerColorID IS NOT NULL THEN CAST(pMaterialTradePartnerColor.MaterialTradeColor8 AS DECIMAL(18,2)) ELSE pStyleBOM.MaterialPrice END, 
		Total = ISNULL(Qty,0) * ISNULL(CASE WHEN pMaterialTradePartnerColor.MaterialTradePartnerColorID IS NOT NULL THEN CAST(pMaterialTradePartnerColor.MaterialTradeColor8 AS DECIMAL(18,2)) ELSE pStyleBOM.MaterialPrice END,0), 
		MaterialBOM,
		CASE WHEN pMaterialTradePartnerColor.MaterialTradePartnerColorID IS NOT NULL 
			THEN COALESCE(pMaterialTradePartner.CurrencyType, pMaterial.CurrencyType) 
			ELSE NULL
		END CurrencyType,
		0
	FROM pStyleBOM
		LEFT OUTER JOIN pWorkFlowItem ON pStyleBOM.WorkflowItemId = pWorkFlowItem.WorkFlowItemID
		LEFT OUTER JOIN pStyleSeasonYear ON pStyleBOM.StyleID = pStyleSeasonYear.StyleID 
			AND pWorkFlowItem.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
		LEFT OUTER JOIN pMaterialTradePartner ON pStyleBOM.MaterialID = pMaterialTradePartner.MaterialId
			AND pStyleBOM.TradePartnerRelationshipLevelID = pMaterialTradePartner.TradePartnerRelationshipLevelID
			AND pStyleSeasonYear.SeasonYearID = pMaterialTradePartner.SeasonYearID
		LEFT OUTER JOIN pMaterialTradePartnerColor ON pStyleBOM.MaterialID = pMaterialTradePartnerColor.MaterialID
			AND pMaterialTradePartner.MaterialTradePartnerId = pMaterialTradePartnerColor.MaterialTradePartnerId
			AND ISNULL(pStyleBOM.MaterialColorId,'00000000-0000-0000-0000-000000000000') = pMaterialTradePartnerColor.MaterialColorID
			AND ISNULL(pStyleBOM.MaterialSizeID,'00000000-0000-0000-0000-000000000000') = pMaterialTradePartnerColor.MaterialSizeID
		LEFT JOIN pMaterial ON pStyleBOM.MaterialID = pMaterial.MaterialID
	WHERE StyleBOMDimensionId = @StyleBOMDimensionId
		AND (pStyleBOM.Dim1TypeSel = 0 AND pStyleBOM.Dim2TypeSel = 0 AND pStyleBOM.Dim3TypeSel = 0)

	-- insert dimensional materials (price from material request)
	INSERT INTO #avTemp_BOM (StyleMaterialID, MaterialQuantity, MaterialPrice, Total, MaterialBOM, 
		CurrencyType, StyleBOMItemWeight) 
	SELECT pStyleBOM.StyleMaterialID, AVG(pStyleBOMItem.MaterialQuantity), 
			AVG(CAST(pMaterialTradePartnerColor.MaterialTradeColor8 AS DECIMAL(18,2))), 
			AVG(ISNULL(pStyleBOMItem.MaterialQuantity,0) * ISNULL(CAST(pMaterialTradePartnerColor.MaterialTradeColor8 AS DECIMAL(18,2)),0)), 
			MaterialBOM, 
			COALESCE(pMaterialTradePartner.CurrencyType, pMaterial.CurrencyType) AS CurrencyType,
			COUNT(pStyleBOMItem.StyleMaterialID)
	FROM pStyleBOM INNER JOIN
			pStyleBOMItem ON pStyleBOM.StyleBOMDimensionId = pStyleBOMItem.StyleBOMDimensionId AND pStyleBOM.StyleMaterialID = pStyleBOMItem.StyleMaterialID INNER JOIN
			pStyleBOMDimensionItems ON pStyleBOM.StyleBOMDimensionId = pStyleBOMDimensionItems.StyleBOMDimensionId
				AND pStyleBOMItem.StyleBOMDimensionItemID = pStyleBOMDimensionItems.StyleBOMDimensionItemID
				AND pStyleBOMDimensionItems.ItemDim1Active = 1 AND pStyleBOMDimensionItems.ItemDim2Active = 1 AND pStyleBOMDimensionItems.ItemDim3Active = 1
		INNER JOIN pWorkFlowItem ON pStyleBOM.WorkflowItemId = pWorkFlowItem.WorkFlowItemID
		INNER JOIN pStyleSeasonYear ON pStyleBOM.StyleID = pStyleSeasonYear.StyleID 
			AND pWorkFlowItem.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
		INNER JOIN pMaterialTradePartner ON pStyleBOM.MaterialID = pMaterialTradePartner.MaterialId
			AND pStyleBOM.TradePartnerRelationshipLevelID = pMaterialTradePartner.TradePartnerRelationshipLevelID
			AND pStyleSeasonYear.SeasonYearID = pMaterialTradePartner.SeasonYearID
		INNER JOIN pMaterialTradePartnerColor ON pStyleBOM.MaterialID = pMaterialTradePartnerColor.MaterialID
			AND pMaterialTradePartner.MaterialTradePartnerId = pMaterialTradePartnerColor.MaterialTradePartnerId
			AND ISNULL(pStyleBOMItem.MaterialColorId,'00000000-0000-0000-0000-000000000000') = pMaterialTradePartnerColor.MaterialColorID
			AND ISNULL(pStyleBOMItem.MaterialDimension,'00000000-0000-0000-0000-000000000000') = pMaterialTradePartnerColor.MaterialSizeID
		LEFT JOIN pMaterial ON pstyleBOM.MaterialID = pMaterial.MaterialID
	WHERE pStyleBOM.StyleBOMDimensionId = @StyleBOMDimensionId
		AND (pStyleBOM.Dim1TypeSel = 1 OR pStyleBOM.Dim2TypeSel = 1 OR pStyleBOM.Dim3TypeSel = 1)
	GROUP BY pStyleBOM.StyleMaterialID, MaterialBOM
		,COALESCE(pMaterialTradePartner.CurrencyType, pMaterial.CurrencyType)

	-- insert dimensional materials (price from pStyleBOMItem)
	INSERT INTO #avTemp_BOM (StyleMaterialID, MaterialQuantity, MaterialPrice, Total, MaterialBOM, 
		CurrencyType, StyleBOMItemWeight) 
	SELECT pStyleBOM.StyleMaterialID, AVG(pStyleBOMItem.MaterialQuantity), 
			AVG(pStyleBOMItem.MaterialPrice), 
			AVG(ISNULL(pStyleBOMItem.MaterialQuantity,0) * ISNULL(pStyleBOMItem.MaterialPrice,0)), 
			MaterialBOM,
			NULL AS CurrencyType,
			COUNT(pStyleBOMItem.StyleMaterialID)
	FROM pStyleBOM INNER JOIN
			pStyleBOMItem ON pStyleBOM.StyleBOMDimensionId = pStyleBOMItem.StyleBOMDimensionId AND pStyleBOM.StyleMaterialID = pStyleBOMItem.StyleMaterialID INNER JOIN
			pStyleBOMDimensionItems ON pStyleBOM.StyleBOMDimensionId = pStyleBOMDimensionItems.StyleBOMDimensionId
				AND pStyleBOMItem.StyleBOMDimensionItemID = pStyleBOMDimensionItems.StyleBOMDimensionItemID
				AND pStyleBOMDimensionItems.ItemDim1Active = 1 AND pStyleBOMDimensionItems.ItemDim2Active = 1 AND pStyleBOMDimensionItems.ItemDim3Active = 1
		INNER JOIN pWorkFlowItem ON pStyleBOM.WorkflowItemId = pWorkFlowItem.WorkFlowItemID
		INNER JOIN pStyleSeasonYear ON pStyleBOM.StyleID = pStyleSeasonYear.StyleID 
			AND pWorkFlowItem.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
		LEFT OUTER JOIN pMaterialTradePartner ON pStyleBOM.MaterialID = pMaterialTradePartner.MaterialId
			AND pStyleBOM.TradePartnerRelationshipLevelID = pMaterialTradePartner.TradePartnerRelationshipLevelID
			AND pStyleSeasonYear.SeasonYearID = pMaterialTradePartner.SeasonYearID
		LEFT OUTER JOIN pMaterialTradePartnerColor ON pStyleBOM.MaterialID = pMaterialTradePartnerColor.MaterialID
			AND pMaterialTradePartner.MaterialTradePartnerId = pMaterialTradePartnerColor.MaterialTradePartnerId
			AND ISNULL(pStyleBOMItem.MaterialColorId,'00000000-0000-0000-0000-000000000000') = pMaterialTradePartnerColor.MaterialColorID
			AND ISNULL(pStyleBOMItem.MaterialDimension,'00000000-0000-0000-0000-000000000000') = pMaterialTradePartnerColor.MaterialSizeID
	WHERE pStyleBOM.StyleBOMDimensionId = @StyleBOMDimensionId
		AND (pStyleBOM.Dim1TypeSel = 1 OR pStyleBOM.Dim2TypeSel = 1 OR pStyleBOM.Dim3TypeSel = 1)
		AND pMaterialTradePartnerColor.MaterialTradePartnerColorID IS NULL
	GROUP BY pStyleBOM.StyleMaterialID, MaterialBOM
	
														
	/* calculate currency convertion */
	UPDATE #avTemp_BOM SET CurrencyType = @ConvCurrType WHERE CurrencyType IS NULL OR CurrencyType = ''
	

	IF @ExchangeRateItemID IS NOT NULL
	BEGIN
		UPDATE #avTemp_BOM SET ConvTotal = Total * @ConvCurrRate / (SELECT Rate FROM sExchangeRateItem WHERE ExchangeRateID = @ExchangeRateID AND CurrencyType = #avTemp_BOM.CurrencyType)
		UPDATE #avTemp_BOM SET CurrencyType = @ConvCurrType
	END
	ELSE
	BEGIN
		UPDATE #avTemp_BOM SET ConvTotal = Total
	END

	/* Calc weighted average Total by StyleMaterial 
	  (because for one material MaterialPrice could be taken from pMaterialTradePartnerColor and StyleBOMItem
	  it causes several rows with the same StyleMaterialID in table #avTemp_BOM) */
	UPDATE #avTemp_BOM 
	SET ConvTotal = ConvTotal * StyleBOMItemWeight / 
	(SELECT COUNT(*) FROM pStyleBOMItem INNER JOIN			
		pStyleBOMDimensionItems ON pStyleBOMItem.StyleBOMDimensionId = pStyleBOMDimensionItems.StyleBOMDimensionId
				AND pStyleBOMItem.StyleBOMDimensionItemID = pStyleBOMDimensionItems.StyleBOMDimensionItemID
				AND pStyleBOMDimensionItems.ItemDim1Active = 1 AND pStyleBOMDimensionItems.ItemDim2Active = 1 AND pStyleBOMDimensionItems.ItemDim3Active = 1
		WHERE StyleMaterialID = #avTemp_BOM.StyleMaterialID)
	WHERE StyleBOMItemWeight <> 0



-- insert to pstyleCostingBOM records for particular StytleCostingScenario
INSERT INTO pstyleCostingBOM (StytleCostingScenarioItemsID, StyleID, StyleBOMDimensionID,
		StyleMaterialId, MaterialNo, MaterialName, MaterialType, MaterialTypeDesc, 
		MaterialCost, CurrencyType, 
		CUser, CDate, MUser, MDate)
SELECT @StyleCostingScenarioItemsId, @StyleId, @StyleBOMDimensionId,
		pStyleBOM.StyleMaterialID, pStyleBOM.MaterialNo, pStyleBOM.MaterialName, 
		pStyleBOM.MaterialType, pComponentType.ComponentDescription, 
		SUM(#avTemp_BOM.ConvTotal), #avTemp_BOM.CurrencyType, 
		@CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate
FROM #avTemp_BOM
	INNER JOIN pStyleBOM ON #avTemp_BOM.StyleMaterialID = pStyleBOM.StyleMaterialID
	INNER JOIN pComponentType ON pStyleBOM.MaterialType = pComponentType.ComponentTypeID
GROUP BY pStyleBOM.StyleMaterialID, pStyleBOM.MaterialNo, pStyleBOM.MaterialName, 
	pStyleBOM.MaterialType, pComponentType.ComponentDescription, 
	#avTemp_BOM.CurrencyType

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07066', GetDate())
GO
