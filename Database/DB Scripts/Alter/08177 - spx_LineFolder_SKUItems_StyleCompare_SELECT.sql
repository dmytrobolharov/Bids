IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_SKUItems_StyleCompare_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_SKUItems_StyleCompare_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_LineFolder_SKUItems_StyleCompare_SELECT]
	@LineFolderSKUHeaderID UNIQUEIDENTIFIER,	
	@StyleID UNIQUEIDENTIFIER
AS
BEGIN

	;WITH dims as (
		SELECT sbdi.StyleBOMDimensionID, V.* FROM pStyleBOMDimensionItem sbdi		
		CROSS APPLY (VALUES (ItemDim1Id, ItemDim1Name, ItemDim1Active, ItemDim1TypeId, ItemDim1Sort),
							(ItemDim2Id, ItemDim2Name, ItemDim2Active, ItemDim2TypeId, ItemDim2Sort),
							(ItemDim3Id, ItemDim3Name, ItemDim3Active, ItemDim3TypeId, ItemDim3Sort))
						   V(DimID,      DimName,      DimActive,      ItemDmTypeID,   DimSort)
		WHERE V.DimActive = 1 AND V.DimID IS NOT NULL AND sbdi.StyleID = @StyleID
	)
	SELECT 
		sh.StyleID
		,sh.StyleNo
		,sh.Description
		,AVG(ISNULL(sch.StyleCostingCustomField10,0)) as TargetCostUnit
		,AVG(ISNULL(sch.StyleCostingCustomField6,0)) as WSUnits
		,AVG(ISNULL(sch.StyleCostingCustomField7,0)) as RUnits
		,AVG(ISNULL(sch.StyleCostingCustomField5,0)) as EUnits
		,(AVG(ISNULL(sch.StyleCostingCustomField6,0)) - SUM(ssis.TotalWSUnits)) as DeltaWSUnits
		,(AVG(ISNULL(sch.StyleCostingCustomField7,0)) - SUM(ssis.TotalRUnits)) as DeltaRUnits
		,(AVG(ISNULL(sch.StyleCostingCustomField5,0)) - SUM(ssis.TotalEUnits)) as DeltaEUnits
	FROM pStyleSKUItem ssi
		INNER JOIN pStyleSKUItems ssis ON ssi.StyleSKUItemID = ssis.StyleSKUItemID
		INNER JOIN pWorkFlowItem wi ON ssi.WorkflowItemID = wi.WorkFlowItemID
		INNER JOIN pStyleHeader sh ON wi.StyleID = sh.StyleID
		LEFT JOIN pStyleCostingHeader sch ON wi.StyleSeasonYearID = sch.StyleSeasonYearID
		LEFT JOIN dims dims1 ON ssi.StyleBOMDimensionID = dims1.StyleBOMDimensionID
			AND ssis.ItemDim1ID = dims1.DimID
		LEFT JOIN dims dims2 ON ssi.StyleBOMDimensionID = dims2.StyleBOMDimensionID
			AND ssis.ItemDim2ID = dims2.DimID
		LEFT JOIN dims dims3 ON ssi.StyleBOMDimensionID = dims3.StyleBOMDimensionID
			AND ssis.ItemDim3ID = dims3.DimID
	WHERE ((wi.StyleID = @StyleID AND (ssi.PlanningSKUHeaderID = @LineFolderSKUHeaderID OR ssi.LineFolderSKUHeaderID = @LineFolderSKUHeaderID))
		OR (@StyleID IS NULL))
		AND (ssis.ItemDim1ID  IS NULL OR ssis.ItemDim1ID IS NOT NULL AND dims1.DimID IS NOT NULL)
		AND (ssis.ItemDim2ID  IS NULL OR ssis.ItemDim2ID IS NOT NULL AND dims2.DimID IS NOT NULL)
		AND (ssis.ItemDim3ID  IS NULL OR ssis.ItemDim3ID IS NOT NULL AND dims3.DimID IS NOT NULL)
	GROUP BY sh.StyleID
		,sh.StyleNo
		,sh.Description
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08177', GetDate())
GO
