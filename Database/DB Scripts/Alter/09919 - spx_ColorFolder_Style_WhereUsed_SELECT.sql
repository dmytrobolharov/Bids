IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorFolder_Style_WhereUsed_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorFolder_Style_WhereUsed_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_ColorFolder_Style_WhereUsed_SELECT]
	@ColorFolderID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER,
	@WhereClause NVARCHAR(MAX),
	@SelectedColors NVARCHAR(MAX),
	@SelectMode INT = 0, /* 0 - has any, 1 - has all */
	@PageNo INT = NULL,
	@PageSize INT = NULL,
	@SortOrder NVARCHAR(MAX) = NULL
AS
BEGIN
	
	DECLARE @SelColors TABLE(ColorPaletteID UNIQUEIDENTIFIER)
	INSERT INTO @SelColors(ColorPaletteID)
	SELECT value FROM dbo.fnx_Split(@SelectedColors, ',') sc
	
	IF @SelectMode = 0
	BEGIN
	
		SELECT DISTINCT sh.* 
		INTO #tmp0
		FROM pStyleColorwaySeasonYear scsy		
		INNER JOIN pStyleColorway sc ON scsy.StyleColorwayID = sc.StyleColorID
		INNER JOIN vwx_StyleHeader_SEL sh ON scsy.StyleID = sh.StyleID AND scsy.StyleSeasonYearID = sh.StyleSeasonYearID
		INNER JOIN @SelColors SelColors ON sc.ColorPaletteID = SelColors.ColorPaletteID
		UNION
		SELECT sh.* 		
		FROM pStyleBOMDimensionItem sbdi
		INNER JOIN pWorkFlowItem wfi ON sbdi.WorkFlowItemID = wfi.WorkFlowItemID
		INNER JOIN pStyleColorway sc ON sc.StyleColorID IN (sbdi.ItemDim1Id, sbdi.ItemDim2Id, sbdi.ItemDim3Id)
		INNER JOIN vwx_StyleHeader_SEL sh ON sc.StyleID = sh.StyleID AND wfi.StyleSeasonYearID = sh.StyleSeasonYearID
		INNER JOIN @SelColors SelColors ON sc.ColorPaletteID = SelColors.ColorPaletteID				
		
		DECLARE @PagedSql NVARCHAR(MAX) = dbo.fnx_CreatePagingString('#tmp0', @PageNo, @PageSize, @SortOrder, @WhereClause)
		exec sp_executesql @PagedSql
		DROP TABLE #tmp0
		
	END
	ELSE
	BEGIN
	
	
		DECLARE @Styles TABLE(StyleSeasonYearID UNIQUEIDENTIFIER)
		
		;WITH StyleColors AS (			
			SELECT scsy.StyleSeasonYearID, sc.ColorPaletteID FROM pStyleColorwaySeasonYear scsy
			INNER JOIN pStyleColorway sc ON scsy.StyleColorwayID = sc.StyleColorID
			UNION
			SELECT wfi.StyleSeasonYearID, sc.ColorPaletteID FROM pStyleBOMDimensionItem sbdi
			INNER JOIN pWorkFlowItem wfi ON sbdi.WorkFlowItemID = wfi.WorkFlowItemID
			INNER JOIN pStyleColorway sc ON sc.StyleColorID IN (ItemDim1ID, ItemDim2ID, ItemDim3ID)
		)
		INSERT INTO @Styles(StyleSeasonYearID)
		SELECT DISTINCT ssy.StyleSeasonYearID
		FROM pStyleSeasonYear ssy
		CROSS JOIN @SelColors SelColors
		LEFT JOIN StyleColors ON SelColors.ColorPaletteID = StyleColors.ColorPaletteID AND ssy.StyleSeasonYearID = StyleColors.StyleSeasonYearID
		WHERE StyleColors.ColorPaletteID IS NULL
		
		SELECT sh.* 
		INTO #tmp1
		FROM vwx_StyleHeader_SEL sh
		LEFT JOIN @Styles s ON sh.StyleSeasonYearID = s.StyleSeasonYearID
		WHERE s.StyleSeasonYearID IS NULL AND sh.StyleSeasonYearID IS NOT NULL
		
		DECLARE @PagedSql2 NVARCHAR(MAX) = dbo.fnx_CreatePagingString('#tmp1', @PageNo, @PageSize, @SortOrder, @WhereClause)
		exec sp_executesql @PagedSql2
		DROP TABLE #tmp1
		
	END
	
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09919', GetDate())
GO
