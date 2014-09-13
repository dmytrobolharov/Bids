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
DECLARE @ExchangeRateItemID UNIQUEIDENTIFIER
DECLARE @ExchangeRateID UNIQUEIDENTIFIER
DECLARE @ConvCurrType NVARCHAR(5)
DECLARE @ConvCurrRate DECIMAL(18,4)

SELECT @StyleBOMDimensionId = StyleBOMDimensionID, @ExchangeRateItemID = ExchangeRateItemID FROM pStyleBOMDimension WHERE WorkFlowItemID = @BOMWorkflowItemID

SELECT @ConvCurrType = CurrencyType, @ExchangeRateID = ExchangeRateID, @ConvCurrRate = Rate 
FROM sExchangeRateItem WHERE ExchangeRateItemID = @ExchangeRateItemID

/* take Default Currency from Exchange Rate of this BOM SeasonYear if no currency is defined */
IF @ExchangeRateItemID IS NULL
BEGIN
	SELECT TOP 1 @ExchangeRateItemID = ExchangeRateItemID, 
		@ConvCurrType = CurrencyType, @ExchangeRateID = dbo.sExchangeRate.ExchangeRateID, @ConvCurrRate = Rate 
	FROM dbo.pWorkFlowItem 
		INNER JOIN dbo.pStyleSeasonYear ON dbo.pWorkFlowItem.StyleSeasonYearID = dbo.pStyleSeasonYear.StyleSeasonYearID
		INNER JOIN dbo.pSeasonYear ON dbo.pStyleSeasonYear.SeasonYearID = dbo.pSeasonYear.SeasonYearID
		INNER JOIN dbo.sExchangeRate ON dbo.pSeasonYear.Season = dbo.sExchangeRate.Season AND dbo.pSeasonYear.Year = dbo.sExchangeRate.Year
		INNER JOIN dbo.sExchangeRateItem ON dbo.sExchangeRate.ExchangeRateID = dbo.sExchangeRateItem.ExchangeRateID
	WHERE dbo.pWorkFlowItem.WorkFlowItemID = @BOMWorkflowItemID AND dbo.sExchangeRateItem.BaseCurrency = 1
END

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


IF (SELECT DimBOM FROM pStyleBOMConfig WHERE StyleBOMDimensionID = @StyleBOMDimensionId) = 0  -- BOM is not dimensional
BEGIN

	-- insert non-dimensional materials
	INSERT INTO #avTemp_BOM (StyleMaterialID, MaterialQuantity, MaterialPrice, MaterialBOM, CurrencyType) 
	SELECT StyleMaterialID, Qty, 
		MaterialPrice = 
			CASE WHEN pMaterialTradePartnerColor.MaterialTradePartnerColorID IS NULL
				OR (	CAST(ISNULL(pMaterialTradePartnerColor.MaterialTradeColor8, 0.000) AS DECIMAL(18,3)) = 0.00 
					AND CAST(ISNULL(pMaterialTradePartnerColor.MaterialTradeColor7, 0.000) AS DECIMAL(18,3)) = 0.00)
				THEN (	CASE 
							WHEN ISNULL(pMaterial.VolumePrice, 0.000) > 0.000 THEN pMaterial.VolumePrice -- Negot'd Price
							ELSE ISNULL(pMaterial.VendorPrice, 0.000) -- Vendor Price
						END  )
				ELSE (	CASE 
							WHEN CAST(ISNULL(pMaterialTradePartnerColor.MaterialTradeColor8, 0.000) AS DECIMAL(18,3)) > 0.000 THEN pMaterialTradePartnerColor.MaterialTradeColor8 -- Negot'd Price
							ELSE CAST(ISNULL(pMaterialTradePartnerColor.MaterialTradeColor7, 0.000) AS DECIMAL(18,3)) -- Vendor Price
						END  )
			END,
		MaterialBOM,
		CurrencyType = 
			CASE WHEN pMaterialTradePartnerColor.MaterialTradePartnerColorID IS NULL
				OR (	CAST(ISNULL(pMaterialTradePartnerColor.MaterialTradeColor8, 0.000) AS DECIMAL(18,3)) = 0.00 
					AND CAST(ISNULL(pMaterialTradePartnerColor.MaterialTradeColor7, 0.000) AS DECIMAL(18,3)) = 0.00)
				THEN (	pMaterial.CurrencyType  )
				ELSE (	CASE 
							WHEN LTRIM(ISNULL(pMaterialTradePartner.CurrencyType, '')) <> '' THEN pMaterialTradePartner.CurrencyType
							ELSE uTradePartner.DefaultCurrency
						END  )
			END
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
		LEFT OUTER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON pStyleBOM.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
		LEFT OUTER JOIN uTradePartner ON uTradePartner.TradePartnerID = COALESCE(tprl.FactoryID, tprl.VendorID, tprl.AgentID)
	WHERE StyleBOMDimensionId = @StyleBOMDimensionId

	UPDATE #avTemp_BOM SET Total = ISNULL(MaterialQuantity, 0.00) * ISNULL(MaterialPrice, 0.00)
	UPDATE #avTemp_BOM SET CurrencyType = @ConvCurrType WHERE CurrencyType IS NULL OR CurrencyType = ''

	IF @ExchangeRateItemID IS NOT NULL
		UPDATE #avTemp_BOM SET ConvTotal = Total * @ConvCurrRate / (SELECT TOP 1 Rate FROM sExchangeRateItem WHERE ExchangeRateID = @ExchangeRateID AND CurrencyType = #avTemp_BOM.CurrencyType)
	ELSE
		UPDATE #avTemp_BOM SET ConvTotal = Total
	
END
ELSE
BEGIN

	-- insert non-dimensional materials
	INSERT INTO #avTemp_BOM (StyleMaterialID, MaterialQuantity, MaterialPrice, MaterialBOM, 
		CurrencyType, StyleBOMItemWeight) 
	SELECT StyleMaterialID, Qty, 
		MaterialPrice = 
			CASE WHEN pMaterialTradePartnerColor.MaterialTradePartnerColorID IS NULL
				OR (	CAST(ISNULL(pMaterialTradePartnerColor.MaterialTradeColor8, 0.000) AS DECIMAL(18,3)) = 0.00 
					AND CAST(ISNULL(pMaterialTradePartnerColor.MaterialTradeColor7, 0.000) AS DECIMAL(18,3)) = 0.00)
				THEN (	CASE 
							WHEN ISNULL(pMaterial.VolumePrice, 0.000) > 0.000 THEN pMaterial.VolumePrice -- Negot'd Price
							ELSE ISNULL(pMaterial.VendorPrice, 0.000) -- Vendor Price
						END  )
				ELSE (	CASE 
							WHEN CAST(ISNULL(pMaterialTradePartnerColor.MaterialTradeColor8, 0.000) AS DECIMAL(18,3)) > 0.000 THEN pMaterialTradePartnerColor.MaterialTradeColor8 -- Negot'd Price
							ELSE CAST(ISNULL(pMaterialTradePartnerColor.MaterialTradeColor7, 0.000) AS DECIMAL(18,3)) -- Vendor Price
						END  )
			END,
		MaterialBOM,
		CurrencyType = 
			CASE WHEN pMaterialTradePartnerColor.MaterialTradePartnerColorID IS NULL
				OR (	CAST(ISNULL(pMaterialTradePartnerColor.MaterialTradeColor8, 0.000) AS DECIMAL(18,3)) = 0.00 
					AND CAST(ISNULL(pMaterialTradePartnerColor.MaterialTradeColor7, 0.000) AS DECIMAL(18,3)) = 0.00)
				THEN (	pMaterial.CurrencyType  )
				ELSE (	CASE 
							WHEN LTRIM(ISNULL(pMaterialTradePartner.CurrencyType, '')) <> '' THEN pMaterialTradePartner.CurrencyType
							ELSE uTradePartner.DefaultCurrency
						END  )
			END,
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
		LEFT OUTER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON pStyleBOM.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
		LEFT OUTER JOIN uTradePartner ON uTradePartner.TradePartnerID = COALESCE(tprl.FactoryID, tprl.VendorID, tprl.AgentID)
	WHERE StyleBOMDimensionId = @StyleBOMDimensionId
		AND (pStyleBOM.Dim1TypeSel = 0 AND pStyleBOM.Dim2TypeSel = 0 AND pStyleBOM.Dim3TypeSel = 0)

	-- insert dimensional materials (price from material request ONLY!)
	INSERT INTO #avTemp_BOM (StyleMaterialID, MaterialQuantity, MaterialPrice, MaterialBOM, 
		CurrencyType, StyleBOMItemWeight) 
	SELECT pStyleBOM.StyleMaterialID, AVG(pStyleBOMItem.MaterialQuantity), 
		MaterialPrice = 
			CASE 
				WHEN CAST(ISNULL(pMaterialTradePartnerColor.MaterialTradeColor8, 0.000) AS DECIMAL(18,3)) > 0.000 THEN pMaterialTradePartnerColor.MaterialTradeColor8 -- Negot'd Price
				ELSE CAST(ISNULL(pMaterialTradePartnerColor.MaterialTradeColor7, 0.000) AS DECIMAL(18,3)) -- Vendor Price
			END,
			MaterialBOM, 
			CurrencyType = 
				CASE 
					WHEN LTRIM(ISNULL(pMaterialTradePartner.CurrencyType, '')) <> '' THEN pMaterialTradePartner.CurrencyType
					ELSE uTradePartner.DefaultCurrency
				END,
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
		LEFT JOIN pMaterial ON pStyleBOM.MaterialID = pMaterial.MaterialID
		LEFT OUTER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON pStyleBOM.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
		LEFT OUTER JOIN uTradePartner ON uTradePartner.TradePartnerID = COALESCE(tprl.FactoryID, tprl.VendorID, tprl.AgentID)
	WHERE pStyleBOM.StyleBOMDimensionId = @StyleBOMDimensionId
		AND (pStyleBOM.Dim1TypeSel = 1 OR pStyleBOM.Dim2TypeSel = 1 OR pStyleBOM.Dim3TypeSel = 1)
	GROUP BY pStyleBOM.StyleMaterialID, MaterialBOM,
				CASE 
					WHEN CAST(ISNULL(pMaterialTradePartnerColor.MaterialTradeColor8, 0.000) AS DECIMAL(18,3)) > 0.000 THEN pMaterialTradePartnerColor.MaterialTradeColor8 -- Negot'd Price
					ELSE CAST(ISNULL(pMaterialTradePartnerColor.MaterialTradeColor7, 0.000) AS DECIMAL(18,3)) -- Vendor Price
				END,
				CASE 
					WHEN LTRIM(ISNULL(pMaterialTradePartner.CurrencyType, '')) <> '' THEN pMaterialTradePartner.CurrencyType
					ELSE uTradePartner.DefaultCurrency
				END

	-- insert dimensional materials (price from pMaterial table ONLY because material request doesn't exist for some dim items combinations)
	INSERT INTO #avTemp_BOM (StyleMaterialID, MaterialQuantity, MaterialPrice, MaterialBOM, 
		CurrencyType, StyleBOMItemWeight) 
	SELECT pStyleBOM.StyleMaterialID, AVG(pStyleBOMItem.MaterialQuantity), 
			MaterialPrice = 
				CASE 
					WHEN ISNULL(pMaterial.VolumePrice, 0.000) > 0.000 THEN pMaterial.VolumePrice -- Negot'd Price
					ELSE ISNULL(pMaterial.VendorPrice, 0.000) -- Vendor Price
				END,
			MaterialBOM,
			CurrencyType = pMaterial.CurrencyType,
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
		LEFT JOIN pMaterial ON pStyleBOM.MaterialID = pMaterial.MaterialID
	WHERE pStyleBOM.StyleBOMDimensionId = @StyleBOMDimensionId
		AND (pStyleBOM.Dim1TypeSel = 1 OR pStyleBOM.Dim2TypeSel = 1 OR pStyleBOM.Dim3TypeSel = 1)
		AND pMaterialTradePartnerColor.MaterialTradePartnerColorID IS NULL
	GROUP BY pStyleBOM.StyleMaterialID, MaterialBOM,
				CASE 
					WHEN ISNULL(pMaterial.VolumePrice, 0.000) > 0.000 THEN pMaterial.VolumePrice -- Negot'd Price
					ELSE ISNULL(pMaterial.VendorPrice, 0.000) -- Vendor Price
				END,
				pMaterial.CurrencyType

	UPDATE #avTemp_BOM SET Total = ISNULL(MaterialQuantity, 0.00) * ISNULL(MaterialPrice, 0.00)
	
														
	/* calculate currency convertion */
	UPDATE #avTemp_BOM SET CurrencyType = @ConvCurrType WHERE CurrencyType IS NULL OR CurrencyType = ''

	IF @ExchangeRateItemID IS NOT NULL
	BEGIN
		UPDATE #avTemp_BOM SET ConvTotal = Total * @ConvCurrRate / (SELECT TOP 1 Rate FROM sExchangeRateItem WHERE ExchangeRateID = @ExchangeRateID AND CurrencyType = #avTemp_BOM.CurrencyType)
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

END


-- insert to pstyleCostingBOM records for particular StytleCostingScenario
INSERT INTO pstyleCostingBOM (StytleCostingScenarioItemsID, StyleID, StyleBOMDimensionID,
		StyleMaterialId, MaterialNo, MaterialName, MaterialType, MaterialTypeDesc, 
		MaterialCost, CurrencyType, 
		CUser, CDate, MUser, MDate)
SELECT @StyleCostingScenarioItemsId, @StyleId, @StyleBOMDimensionId,
		pStyleBOM.StyleMaterialID, pStyleBOM.MaterialNo, pStyleBOM.MaterialName, 
		pStyleBOM.MaterialType, pComponentType.ComponentDescription, 
		SUM(#avTemp_BOM.ConvTotal), @ConvCurrType, 
		@CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate
FROM #avTemp_BOM
	INNER JOIN pStyleBOM ON #avTemp_BOM.StyleMaterialID = pStyleBOM.StyleMaterialID
	INNER JOIN pComponentType ON pStyleBOM.MaterialType = pComponentType.ComponentTypeID
GROUP BY pStyleBOM.StyleMaterialID, pStyleBOM.MaterialNo, pStyleBOM.MaterialName, 
	pStyleBOM.MaterialType, pComponentType.ComponentDescription

DROP TABLE #avTemp_BOM

END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08762', GetDate())
GO
