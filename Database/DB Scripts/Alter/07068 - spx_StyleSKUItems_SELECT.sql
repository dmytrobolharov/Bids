IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSKUItems_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSKUItems_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleSKUItems_SELECT]
	@WorkflowItemID UNIQUEIDENTIFIER,
	@SearchCond NVARCHAR(MAX) = '',
	@SelectedDimensions as NVARCHAR(200) = '',
	@DimensionValue as NVARCHAR(MAX) = ''
AS
BEGIN

	-- apply changes from corresponding BOM (BOM Items can be added, and currently color items can also be deleted) --
	DECLARE @StyleSKUItemID UNIQUEIDENTIFIER = (SELECT StyleSKUItemID FROM pStyleSKUItem WHERE WorkflowItemID = @WorkflowItemID)
	;WITH items
	AS (SELECT V.*
		FROM pStyleSKUItem ski
		CROSS APPLY (VALUES (ItemDim1TypeId, 1),
							(ItemDim2TypeId, 2),
							(ItemDim3TypeId, 3)) 
						   V(ItemDimTypeID, DimNo)
		WHERE StyleSKUItemID = @StyleSKUItemID
			AND V.ItemDimTypeID <> '00000000-0000-0000-0000-000000000000')
	, dims AS (
		SELECT V.*
		FROM pStyleBOMDimensionItem sbdi
		INNER JOIN pStyleSKUItem ski ON sbdi.StyleBOMDimensionID = ski.StyleBOMDimensionID
		CROSS APPLY (VALUES (sbdi.ItemDim1TypeId, ItemDim1Id),
							(sbdi.ItemDim2TypeId, ItemDim2Id),
							(sbdi.ItemDim3TypeId, ItemDim3Id)) 
						   V(ItemDimTypeID, ItemDimID)
		WHERE ski.StyleSKUItemID = @StyleSKUItemID
			AND V.ItemDimID IS NOT NULL)
	, boms AS (
		SELECT items.*, dims.ItemDimID
		FROM items INNER JOIN dims ON items.ItemDimTypeID = dims.ItemDimTypeID)
	, cte AS (
		SELECT ItemDimID AS ItemDim1ID,
			CAST(NULL AS UNIQUEIDENTIFIER) AS ItemDim2ID,
			CAST(NULL AS UNIQUEIDENTIFIER) AS ItemDim3ID,
			DimNo
		FROM boms WHERE DimNo = 1
		
		UNION ALL
		
		SELECT CASE WHEN boms.DimNo = 1 THEN boms.ItemDimID ELSE cte.ItemDim1ID END AS ItemDim1ID,
			CASE WHEN boms.DimNo = 2 THEN boms.ItemDimID ELSE cte.ItemDim2ID END AS ItemDim2ID,
			CASE WHEN boms.DimNo = 3 THEN boms.ItemDimID ELSE cte.ItemDim3ID END AS ItemDim3ID,
			boms.DimNo
		FROM cte
		INNER JOIN boms ON cte.DimNo = boms.DimNo - 1)
	MERGE pStyleSKUItems T
	USING (SELECT * FROM cte WHERE DimNo = (SELECT COUNT(*) FROM items)) S 
		ON (ISNULL(T.ItemDim1ID, '00000000-0000-0000-0000-000000000000') = ISNULL(S.ItemDim1ID, '00000000-0000-0000-0000-000000000000')
		AND ISNULL(T.ItemDim2ID, '00000000-0000-0000-0000-000000000000') = ISNULL(S.ItemDim2ID, '00000000-0000-0000-0000-000000000000')
		AND ISNULL(T.ItemDim3ID, '00000000-0000-0000-0000-000000000000') = ISNULL(S.ItemDim3ID, '00000000-0000-0000-0000-000000000000'))
		AND T.StyleSKUItemID = @StyleSKUItemID
	WHEN NOT MATCHED BY TARGET
		THEN INSERT (StyleSKUItemID, ItemDim1ID, ItemDim2ID, ItemDim3ID, Delivery1StatusID, Delivery2StatusID, Delivery3StatusID)
			 VALUES (@StyleSKUItemID, S.ItemDim1ID, S.ItemDim2ID, S.ItemDim3ID, 100, 100, 100)
	WHEN NOT MATCHED BY SOURCE AND T.StyleSKUItemID = @StyleSKUItemID
		THEN DELETE;
	-- ************************************ --

	-- recalculate fields --
	-- ****************** --
	UPDATE ssis SET 
		Delivery1WSUnits = CASE WHEN Delivery1StatusID = 500 THEN 0 ELSE Delivery1WSUnits END,
		Delivery1RUnits = CASE WHEN Delivery1StatusID = 500 THEN 0 ELSE Delivery1RUnits END,
		Delivery1EUnits = CASE WHEN Delivery1StatusID = 500 THEN 0 ELSE Delivery1EUnits END,
		
		Delivery2WSUnits = CASE WHEN Delivery2StatusID = 500 THEN 0 ELSE Delivery2WSUnits END,
		Delivery2RUnits = CASE WHEN Delivery2StatusID = 500 THEN 0 ELSE Delivery2RUnits END,
		Delivery2EUnits = CASE WHEN Delivery2StatusID = 500 THEN 0 ELSE Delivery2EUnits END,
		
		Delivery3WSUnits = CASE WHEN Delivery3StatusID = 500 THEN 0 ELSE Delivery3WSUnits END,
		Delivery3RUnits = CASE WHEN Delivery3StatusID = 500 THEN 0 ELSE Delivery3RUnits END,
		Delivery3EUnits = CASE WHEN Delivery3StatusID = 500 THEN 0 ELSE Delivery3EUnits END
	FROM pStyleSKUItem ssi
	INNER JOIN pStyleSKUItems ssis ON ssi.StyleSKUItemID = ssis.StyleSKUItemID
	WHERE ssi.WorkflowItemID = @WorkflowItemID
	
	UPDATE ssis SET
		TotalWSUnits = Delivery1WSUnits + Delivery2WSUnits + Delivery3WSUnits,
		TotalRUnits = Delivery1RUnits + Delivery2RUnits + Delivery3RUnits,
		TotalEUnits = Delivery1EUnits + Delivery2EUnits + Delivery3EUnits
	FROM pStyleSKUItem ssi
	INNER JOIN pStyleSKUItems ssis ON ssi.StyleSKUItemID = ssis.StyleSKUItemID
	WHERE ssi.WorkflowItemID = @WorkflowItemID
	
	UPDATE ssis SET
		TotalUnits = TotalWSUnits + TotalRUnits + TotalEUnits
	FROM pStyleSKUItem ssi
	INNER JOIN pStyleSKUItems ssis ON ssi.StyleSKUItemID = ssis.StyleSKUItemID
	WHERE ssi.WorkflowItemID = @WorkflowItemID
	-- ****************** --
	
	;WITH dims as (
		SELECT sbdi.StyleBOMDimensionID, V.* FROM pStyleBOMDimensionItem sbdi		
		CROSS APPLY (VALUES (ItemDim1Id, ItemDim1Name, ItemDim1Active, ItemDim1TypeId, ItemDim1Sort),
							(ItemDim2Id, ItemDim2Name, ItemDim2Active, ItemDim2TypeId, ItemDim2Sort),
							(ItemDim3Id, ItemDim3Name, ItemDim3Active, ItemDim3TypeId, ItemDim3Sort))
						   V(DimID,      DimName,      DimActive,      ItemDmTypeID,   DimSort)
		LEFT JOIN dbo.fnx_Split(@SelectedDimensions, ',') sd ON V.ItemDmTypeID = sd.value
		WHERE V.DimActive = 1
			AND (sd.value IS NULL OR sd.value IS NOT NULL AND V.DimName LIKE '%' + @DimensionValue + '%')
	)
	SELECT ssis.*, 
		dims1.DimName as ItemDim1Name,
		dims2.DimName as ItemDim2Name,
		dims3.DimName as ItemDim3Name
	INTO #tmpItems
	FROM pStyleSKUItem ssi
	INNER JOIN pStyleSKUItems ssis ON ssi.StyleSKUItemID = ssis.StyleSKUItemID
	LEFT JOIN dims dims1 ON ssi.StyleBOMDimensionID = dims1.StyleBOMDimensionID
		AND ssis.ItemDim1ID = dims1.DimID
	LEFT JOIN dims dims2 ON ssi.StyleBOMDimensionID = dims2.StyleBOMDimensionID
		AND ssis.ItemDim2ID = dims2.DimID
	LEFT JOIN dims dims3 ON ssi.StyleBOMDimensionID = dims3.StyleBOMDimensionID
		AND ssis.ItemDim3ID = dims3.DimID
	WHERE ssi.WorkflowItemID = @WorkflowItemID	
		AND (ssis.ItemDim1ID  IS NULL OR ssis.ItemDim1ID IS NOT NULL AND dims1.DimID IS NOT NULL)
		AND (ssis.ItemDim2ID  IS NULL OR ssis.ItemDim2ID IS NOT NULL AND dims2.DimID IS NOT NULL)
		AND (ssis.ItemDim3ID  IS NULL OR ssis.ItemDim3ID IS NOT NULL AND dims3.DimID IS NOT NULL)
	ORDER BY dims1.DimSort, dims2.DimSort, dims3.DimSort
	
	EXEC('SELECT * FROM #tmpItems ' + @SearchCond)
	
	DROP TABLE #tmpItems
	
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07068', GetDate())
GO
