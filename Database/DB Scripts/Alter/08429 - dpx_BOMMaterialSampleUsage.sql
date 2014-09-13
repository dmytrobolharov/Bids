IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_BOMMaterialSampleUsage]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_BOMMaterialSampleUsage]
GO

CREATE PROCEDURE [dbo].[dpx_BOMMaterialSampleUsage]
	@MaterialNo NVARCHAR(200) = NULL
	, @StyleNo NVARCHAR(200) = NULL
AS
BEGIN
	CREATE TABLE #tmpMaterials (
		MaterialID UNIQUEIDENTIFIER
		, StyleID UNIQUEIDENTIFIER
		, SeasonYearID UNIQUEIDENTIFIER
		, Qty DECIMAL(18, 3)
		, MaterialPrice DECIMAL(18, 3)
		, Cost DECIMAL(18, 3)
		, Unit DECIMAL(18, 3)
		, TotalProjAmount DECIMAL(18, 3)
		, TotalProjCost DECIMAL(18, 3)
		)

	INSERT INTO #tmpMaterials (MaterialID, StyleID, SeasonYearID, Unit, Qty, MaterialPrice)
	SELECT sb.MaterialID, sh.StyleID, sy.SeasonYearID, 0
		, AVG(CASE
			WHEN sbc.DimBOM = 1 THEN ISNULL(sbi.MaterialQuantity, 0)
			ELSE ISNULL(CAST(sb.Qty AS NUMERIC(18, 3)), 0)
		  END)
		, AVG(CASE
			WHEN sbc.DimBOM = 1 THEN ISNULL(sbi.MaterialPrice, 0)
			ELSE ISNULL(CAST(sb.MaterialPrice AS NUMERIC(18, 3)), 0)
		  END)
	FROM pStyleBOM sb
		INNER JOIN pStyleBOMConfig sbc ON sb.StyleBOMDimensionId = sbc.StyleBOMDimensionID
		LEFT JOIN pStyleBOMItem sbi 
			INNER JOIN pStyleBOMDimensionItems sbdi ON sbi.StyleBOMDimensionItemID = sbdi.StyleBOMDimensionItemID 
				AND sbi.StyleBOMDimensionID = sbdi.StyleBOMDimensionID AND sbdi.ItemDim1Active = 1 AND sbdi.ItemDim2Active = 1 AND sbdi.ItemDim3Active = 1
		ON sb.StyleBOMDimensionId = sbi.StyleBOMDimensionID AND sb.StyleMaterialID = sbi.StyleMaterialID AND sbc.DimBOM = 1
		INNER JOIN pStyleHeader sh ON sb.StyleID = sh.StyleID
		INNER JOIN pWorkFlowItem wfi ON sb.WorkflowItemId = wfi.WorkFlowItemID
		INNER JOIN pStyleSeasonYear ssy ON wfi.StyleSeasonYearID = ssy.StyleSeasonYearID
		INNER JOIN pSeasonYear sy ON ssy.SeasonYearID = sy.SeasonYearID
		INNER JOIN iCustom1 ON sh.DivisionID = iCustom1.CustomID
	WHERE wfi.WorkStatus <> 101
		AND (sb.MaterialNo LIKE '%' + @MaterialNo + '%' OR @MaterialNo IS NULL OR @MaterialNo = '')
		AND (sh.StyleNo LIKE '%' + @StyleNo + '%' OR @StyleNo IS NULL OR @StyleNo = '')
	GROUP BY sb.MaterialID, sh.StyleID, sy.SeasonYearID
	
	UPDATE #tmpMaterials 
	SET Cost = ISNULL(Qty, 0) * ISNULL(MaterialPrice, 0)
	
	UPDATE #tmpMaterials
	SET Unit = (
	SELECT COUNT(pSampleRequestSubmitBOM.SampleRequestSubmitID)
	FROM pStyleBOMDimension
		INNER JOIN pWorkFlowItem ON pStyleBOMDimension.WorkFlowItemID = pWorkFlowItem.WorkFlowItemID
		INNER JOIN pStyleSeasonYear ON pWorkFlowItem.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
		INNER JOIN pSampleRequestBOMTrade ON pStyleBOMDimension.StyleBOMDimensionID = pSampleRequestBOMTrade.StyleBOMDimensionID
		INNER JOIN pSampleRequestSubmitBOM ON pSampleRequestBOMTrade.SampleRequestTradeID = pSampleRequestSubmitBOM.SampleRequestTradeID
	WHERE #tmpMaterials.StyleID = pStyleBOMDimension.StyleID
		AND #tmpMaterials.SeasonYearID = pStyleSeasonYear.SeasonYearID
		AND #tmpMaterials.MaterialID IN (SELECT MaterialID FROM pStyleBOM WHERE StyleBOMDimensionID = pStyleBOMDimension.StyleBOMDimensionID)
		AND pSampleRequestSubmitBOM.SampleWorkflowID <> '95A' -- NOT QA Worksheet
	) + (
	SELECT SUM(pQAsamplbl.SampleNo)
	FROM pStyleBOMDimension
		INNER JOIN pWorkFlowItem ON pStyleBOMDimension.WorkFlowItemID = pWorkFlowItem.WorkFlowItemID
		INNER JOIN pStyleSeasonYear ON pWorkFlowItem.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
		INNER JOIN pSampleRequestBOMTrade ON pStyleBOMDimension.StyleBOMDimensionID = pSampleRequestBOMTrade.StyleBOMDimensionID
		INNER JOIN pSampleRequestWorkflowBOM ON pSampleRequestBOMTrade.SampleRequestTradeID = pSampleRequestWorkflowBOM.SampleRequestTradeID
			AND pSampleRequestWorkflowBOM.SampleWorkflowID = '95A' -- QA Worksheet
		INNER JOIN pSampleRequestSubmitBOM ON pSampleRequestWorkflowBOM.SampleRequestWorkflowID = pSampleRequestSubmitBOM.SampleRequestWorkflowID
		INNER JOIN pQAHeader ON pSampleRequestWorkflowBOM.SampleRequestWorkflowID = pQAHeader.SampleRequestWorkflowID
		INNER JOIN pQAsamplbl ON pQAHeader.SampleRequestHeaderId = pQAsamplbl.SampleRequestHeaderId
	WHERE #tmpMaterials.StyleID = pStyleBOMDimension.StyleID
		AND #tmpMaterials.SeasonYearID = pStyleSeasonYear.SeasonYearID
		AND #tmpMaterials.MaterialID IN (SELECT MaterialID FROM pStyleBOM WHERE StyleBOMDimensionID = pStyleBOMDimension.StyleBOMDimensionID)
	)	

	UPDATE #tmpMaterials 
	SET TotalProjAmount = ISNULL(Unit, 0) * ISNULL(Qty, 0), 
		TotalProjCost = ISNULL(Unit, 0) * ISNULL(Cost, 0)


	SELECT sy.Season
		, sy.Year
		, d.CustomID AS DivisionID
		, d.Custom AS Division
		, ct.ComponentDescription
		, m.MaterialNo
		, m.MaterialName
		, sh.StyleNo
		, sh.Description
		, tm.*
	FROM #tmpMaterials tm
		INNER JOIN pMaterial m ON tm.MaterialID = m.MaterialID
		INNER JOIN pComponentType ct ON m.MaterialType = ct.ComponentTypeID
		INNER JOIN pSeasonYear sy ON tm.SeasonYearID = sy.SeasonYearID
		INNER JOIN pStyleHeader sh ON tm.StyleID = sh.StyleID
		INNER JOIN iCustom1 d ON sh.DivisionID = d.CustomID
	ORDER BY sy.Year DESC, sy.Season, Division, ct.ComponentDescription, m.MaterialNo, sh.StyleNo


	DROP TABLE #tmpMaterials

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08429', GetDate())
GO
