IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMDimSummary_Total_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMDimSummary_Total_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_StyleBOMDimSummary_Total_SELECT]
(
	@StyleId uniqueidentifier,
	@StyleSet int,
	@WorkflowId uniqueidentifier,
	@WorkflowItemID uniqueidentifier,
	@StyleBOMDimensionId uniqueidentifier,
	@StyleBOMDimension1ItemId nvarchar(50),
	@StyleBOMDimension2ItemId nvarchar(50),
	@StyleBOMDimension3ItemId nvarchar(50),
	@IsAverage int,
	@IsBOMDimensional int = 1,
	@ExchangeRateItemID uniqueidentifier = null
)

AS

DECLARE @ItemDim1Type uniqueidentifier
DECLARE @ItemDim2Type uniqueidentifier
DECLARE @ItemDim3Type uniqueidentifier

DECLARE @Count_DimItems int

if @StyleBOMDimension1ItemId = '' set @StyleBOMDimension1ItemId = '00000000-0000-0000-0000-000000000000'
if @StyleBOMDimension2ItemId = '' set @StyleBOMDimension2ItemId = '00000000-0000-0000-0000-000000000000'
if @StyleBOMDimension3ItemId = '' set @StyleBOMDimension3ItemId = '00000000-0000-0000-0000-000000000000'

DECLARE @ExchangeRateID UNIQUEIDENTIFIER
DECLARE @ConvCurrType NVARCHAR(5)
DECLARE @ConvCurrRate DECIMAL(18,4)

IF @ExchangeRateItemID IS NOT NULL
	SELECT @ConvCurrType = CurrencyType, @ExchangeRateID = ExchangeRateID, @ConvCurrRate = Rate 
	FROM sExchangeRateItem WHERE ExchangeRateItemID = @ExchangeRateItemID
	
ELSE
	SELECT TOP 1 @ExchangeRateItemID = ExchangeRateItemID, 
		@ConvCurrType = CurrencyType, @ExchangeRateID = dbo.sExchangeRate.ExchangeRateID, @ConvCurrRate = Rate 
	FROM dbo.pWorkFlowItem 
		INNER JOIN dbo.pStyleSeasonYear ON dbo.pWorkFlowItem.StyleSeasonYearID = dbo.pStyleSeasonYear.StyleSeasonYearID
		INNER JOIN dbo.pSeasonYear ON dbo.pStyleSeasonYear.SeasonYearID = dbo.pSeasonYear.SeasonYearID
		INNER JOIN dbo.sExchangeRate ON dbo.pSeasonYear.Season = dbo.sExchangeRate.Season AND dbo.pSeasonYear.Year = dbo.sExchangeRate.Year
		INNER JOIN dbo.sExchangeRateItem ON dbo.sExchangeRate.ExchangeRateID = dbo.sExchangeRateItem.ExchangeRateID
	WHERE dbo.pWorkFlowItem.WorkFlowItemID = @WorkflowItemID AND dbo.sExchangeRateItem.BaseCurrency = 1
	

BEGIN

-- Temporary table for particular dimensions or for non-dimensional BOM
CREATE TABLE #temp_BOM (
	StyleMaterialID uniqueidentifier,
	MaterialQuantity decimal(19,3),
	MaterialPrice decimal(19,3),
	Total decimal(19,3),
	MaterialBOM int,
	CurrencyType nvarchar(5) collate database_default,
	ConvTotal decimal(19,3)
)

IF @IsBOMDimensional = 0
BEGIN

	-- insert non-dimensional materials
	INSERT INTO #temp_BOM (StyleMaterialID, MaterialQuantity, MaterialPrice, MaterialBOM, CurrencyType) 
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

	UPDATE #temp_BOM SET Total = ISNULL(MaterialQuantity, 0.00) * ISNULL(MaterialPrice, 0.00)
	UPDATE #temp_BOM SET CurrencyType = @ConvCurrType WHERE CurrencyType IS NULL OR CurrencyType = ''
	
	IF @ExchangeRateItemID IS NOT NULL
		UPDATE #temp_BOM SET ConvTotal = Total * @ConvCurrRate / (SELECT Rate FROM sExchangeRateItem WHERE ExchangeRateID = @ExchangeRateID AND CurrencyType = #temp_BOM.CurrencyType)
	ELSE
		UPDATE #temp_BOM SET ConvTotal = Total
		
	SELECT '   ' AS cellSpace, 'BOM Costing  ' AS [Cost Type], ISNULL(@ConvCurrType,'') + ' ' + CAST(SUM(ConvTotal) AS nVARCHAR(10)) + '' AS [Total Cost], '   ' AS cellSpace1
	FROM         #temp_BOM WHERE MaterialBOM = 1
	UNION ALL
	SELECT '   ' AS cellSpace, 'Total Costing  ' AS [Cost Type], ISNULL(@ConvCurrType,'') + ' ' +  CAST(SUM(ConvTotal) AS nVARCHAR(10)) + '' AS [Total Cost], '   ' AS cellSpace1
	FROM         #temp_BOM

END
ELSE
BEGIN

	-- Getting  Dimensions Types
	SELECT @ItemDim1Type = ItemDim1TypeId, @ItemDim2Type = ItemDim2TypeId, @ItemDim3Type = ItemDim3TypeId FROM pStyleBOMDimension
	WHERE StyleBOMDimensionID = @StyleBOMDimensionId

	-- Temporary table for average costing
	CREATE TABLE #avTemp_BOM (
		StyleMaterialID uniqueidentifier,
		MaterialQuantity decimal(19,3),
		MaterialPrice decimal(19,3),
		Total decimal(19,3),
		MaterialBOM int,
		CurrencyType nvarchar(5) collate database_default,
		ConvTotal decimal(19,3),
		StyleBOMItemWeight int
	)
	DECLARE @Cost As decimal(19,3)
	
	-- insert non-dimensional materials
	INSERT INTO #temp_BOM (StyleMaterialID, MaterialQuantity, MaterialPrice, MaterialBOM, CurrencyType) 
	SELECT StyleMaterialID, ISNULL(Qty, 0), 
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
		AND (pStyleBOM.Dim1TypeSel = 0 AND pStyleBOM.Dim2TypeSel = 0 AND pStyleBOM.Dim3TypeSel = 0)

	UPDATE #temp_BOM SET Total = ISNULL(MaterialQuantity, 0.00) * ISNULL(MaterialPrice, 0.00)

	-- insert dimensional materials
	IF @ItemDim3Type <> '00000000-0000-0000-0000-000000000000'
	BEGIN
		INSERT INTO #temp_BOM (StyleMaterialID, MaterialQuantity, MaterialPrice, MaterialBOM, CurrencyType) 
		SELECT pStyleBOM.StyleMaterialID, ISNULL(pStyleBOMItem.MaterialQuantity, 0), 
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
		FROM pStyleBOM INNER JOIN
			pStyleBOMItem ON pStyleBOM.StyleBOMDimensionId = pStyleBOMItem.StyleBOMDimensionId
				AND pStyleBOM.StyleMaterialID = pStyleBOMItem.StyleMaterialID
				AND ItemDim1Id = @StyleBOMDimension1ItemId AND ItemDim2Id = @StyleBOMDimension2ItemId AND ItemDim3Id = @StyleBOMDimension3ItemId
			LEFT OUTER JOIN pWorkFlowItem ON pStyleBOM.WorkflowItemId = pWorkFlowItem.WorkFlowItemID
			LEFT OUTER JOIN pStyleSeasonYear ON pStyleBOM.StyleID = pStyleSeasonYear.StyleID 
				AND pWorkFlowItem.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
			LEFT OUTER JOIN pMaterialTradePartner ON pStyleBOM.MaterialID = pMaterialTradePartner.MaterialId
				AND pStyleBOM.TradePartnerRelationshipLevelID = pMaterialTradePartner.TradePartnerRelationshipLevelID
				AND pStyleSeasonYear.SeasonYearID = pMaterialTradePartner.SeasonYearID
			LEFT OUTER JOIN pMaterialTradePartnerColor ON pStyleBOM.MaterialID = pMaterialTradePartnerColor.MaterialID
				AND pMaterialTradePartner.MaterialTradePartnerId = pMaterialTradePartnerColor.MaterialTradePartnerId
				AND ISNULL(pStyleBOMItem.MaterialColorId,'00000000-0000-0000-0000-000000000000') = pMaterialTradePartnerColor.MaterialColorID
				AND ISNULL(pStyleBOMItem.MaterialDimension,'00000000-0000-0000-0000-000000000000') = pMaterialTradePartnerColor.MaterialSizeID
			LEFT JOIN pMaterial ON pStyleBOM.MaterialID = pMaterial.MaterialID
			LEFT OUTER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON pStyleBOM.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
			LEFT OUTER JOIN uTradePartner ON uTradePartner.TradePartnerID = COALESCE(tprl.FactoryID, tprl.VendorID, tprl.AgentID)
		WHERE pStyleBOM.StyleBOMDimensionId = @StyleBOMDimensionId
			AND (pStyleBOM.Dim1TypeSel = 1 OR pStyleBOM.Dim2TypeSel = 1 OR pStyleBOM.Dim3TypeSel = 1)
	END
	ELSE IF @ItemDim2Type <> '00000000-0000-0000-0000-000000000000'
	BEGIN
		INSERT INTO #temp_BOM (StyleMaterialID, MaterialQuantity, MaterialPrice, MaterialBOM, CurrencyType) 
		SELECT pStyleBOM.StyleMaterialID, ISNULL(pStyleBOMItem.MaterialQuantity, 0), 
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
		FROM pStyleBOM INNER JOIN
			pStyleBOMItem ON pStyleBOM.StyleBOMDimensionId = pStyleBOMItem.StyleBOMDimensionId
				AND pStyleBOM.StyleMaterialID = pStyleBOMItem.StyleMaterialID
				AND ItemDim1Id = @StyleBOMDimension1ItemId AND ItemDim2Id = @StyleBOMDimension2ItemId
			LEFT OUTER JOIN pWorkFlowItem ON pStyleBOM.WorkflowItemId = pWorkFlowItem.WorkFlowItemID
			LEFT OUTER JOIN pStyleSeasonYear ON pStyleBOM.StyleID = pStyleSeasonYear.StyleID 
				AND pWorkFlowItem.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
			LEFT OUTER JOIN pMaterialTradePartner ON pStyleBOM.MaterialID = pMaterialTradePartner.MaterialId
				AND pStyleBOM.TradePartnerRelationshipLevelID = pMaterialTradePartner.TradePartnerRelationshipLevelID
				AND pStyleSeasonYear.SeasonYearID = pMaterialTradePartner.SeasonYearID
			LEFT OUTER JOIN pMaterialTradePartnerColor ON pStyleBOM.MaterialID = pMaterialTradePartnerColor.MaterialID
				AND pMaterialTradePartner.MaterialTradePartnerId = pMaterialTradePartnerColor.MaterialTradePartnerId
				AND ISNULL(pStyleBOMItem.MaterialColorId,'00000000-0000-0000-0000-000000000000') = pMaterialTradePartnerColor.MaterialColorID
				AND ISNULL(pStyleBOMItem.MaterialDimension,'00000000-0000-0000-0000-000000000000') = pMaterialTradePartnerColor.MaterialSizeID
			LEFT JOIN pMaterial ON pStyleBOM.MaterialID = pMaterial.MaterialID
			LEFT OUTER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON pStyleBOM.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
			LEFT OUTER JOIN uTradePartner ON uTradePartner.TradePartnerID = COALESCE(tprl.FactoryID, tprl.VendorID, tprl.AgentID)
		WHERE pStyleBOM.StyleBOMDimensionId = @StyleBOMDimensionId
			AND (pStyleBOM.Dim1TypeSel = 1 OR pStyleBOM.Dim2TypeSel = 1 OR pStyleBOM.Dim3TypeSel = 1)
	END 
	ELSE IF @ItemDim1Type <> '00000000-0000-0000-0000-000000000000'
	BEGIN
		INSERT INTO #temp_BOM (StyleMaterialID, MaterialQuantity, MaterialPrice, MaterialBOM, CurrencyType) 
		SELECT pStyleBOM.StyleMaterialID, ISNULL(pStyleBOMItem.MaterialQuantity, 0), 
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
		FROM pStyleBOM INNER JOIN
			pStyleBOMItem ON pStyleBOM.StyleBOMDimensionId = pStyleBOMItem.StyleBOMDimensionId
				AND pStyleBOM.StyleMaterialID = pStyleBOMItem.StyleMaterialID
				AND ItemDim1Id = @StyleBOMDimension1ItemId
			LEFT OUTER JOIN pWorkFlowItem ON pStyleBOM.WorkflowItemId = pWorkFlowItem.WorkFlowItemID
			LEFT OUTER JOIN pStyleSeasonYear ON pStyleBOM.StyleID = pStyleSeasonYear.StyleID 
				AND pWorkFlowItem.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
			LEFT OUTER JOIN pMaterialTradePartner ON pStyleBOM.MaterialID = pMaterialTradePartner.MaterialId
				AND pStyleBOM.TradePartnerRelationshipLevelID = pMaterialTradePartner.TradePartnerRelationshipLevelID
				AND pStyleSeasonYear.SeasonYearID = pMaterialTradePartner.SeasonYearID
			LEFT OUTER JOIN pMaterialTradePartnerColor ON pStyleBOM.MaterialID = pMaterialTradePartnerColor.MaterialID
				AND pMaterialTradePartner.MaterialTradePartnerId = pMaterialTradePartnerColor.MaterialTradePartnerId
				AND ISNULL(pStyleBOMItem.MaterialColorId,'00000000-0000-0000-0000-000000000000') = pMaterialTradePartnerColor.MaterialColorID
				AND ISNULL(pStyleBOMItem.MaterialDimension,'00000000-0000-0000-0000-000000000000') = pMaterialTradePartnerColor.MaterialSizeID
			LEFT JOIN pMaterial ON pStyleBOM.MaterialID = pMaterial.MaterialID
			LEFT OUTER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON pStyleBOM.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
			LEFT OUTER JOIN uTradePartner ON uTradePartner.TradePartnerID = COALESCE(tprl.FactoryID, tprl.VendorID, tprl.AgentID)
		WHERE pStyleBOM.StyleBOMDimensionId = @StyleBOMDimensionId
			AND (pStyleBOM.Dim1TypeSel = 1 OR pStyleBOM.Dim2TypeSel = 1 OR pStyleBOM.Dim3TypeSel = 1)
	END
	
	UPDATE #temp_BOM SET Total = ISNULL(MaterialQuantity, 0.00) * ISNULL(MaterialPrice, 0.00)
		
	-- insert non-dimensional materials
	INSERT INTO #avTemp_BOM (StyleMaterialID, MaterialQuantity, MaterialPrice, MaterialBOM, 
		CurrencyType, StyleBOMItemWeight) 
	SELECT StyleMaterialID, ISNULL(Qty, 0), 
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
	
	UPDATE #avTemp_BOM SET Total = ISNULL(MaterialQuantity, 0.00) * ISNULL(MaterialPrice, 0.00)
	
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
	UPDATE #temp_BOM SET CurrencyType = @ConvCurrType WHERE CurrencyType IS NULL OR CurrencyType = ''
	UPDATE #avTemp_BOM SET CurrencyType = @ConvCurrType WHERE CurrencyType IS NULL OR CurrencyType = ''

	--SELECT * FROM #temp_BOM ORDER BY StyleMaterialID
	--SELECT * FROM #avTemp_BOM ORDER BY StyleMaterialID
	
	IF @ExchangeRateItemID IS NOT NULL
	BEGIN
		UPDATE #temp_BOM SET ConvTotal = Total * @ConvCurrRate / (SELECT TOP 1 Rate FROM sExchangeRateItem WHERE ExchangeRateID = @ExchangeRateID AND CurrencyType = #temp_BOM.CurrencyType)
		UPDATE #avTemp_BOM SET ConvTotal = Total * @ConvCurrRate / (SELECT TOP 1 Rate FROM sExchangeRateItem WHERE ExchangeRateID = @ExchangeRateID AND CurrencyType = #avTemp_BOM.CurrencyType)
	END
	ELSE
	BEGIN
		UPDATE #temp_BOM SET ConvTotal = Total
		UPDATE #avTemp_BOM SET ConvTotal = Total
	END

	/* Calc weighted average Total by StyleMaterial 
	  (because for one material MaterialPrice could be taken from pMaterialTradePartnerColor and pMaterial
	  it causes several rows with the same StyleMaterialID in table #avTemp_BOM) */
	UPDATE #avTemp_BOM 
	SET ConvTotal = ConvTotal * StyleBOMItemWeight / 
	(SELECT COUNT(*) FROM pStyleBOMItem INNER JOIN			
		pStyleBOMDimensionItems ON pStyleBOMItem.StyleBOMDimensionId = pStyleBOMDimensionItems.StyleBOMDimensionId
				AND pStyleBOMItem.StyleBOMDimensionItemID = pStyleBOMDimensionItems.StyleBOMDimensionItemID
				AND pStyleBOMDimensionItems.ItemDim1Active = 1 AND pStyleBOMDimensionItems.ItemDim2Active = 1 AND pStyleBOMDimensionItems.ItemDim3Active = 1
		WHERE StyleMaterialID = #avTemp_BOM.StyleMaterialID)
	WHERE StyleBOMItemWeight <> 0

	--SELECT * FROM #temp_BOM ORDER BY StyleMaterialID
	--SELECT * FROM #avTemp_BOM ORDER BY StyleMaterialID

	/* Save Average Costing */
	SELECT  @Cost = SUM(ConvTotal)
	FROM #avTemp_BOM WHERE MaterialBOM = 1
	
	UPDATE pStyleBOMDimension SET pStyleBOMDimension.AverageCost = @Cost where StyleBOMDimensionID = @StyleBOMDimensionId 
	
	/* Save Costing for particular list of dimensions */
	SELECT  @Cost = SUM(ConvTotal)
	FROM #temp_BOM WHERE MaterialBOM = 1	

	IF @ItemDim3Type <> '00000000-0000-0000-0000-000000000000'
	BEGIN
		UPDATE pStyleBOMDimensionItems 
		SET pStyleBOMDimensionItems.SKUcost=@Cost where	pStyleBOMDimensionItems.ItemDim1Id=@StyleBOMDimension1ItemId AND
		pStyleBOMDimensionItems.ItemDim2Id=@StyleBOMDimension2ItemId AND pStyleBOMDimensionItems.ItemDim3Id=@StyleBOMDimension3ItemId

	END
	ELSE IF @ItemDim2Type <> '00000000-0000-0000-0000-000000000000'
	BEGIN
		UPDATE pStyleBOMDimensionItems 
		SET pStyleBOMDimensionItems.SKUcost=@Cost where	pStyleBOMDimensionItems.ItemDim1Id=@StyleBOMDimension1ItemId AND
		pStyleBOMDimensionItems.ItemDim2Id=@StyleBOMDimension2ItemId AND pStyleBOMDimensionItems.ItemDim3Id IS NULL
	END 
	ELSE IF @ItemDim1Type <> '00000000-0000-0000-0000-000000000000'
	BEGIN
		UPDATE pStyleBOMDimensionItems 
		SET pStyleBOMDimensionItems.SKUcost=@Cost where	pStyleBOMDimensionItems.ItemDim1Id=@StyleBOMDimension1ItemId AND
		pStyleBOMDimensionItems.ItemDim2Id IS NULL AND pStyleBOMDimensionItems.ItemDim3Id IS NULL
	END

	/* final select */
	IF @IsAverage = 1
	BEGIN
	
		SELECT '   ' AS cellSpace, 'BOM Costing  ' AS [Cost Type], ISNULL(@ConvCurrType,'') + ' ' + CAST(SUM(ConvTotal) AS nVARCHAR(10)) + '' AS [Total Cost], '   ' AS cellSpace1
		FROM         #avTemp_BOM WHERE MaterialBOM = 1
		UNION ALL
		SELECT '   ' AS cellSpace, 'Total Costing  ' AS [Cost Type], ISNULL(@ConvCurrType,'') + ' ' +  CAST(SUM(ConvTotal) AS nVARCHAR(10)) + '' AS [Total Cost], '   ' AS cellSpace1
		FROM         #avTemp_BOM
		
	END
	ELSE
	BEGIN
	
		SELECT '   ' AS cellSpace, 'BOM Costing  ' AS [Cost Type], ISNULL(@ConvCurrType,'') + ' ' + CAST(SUM(ConvTotal) AS nVARCHAR(10)) + '' AS [Total Cost], '   ' AS cellSpace1
		FROM         #temp_BOM WHERE MaterialBOM = 1
		UNION ALL
		SELECT '   ' AS cellSpace, 'Total Costing  ' AS [Cost Type], ISNULL(@ConvCurrType,'') + ' ' +  CAST(SUM(ConvTotal) AS nVARCHAR(10)) + '' AS [Total Cost], '   ' AS cellSpace1
		FROM         #temp_BOM

	END

	DROP TABLE #temp_BOM
	DROP TABLE #avTemp_BOM

END

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08722', GetDate())
GO
