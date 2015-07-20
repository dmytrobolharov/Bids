IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_SKUItems_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_SKUItems_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_SKUItems_SELECT]
	@PlanningSKUHeaderID UNIQUEIDENTIFIER,	
	@SearchCond NVARCHAR(MAX) = '',
	@SelectedDimensions as NVARCHAR(200) = '',
	@DimensionValue as NVARCHAR(MAX) = ''
AS
BEGIN

	-- update style sku items
	DECLARE @WFIs TABLE(ROW INT IDENTITY(1, 1), WorkflowItemID UNIQUEIDENTIFIER)
	
	INSERT INTO @WFIs(WorkflowItemID)
	SELECT ssi.WorkflowItemID 
	FROM pStyleSKUItem ssi
	WHERE ssi.PlanningSKUHeaderID = @PlanningSKUHeaderID
	
	DECLARE @ROW INT = 1,
			@TOTAL INT = (SELECT COUNT(*) FROM @WFIs);
		
	WHILE @ROW <= @TOTAL
	BEGIN
		DECLARE @WorkflowItemID UNIQUEIDENTIFIER = (SELECT WorkflowItemID FROM @WFIs WHERE ROW = @ROW)
				
		exec spx_StyleSKUItems_Logic_UPDATE @WorkflowItemID = @WorkflowItemID
	
		SET @ROW = @ROW + 1
	END
	
	DECLARE @SKUHeaderDimTypeList NVARCHAR(MAX)

	SELECT @SKUHeaderDimTypeList = COALESCE(@SKUHeaderDimTypeList + ',', '') + 
	'NULL AS [' + CAST(pshdt.DimTypeID AS NVARCHAR(50)) + ']'
	FROM pPlanningSKUHeaderDimType pshdt
	INNER JOIN pPlanningSKUHeader psh ON pshdt.PlanningSKUHeaderID = psh.PlanningSKUHeaderID
	WHERE psh.PlanningSKUHeaderID = @PlanningSKUHeaderID ORDER BY Position
	
	
	;WITH dims as (
		SELECT sbdi.StyleBOMDimensionID, V.* FROM pStyleBOMDimensionItem sbdi		
		CROSS APPLY (VALUES (ItemDim1Id, ItemDim1Name, ItemDim1Active, ItemDim1TypeId, ItemDim1Sort),
							(ItemDim2Id, ItemDim2Name, ItemDim2Active, ItemDim2TypeId, ItemDim2Sort),
							(ItemDim3Id, ItemDim3Name, ItemDim3Active, ItemDim3TypeId, ItemDim3Sort))
						   V(DimID,      DimName,      DimActive,      ItemDmTypeID,   DimSort)
		LEFT JOIN dbo.fnx_Split(@SelectedDimensions, ',') sd ON V.ItemDmTypeID = sd.value
		WHERE (sd.value IS NULL OR sd.value IS NOT NULL AND V.DimName LIKE '%' + @DimensionValue + '%')
	)
	SELECT sh.StyleID, sh.StyleNo, ssis.*, 
		d.Custom AS DivisionName, st.StyleTypeDescription,
		sc.StyleCategory, sbc.Custom AS SubCategory,
		ssi.ItemDim1TypeID, ssi.ItemDim2TypeID, ssi.ItemDim3TypeID, ssi.WorkflowItemID,
		sh.DivisionID, sh.StyleType, sh.StyleCategory AS StyleCategoryId, sh.SubCategoryId, d.BrandID,
		'<img src="' + REPLACE(dbo.fnx_GetStreamingImageSmallPath(sh.DesignSketchID, sh.DesignSketchVersion), '?S=500', '?S=50') + '" alt="" />' AS Thumbnail,
		CASE WHEN pi.PlanningItemDrop IN ('1', 'Yes') THEN 1 ELSE 0 END AS PlanningItemDrop,
		CASE WHEN pi.PlanningItemDrop IN ('1', 'Yes') THEN '<img src="../System/Icons/icon_drop.gif" alt="" />' ELSE '' END AS PlanningItemDropIcon,	
		dims1.DimName as ItemDim1Name,
		dims2.DimName as ItemDim2Name,
		dims3.DimName as ItemDim3Name,
		ISNULL(dims1.DimActive, 1) * ISNULL(dims2.DimActive, 1) * ISNULL(dims3.DimActive, 1) AS DimensionComboActive,
		CASE WHEN ISNULL(dims1.DimActive, 1) * ISNULL(dims2.DimActive, 1) * ISNULL(dims3.DimActive, 1) = 1 THEN ''
			ELSE '<img src="../System/Icons/icon_drop.gif" alt="Active Dimensions" />' 
		END AS DimensionComboActiveImage
	INTO #tmpItems
	FROM pPlanningItem pi
	INNER JOIN pStyleHeader sh ON pi.StyleID = sh.StyleID
	LEFT JOIN vwx_Division_SEL d ON sh.DivisionID = d.CustomID
	LEFT JOIN pStyleType st ON sh.StyleType = st.StyleTypeID
	LEFT JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId
	LEFT JOIN pSubCategory sbc ON UPPER(CAST(sh.SubCategoryID AS NVARCHAR(40))) = UPPER(CAST(sbc.CustomID AS NVARCHAR(40)))
	INNER JOIN pStyleSeasonYear ssy ON pi.StyleSeasonYearID = ssy.StyleSeasonYearID
	INNER JOIN pPlanningSKUHeader psh ON pi.PlanningID = psh.PlanningID AND ssy.SeasonYearID = psh.SeasonYearID
	INNER JOIN pStyleSKUItem ssi ON psh.PlanningSKUHeaderID = ssi.PlanningSKUHeaderID
	INNER JOIN pWorkFlowItem wfi ON ssi.WorkflowItemID = wfi.WorkFlowItemID AND pi.StyleSeasonYearID = wfi.StyleSeasonYearID
	INNER JOIN pStyleSKUItems ssis ON ssi.StyleSKUItemID = ssis.StyleSKUItemID
	LEFT JOIN dims dims1 ON ssi.StyleBOMDimensionID = dims1.StyleBOMDimensionID
		AND ssis.ItemDim1ID = dims1.DimID
	LEFT JOIN dims dims2 ON ssi.StyleBOMDimensionID = dims2.StyleBOMDimensionID
		AND ssis.ItemDim2ID = dims2.DimID
	LEFT JOIN dims dims3 ON ssi.StyleBOMDimensionID = dims3.StyleBOMDimensionID
		AND ssis.ItemDim3ID = dims3.DimID
	WHERE psh.PlanningSKUHeaderID = @PlanningSKUHeaderID
		AND (ssis.ItemDim1ID  IS NULL OR ssis.ItemDim1ID IS NOT NULL AND dims1.DimID IS NOT NULL)
		AND (ssis.ItemDim2ID  IS NULL OR ssis.ItemDim2ID IS NOT NULL AND dims2.DimID IS NOT NULL)
		AND (ssis.ItemDim3ID  IS NULL OR ssis.ItemDim3ID IS NOT NULL AND dims3.DimID IS NOT NULL)
	ORDER BY sh.StyleNo, dims1.DimSort, dims2.DimSort, dims3.DimSort
	
	EXEC('SELECT ' + @SKUHeaderDimTypeList + ', * FROM #tmpItems ' + @SearchCond)
	
	DROP TABLE #tmpItems
	
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07544', GetDate())
GO
