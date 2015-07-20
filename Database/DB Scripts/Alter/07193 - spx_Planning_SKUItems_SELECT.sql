IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_SKUItems_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_SKUItems_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_SKUItems_SELECT]
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@SearchCond NVARCHAR(MAX) = '',
	@SelectedDimensions as NVARCHAR(200) = '',
	@DimensionValue as NVARCHAR(MAX) = ''
AS
BEGIN

	-- update style sku items
	DECLARE @WFIs TABLE(ROW INT IDENTITY(1, 1), WorkflowItemID UNIQUEIDENTIFIER)
	
	INSERT INTO @WFIs(WorkflowItemID)
	SELECT ssi.WorkflowItemID FROM pPlanningItem pi
	INNER JOIN pStyleSeasonYear ssy ON pi.StyleSeasonYearID = ssy.StyleSeasonYearID
	INNER JOIN pStyleSKUItem ssi ON pi.StyleSKUHeaderID = ssi.StyleSKUItemID
	WHERE pi.PlanningID = @PlanningID AND ssy.SeasonYearID = @SeasonYearID
	
	DECLARE @ROW INT = 1,
			@TOTAL INT = (SELECT COUNT(*) FROM @WFIs);
		
	SET ROWCOUNT 0
		
	WHILE @ROW <= @TOTAL
	BEGIN
		DECLARE @WorkflowItemID UNIQUEIDENTIFIER = (SELECT WorkflowItemID FROM @WFIs WHERE ROW = @ROW)
				
		exec spx_StyleSKUItems_Logic_UPDATE @WorkflowItemID = @WorkflowItemID
	
		SET @ROW = @ROW + 1
	END
	
	SET ROWCOUNT 0

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
	SELECT sh.StyleNo, ssis.*, 
		d.Custom AS DivisionName, st.StyleTypeDescription,
		sc.StyleCategory, sbc.Custom AS SubCategory,
		dims1.DimName as ItemDim1Name,
		dims2.DimName as ItemDim2Name,
		dims3.DimName as ItemDim3Name
	INTO #tmpItems
	FROM pPlanningItem pi
	INNER JOIN pStyleHeader sh ON pi.StyleID = sh.StyleID
	LEFT JOIN vwx_Division_SEL d ON sh.DivisionID = d.CustomID
	LEFT JOIN pStyleType st ON sh.StyleType = st.StyleTypeID
	LEFT JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId
	LEFT JOIN pSubCategory sbc ON sh.SubCategoryId = sbc.CustomID
	INNER JOIN pStyleSeasonYear ssy ON pi.StyleSeasonYearID = ssy.StyleSeasonYearID
	INNER JOIN pStyleSKUItem ssi ON pi.StyleSKUHeaderID = ssi.StyleSKUItemID
	INNER JOIN pStyleSKUItems ssis ON ssi.StyleSKUItemID = ssis.StyleSKUItemID
	LEFT JOIN dims dims1 ON ssi.StyleBOMDimensionID = dims1.StyleBOMDimensionID
		AND ssis.ItemDim1ID = dims1.DimID
	LEFT JOIN dims dims2 ON ssi.StyleBOMDimensionID = dims2.StyleBOMDimensionID
		AND ssis.ItemDim2ID = dims2.DimID
	LEFT JOIN dims dims3 ON ssi.StyleBOMDimensionID = dims3.StyleBOMDimensionID
		AND ssis.ItemDim3ID = dims3.DimID
	WHERE pi.PlanningID = @PlanningID AND ssy.SeasonYearID = @SeasonYearID
		AND (ssis.ItemDim1ID  IS NULL OR ssis.ItemDim1ID IS NOT NULL AND dims1.DimID IS NOT NULL)
		AND (ssis.ItemDim2ID  IS NULL OR ssis.ItemDim2ID IS NOT NULL AND dims2.DimID IS NOT NULL)
		AND (ssis.ItemDim3ID  IS NULL OR ssis.ItemDim3ID IS NOT NULL AND dims3.DimID IS NOT NULL)
	ORDER BY dims1.DimSort, dims2.DimSort, dims3.DimSort
	
	EXEC('SELECT * FROM #tmpItems ' + @SearchCond)
	
	DROP TABLE #tmpItems
	
END




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07193', GetDate())
GO
