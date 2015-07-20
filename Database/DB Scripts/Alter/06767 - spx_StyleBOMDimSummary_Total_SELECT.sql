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
	@IsBOMDimensional int = 1
)

AS

DECLARE @ItemDim1Type uniqueidentifier
DECLARE @ItemDim2Type uniqueidentifier
DECLARE @ItemDim3Type uniqueidentifier

DECLARE @Count_DimItems int

if @StyleBOMDimension1ItemId = '' set @StyleBOMDimension1ItemId = '00000000-0000-0000-0000-000000000000'
if @StyleBOMDimension2ItemId = '' set @StyleBOMDimension2ItemId = '00000000-0000-0000-0000-000000000000'
if @StyleBOMDimension3ItemId = '' set @StyleBOMDimension3ItemId = '00000000-0000-0000-0000-000000000000'

BEGIN

IF @IsBOMDimensional = 0
BEGIN

	SELECT '   ' AS cellSpace, 'BOM Costing  ' AS [Cost Type], '$' + CAST(CAST(SUM(ISNULL(Qty,0) * ISNULL(MaterialPrice,0)) AS DECIMAL(18,2)) AS nVARCHAR(10)) + '' AS [Total Cost], '   ' AS cellSpace1
	FROM         pStyleBOM WHERE StyleBOMDimensionId = @StyleBOMDimensionId AND MaterialBOM = 1
	UNION ALL
	SELECT '   ' AS cellSpace, 'Total Costing  ' AS [Cost Type], '$' +  CAST(CAST(SUM(ISNULL(Qty,0) * ISNULL(MaterialPrice,0)) AS DECIMAL(18,2)) AS nVARCHAR(10)) + '' AS [Total Cost], '   ' AS cellSpace1
	FROM         pStyleBOM WHERE StyleBOMDimensionId = @StyleBOMDimensionId

END
ELSE
BEGIN

	-- Getting  Dimensions Types
	SELECT @ItemDim1Type = ItemDim1TypeId, @ItemDim2Type = ItemDim2TypeId, @ItemDim3Type = ItemDim3TypeId FROM pStyleBOMDimension
	WHERE StyleBOMDimensionID = @StyleBOMDimensionId

	-- Temporary table for particular dimensions
	CREATE TABLE #temp_BOM (
		StyleMaterialID uniqueidentifier,
		MaterialQuantity decimal(19,3),
		MaterialPrice decimal(19,3),
		Total decimal(19,3),
		MaterialBOM int
	)

	-- Temporary table for average costing
	CREATE TABLE #avTemp_BOM (
		StyleMaterialID uniqueidentifier,
		MaterialQuantity decimal(19,3),
		MaterialPrice decimal(19,3),
		Total decimal(19,3),
		MaterialBOM int
	)
	DECLARE @Cost As decimal(19,3)
	
	-- insert non-dimensional materials
	INSERT INTO #temp_BOM (StyleMaterialID, MaterialQuantity, MaterialPrice, Total, MaterialBOM) 
	SELECT StyleMaterialID, Qty, 
		MaterialPrice = CASE WHEN pMaterialTradePartnerColor.MaterialTradePartnerColorID IS NOT NULL THEN CAST(pMaterialTradePartnerColor.MaterialTradeColor8 AS DECIMAL(18,2)) ELSE pStyleBOM.MaterialPrice END, 
		Total = ISNULL(Qty,0) * ISNULL(CASE WHEN pMaterialTradePartnerColor.MaterialTradePartnerColorID IS NOT NULL THEN CAST(pMaterialTradePartnerColor.MaterialTradeColor8 AS DECIMAL(18,2)) ELSE pStyleBOM.MaterialPrice END,0), 
		MaterialBOM
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
	WHERE StyleBOMDimensionId = @StyleBOMDimensionId
		AND (pStyleBOM.Dim1TypeSel = 0 AND pStyleBOM.Dim2TypeSel = 0 AND pStyleBOM.Dim3TypeSel = 0)

	-- insert dimensional materials
	IF @ItemDim3Type <> '00000000-0000-0000-0000-000000000000'
	BEGIN
		INSERT INTO #temp_BOM (StyleMaterialID, MaterialQuantity, MaterialPrice, Total, MaterialBOM) 
		SELECT pStyleBOM.StyleMaterialID, pStyleBOMItem.MaterialQuantity, 
			MaterialPrice = CASE WHEN pMaterialTradePartnerColor.MaterialTradePartnerColorID IS NOT NULL THEN CAST(pMaterialTradePartnerColor.MaterialTradeColor8 AS DECIMAL(18,2)) ELSE pStyleBOMItem.MaterialPrice END, 
			Total = ISNULL(pStyleBOMItem.MaterialQuantity,0) * ISNULL(CASE WHEN pMaterialTradePartnerColor.MaterialTradePartnerColorID IS NOT NULL THEN CAST(pMaterialTradePartnerColor.MaterialTradeColor8 AS DECIMAL(18,2)) ELSE pStyleBOMItem.MaterialPrice END,0), 
			MaterialBOM
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
		WHERE pStyleBOM.StyleBOMDimensionId = @StyleBOMDimensionId
			AND (pStyleBOM.Dim1TypeSel = 1 OR pStyleBOM.Dim2TypeSel = 1 OR pStyleBOM.Dim3TypeSel = 1)
	END
	ELSE IF @ItemDim2Type <> '00000000-0000-0000-0000-000000000000'
	BEGIN
		INSERT INTO #temp_BOM (StyleMaterialID, MaterialQuantity, MaterialPrice, Total, MaterialBOM) 
		SELECT pStyleBOM.StyleMaterialID, pStyleBOMItem.MaterialQuantity, 
			MaterialPrice = CASE WHEN pMaterialTradePartnerColor.MaterialTradePartnerColorID IS NOT NULL THEN CAST(pMaterialTradePartnerColor.MaterialTradeColor8 AS DECIMAL(18,2)) ELSE pStyleBOMItem.MaterialPrice END, 
			Total = ISNULL(pStyleBOMItem.MaterialQuantity,0) * ISNULL(CASE WHEN pMaterialTradePartnerColor.MaterialTradePartnerColorID IS NOT NULL THEN CAST(pMaterialTradePartnerColor.MaterialTradeColor8 AS DECIMAL(18,2)) ELSE pStyleBOMItem.MaterialPrice END,0), 
			MaterialBOM
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
		WHERE pStyleBOM.StyleBOMDimensionId = @StyleBOMDimensionId
			AND (pStyleBOM.Dim1TypeSel = 1 OR pStyleBOM.Dim2TypeSel = 1 OR pStyleBOM.Dim3TypeSel = 1)
	END 
	ELSE IF @ItemDim1Type <> '00000000-0000-0000-0000-000000000000'
	BEGIN
		INSERT INTO #temp_BOM (StyleMaterialID, MaterialQuantity, MaterialPrice, Total, MaterialBOM) 
		SELECT pStyleBOM.StyleMaterialID, pStyleBOMItem.MaterialQuantity, 
			MaterialPrice = CASE WHEN pMaterialTradePartnerColor.MaterialTradePartnerColorID IS NOT NULL THEN CAST(pMaterialTradePartnerColor.MaterialTradeColor8 AS DECIMAL(18,2)) ELSE pStyleBOMItem.MaterialPrice END, 
			Total = ISNULL(pStyleBOMItem.MaterialQuantity,0) * ISNULL(CASE WHEN pMaterialTradePartnerColor.MaterialTradePartnerColorID IS NOT NULL THEN CAST(pMaterialTradePartnerColor.MaterialTradeColor8 AS DECIMAL(18,2)) ELSE pStyleBOMItem.MaterialPrice END,0), 
			MaterialBOM
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
		WHERE pStyleBOM.StyleBOMDimensionId = @StyleBOMDimensionId
			AND (pStyleBOM.Dim1TypeSel = 1 OR pStyleBOM.Dim2TypeSel = 1 OR pStyleBOM.Dim3TypeSel = 1)
	END
	
		
	-- insert non-dimensional materials
	INSERT INTO #avTemp_BOM (StyleMaterialID, MaterialQuantity, MaterialPrice, Total, MaterialBOM) 
	SELECT StyleMaterialID, Qty, 
		MaterialPrice = CASE WHEN pMaterialTradePartnerColor.MaterialTradePartnerColorID IS NOT NULL THEN CAST(pMaterialTradePartnerColor.MaterialTradeColor8 AS DECIMAL(18,2)) ELSE pStyleBOM.MaterialPrice END, 
		Total = ISNULL(Qty,0) * ISNULL(CASE WHEN pMaterialTradePartnerColor.MaterialTradePartnerColorID IS NOT NULL THEN CAST(pMaterialTradePartnerColor.MaterialTradeColor8 AS DECIMAL(18,2)) ELSE pStyleBOM.MaterialPrice END,0), 
		MaterialBOM
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
	WHERE StyleBOMDimensionId = @StyleBOMDimensionId
		AND (pStyleBOM.Dim1TypeSel = 0 AND pStyleBOM.Dim2TypeSel = 0 AND pStyleBOM.Dim3TypeSel = 0)

	-- insert dimensional materials
	INSERT INTO #avTemp_BOM (StyleMaterialID, MaterialQuantity, MaterialPrice, Total, MaterialBOM) 
	SELECT pStyleBOM.StyleMaterialID, AVG(pStyleBOMItem.MaterialQuantity), 
			AVG(CASE WHEN pMaterialTradePartnerColor.MaterialTradePartnerColorID IS NOT NULL THEN CAST(pMaterialTradePartnerColor.MaterialTradeColor8 AS DECIMAL(18,2)) ELSE pStyleBOMItem.MaterialPrice END), 
			AVG(ISNULL(pStyleBOMItem.MaterialQuantity,0) * ISNULL(CASE WHEN pMaterialTradePartnerColor.MaterialTradePartnerColorID IS NOT NULL THEN CAST(pMaterialTradePartnerColor.MaterialTradeColor8 AS DECIMAL(18,2)) ELSE pStyleBOMItem.MaterialPrice END,0)), 
			MaterialBOM
	FROM pStyleBOM INNER JOIN
			pStyleBOMItem ON pStyleBOM.StyleBOMDimensionId = pStyleBOMItem.StyleBOMDimensionId AND pStyleBOM.StyleMaterialID = pStyleBOMItem.StyleMaterialID
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
	WHERE pStyleBOM.StyleBOMDimensionId = @StyleBOMDimensionId
		AND (pStyleBOM.Dim1TypeSel = 1 OR pStyleBOM.Dim2TypeSel = 1 OR pStyleBOM.Dim3TypeSel = 1)
	GROUP BY pStyleBOM.StyleMaterialID, MaterialBOM

	/* Save Average Costing */
	SELECT  @Cost = SUM(Total)
	FROM #avTemp_BOM WHERE MaterialBOM = 1
	
	UPDATE pStyleBOMDimension SET pStyleBOMDimension.AverageCost=@Cost where	StyleBOMDimensionID = @StyleBOMDimensionId 
	
	/* Save Costing for particular list of dimensions */
	SELECT  @Cost = SUM(Total)
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

		SELECT '   ' AS cellSpace, 'BOM Costing  ' AS [Cost Type], '$' + CAST(SUM(Total) AS nVARCHAR(10)) + '' AS [Total Cost], '   ' AS cellSpace1
		FROM         #avTemp_BOM WHERE MaterialBOM = 1
		UNION ALL
		SELECT '   ' AS cellSpace, 'Total Costing  ' AS [Cost Type], '$' +  CAST(SUM(Total) AS nVARCHAR(10)) + '' AS [Total Cost], '   ' AS cellSpace1
		FROM         #avTemp_BOM
		
	END
	ELSE
	BEGIN
	
		SELECT '   ' AS cellSpace, 'BOM Costing  ' AS [Cost Type], '$' + CAST(SUM(Total) AS nVARCHAR(10)) + '' AS [Total Cost], '   ' AS cellSpace1
		FROM         #temp_BOM WHERE MaterialBOM = 1
		UNION ALL
		SELECT '   ' AS cellSpace, 'Total Costing  ' AS [Cost Type], '$' +  CAST(SUM(Total) AS nVARCHAR(10)) + '' AS [Total Cost], '   ' AS cellSpace1
		FROM         #temp_BOM
	
	END

	DROP TABLE #temp_BOM
	DROP TABLE #avTemp_BOM

END

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06767', GetDate())
GO
