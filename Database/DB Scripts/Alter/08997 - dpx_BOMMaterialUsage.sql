IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_BOMMaterialUsage]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_BOMMaterialUsage]
GO

CREATE PROCEDURE [dbo].[dpx_BOMMaterialUsage]

AS
BEGIN
	DECLARE @tmpMaterials TABLE (
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

	INSERT INTO @tmpMaterials (MaterialID, StyleID, SeasonYearID, Unit, Qty, MaterialPrice)
	SELECT sb.MaterialID, sb.StyleID, sy.SeasonYearID, ISNULL(sch.StyleCostingCustomField8, 0)
		, AVG(CASE
			WHEN sbc.DimBOM = 1 THEN ISNULL(sbi.MaterialQuantity, 0)
			ELSE ISNULL(CAST(sb.Qty AS NUMERIC(18, 3)), 0)
		  END)
		, AVG(CASE
			WHEN sbc.DimBOM = 1 THEN ISNULL(sbi.MaterialPrice, 0)
			ELSE ISNULL(CAST(sb.MaterialPrice AS NUMERIC(18, 3)), 0)
		  END)
	FROM pStyleBOM sb
		INNER JOIN pWorkFlowItem wfi ON sb.WorkflowItemId = wfi.WorkFlowItemID
		INNER JOIN pStyleSeasonYear ssy ON wfi.StyleSeasonYearID = ssy.StyleSeasonYearID
			AND wfi.StyleSeasonYearID = ssy.StyleSeasonYearID
		INNER JOIN pSeasonYear sy ON ssy.SeasonYearID = sy.SeasonYearID
		LEFT JOIN pStyleBOMItem sbi 
			INNER JOIN pStyleBOMConfig sbc ON sbi.StyleBOMDimensionId = sbc.StyleBOMDimensionID
			INNER JOIN pStyleBOMDimensionItems sbdi ON sbi.StyleBOMDimensionItemID = sbdi.StyleBOMDimensionItemID 
				AND ((sbi.StyleBOMDimensionID = sbdi.StyleBOMDimensionID AND sbdi.ItemDim1Active = 1 AND sbdi.ItemDim2Active = 1 AND sbdi.ItemDim3Active = 1 AND sbc.DimBOM = 1) OR sbc.DimBOM = 0)
		ON sb.StyleBOMDimensionId = sbi.StyleBOMDimensionID AND sb.StyleMaterialID = sbi.StyleMaterialID
		LEFT JOIN pStyleCostingHeader sch ON ssy.StyleSeasonYearID = sch.StyleSeasonYearID
	WHERE wfi.WorkStatus <> 101
	GROUP BY sb.MaterialID, sb.StyleID, sy.SeasonYearID, sch.StyleCostingCustomField8

	UPDATE @tmpMaterials 
	SET Cost = ISNULL(Qty, 0) * ISNULL(MaterialPrice, 0)
		, TotalProjAmount = ISNULL(Unit, 0) * ISNULL(Qty, 0)
		, TotalProjCost = ISNULL(Unit, 0) * ISNULL(Qty, 0) * ISNULL(MaterialPrice, 0)

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
	FROM @tmpMaterials tm
		INNER JOIN pMaterial m ON tm.MaterialID = m.MaterialID
		INNER JOIN pComponentType ct ON m.MaterialType = ct.ComponentTypeID
		INNER JOIN pSeasonYear sy ON tm.SeasonYearID = sy.SeasonYearID
		INNER JOIN pStyleHeader sh ON tm.StyleID = sh.StyleID
		INNER JOIN iCustom1 d ON sh.DivisionID = d.CustomID
	ORDER BY sy.Year DESC, sy.Season, Division, ct.ComponentDescription, m.MaterialNo, sh.StyleNo

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08997', GetDate())
GO