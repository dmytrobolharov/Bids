IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSKUItems_TotalUnits_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSKUItems_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleSKUItems_TotalUnits_SELECT]
	@StyleSKUItemID UNIQUEIDENTIFIER = NULL
AS
BEGIN
	;WITH dims as (
	SELECT sbdi.StyleBOMDimensionID, V.* FROM pStyleBOMDimensionItem sbdi		
	CROSS APPLY (VALUES (ItemDim1Id, ItemDim1Name, ItemDim1Active, ItemDim1TypeId, ItemDim1Sort),
						(ItemDim2Id, ItemDim2Name, ItemDim2Active, ItemDim2TypeId, ItemDim2Sort),
						(ItemDim3Id, ItemDim3Name, ItemDim3Active, ItemDim3TypeId, ItemDim3Sort))
					   V(DimID,      DimName,      DimActive,      ItemDmTypeID,   DimSort)
	LEFT JOIN (SELECT ItemDim1TypeID AS value FROM pStyleSKUItem WHERE StyleSKUItemID = @StyleSKUItemID
				UNION ALL
				SELECT ItemDim2TypeID FROM pStyleSKUItem WHERE StyleSKUItemID = @StyleSKUItemID
				UNION ALL
				SELECT ItemDim3TypeID FROM pStyleSKUItem WHERE StyleSKUItemID = @StyleSKUItemID
				) sd ON V.ItemDmTypeID = sd.value
	WHERE V.DimActive = 1 AND (sd.value IS NULL OR sd.value IS NOT NULL AND V.DimName LIKE '%' +  + '%')
	)
	SELECT SUM(ssis.TotalWSUnits) AS TotalWSUnits, SUM(ssis.TotalRUnits) AS TotalRUnits, SUM(ssis.TotalEUnits) AS TotalEUnits
	INTO #tmpItems
	FROM pStyleSKUItem ssi
	INNER JOIN pStyleSKUItems ssis ON ssi.StyleSKUItemID = ssis.StyleSKUItemID
	LEFT JOIN dims dims1 ON ssi.StyleBOMDimensionID = dims1.StyleBOMDimensionID
		AND ssis.ItemDim1ID = dims1.DimID
	LEFT JOIN dims dims2 ON ssi.StyleBOMDimensionID = dims2.StyleBOMDimensionID
		AND ssis.ItemDim2ID = dims2.DimID
	LEFT JOIN dims dims3 ON ssi.StyleBOMDimensionID = dims3.StyleBOMDimensionID
		AND ssis.ItemDim3ID = dims3.DimID
	WHERE ssi.StyleSKUItemID = @StyleSKUItemID
		AND (ssis.ItemDim1ID  IS NULL OR ssis.ItemDim1ID IS NOT NULL AND dims1.DimID IS NOT NULL)
		AND (ssis.ItemDim2ID  IS NULL OR ssis.ItemDim2ID IS NOT NULL AND dims2.DimID IS NOT NULL)
		AND (ssis.ItemDim3ID  IS NULL OR ssis.ItemDim3ID IS NOT NULL AND dims3.DimID IS NOT NULL)
		
	EXEC('SELECT * FROM #tmpItems ' + '')

	DROP TABLE #tmpItems
	END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08594', GetDate())
GO
