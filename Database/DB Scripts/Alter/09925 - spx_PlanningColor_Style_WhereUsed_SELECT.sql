IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningColor_Style_WhereUsed_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningColor_Style_WhereUsed_SELECT]
GO



CREATE PROCEDURE [dbo].[spx_PlanningColor_Style_WhereUsed_SELECT]
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER,
	@WhereClause NVARCHAR(MAX),
	@SelectedColors NVARCHAR(MAX),
	@SelectMode INT = 0, /* 0 - has any, 1 - has all */
	@PageNo INT = NULL,
	@PageSize INT = NULL,
	@SortOrder NVARCHAR(MAX) = NULL
AS
BEGIN

	if @SelectMode = 0
	begin
		SELECT DISTINCT vpi.*
		INTO #tmp0
		FROM vwx_PlanningItem_SELECT vpi	
		INNER JOIN pStyleBOMDimensionItem sbdi ON vpi.StyleBOMDimensionID = sbdi.StyleBOMDimensionID
		INNER JOIN pStyleColorway stc ON stc.StyleColorID IN (sbdi.ItemDim1Id, sbdi.ItemDim2Id, sbdi.ItemDim3Id)
		INNER JOIN (
			SELECT pc.ColorPaletteID FROM dbo.fnx_Split(@SelectedColors, ',') sc
			INNER JOIN pPlanningColor pc ON sc.value = pc.PlanningColorID
		) sc ON sc.ColorPaletteID = stc.ColorPaletteID
		WHERE vpi.PlanningID = @PlanningID 
			AND vpi.SeasonYearID = @SeasonYearID 
			AND vpi.TeamId = @TeamID
			AND (sbdi.ItemDim1Id IS NULL OR sbdi.ItemDim1Active = 1)
			AND (sbdi.ItemDim2Id IS NULL OR sbdi.ItemDim2Active = 1)
			AND (sbdi.ItemDim3Id IS NULL OR sbdi.ItemDim3Active = 1)
			
		DECLARE @PagedSql NVARCHAR(MAX) = dbo.fnx_CreatePagingString('#tmp0', @PageNo, @PageSize, @SortOrder, @WhereClause)
		exec sp_executesql @PagedSql
		DROP TABLE #tmp0
	end
	else
	begin
		SELECT DISTINCT vpi.*
		INTO #tmp1
		FROM vwx_PlanningItem_SELECT vpi			
		WHERE vpi.PlanningID = @PlanningID 
			AND vpi.SeasonYearID = @SeasonYearID 
			AND vpi.TeamId = @TeamID
			AND NOT EXISTS(
				SELECT sbdi.StyleBOMDimensionID, pc.ColorPaletteID
				FROM dbo.fnx_Split(@SelectedColors, ',') sc
				INNER JOIN pPlanningColor pc ON sc.value = pc.PlanningColorID
				LEFT JOIN pStyleBOMDimensionItem sbdi 
						INNER JOIN pStyleColorway stc ON stc.StyleColorID IN (sbdi.ItemDim1Id, sbdi.ItemDim2Id, sbdi.ItemDim3Id)
					ON pc.ColorPaletteID = stc.ColorPaletteID
					AND sbdi.StyleBOMDimensionID = vpi.StyleBOMDimensionID
					AND (sbdi.ItemDim1Id IS NULL OR sbdi.ItemDim1Active = 1)
					AND (sbdi.ItemDim2Id IS NULL OR sbdi.ItemDim2Active = 1)
					AND (sbdi.ItemDim3Id IS NULL OR sbdi.ItemDim3Active = 1)
				WHERE sbdi.StyleBOMDimensionID IS NULL)
				
		DECLARE @PagedSql2 NVARCHAR(MAX) = dbo.fnx_CreatePagingString('#tmp1', @PageNo, @PageSize, @SortOrder, @WhereClause)
		exec sp_executesql @PagedSql2
		DROP TABLE #tmp1
	end

END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09925', GetDate())
GO
