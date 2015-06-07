IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningColor_Material_WhereUsed_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningColor_Material_WhereUsed_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_PlanningColor_Material_WhereUsed_SELECT]
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
		;WITH SelectedColors AS (
			SELECT pc.ColorPaletteID
			FROM dbo.fnx_Split(@SelectedColors, ',') sc
			INNER JOIN pPlanningColor pc ON sc.value = pc.PlanningColorID
		), MatColor AS (
			SELECT DISTINCT sb.MaterialID, cp.ColorPaletteID
			FROM pPlanningItem pi
			INNER JOIN pStyleSeasonYear ssy ON pi.StyleSeasonYearID = ssy.StyleSeasonYearID
			INNER JOIN pStyleBOM sb ON pi.StyleBOMDimensionID = sb.StyleBOMDimensionId
			INNER JOIN pStyleBOMItem sbi ON sb.StyleMaterialID = sbi.StyleMaterialID
			INNER JOIN pMaterialColor mc ON sbi.MaterialColorId = mc.MaterialColorID
			INNER JOIN pColorPalette cp ON mc.ColorPaletteID = cp.ColorPaletteID
			WHERE PlanningID = @PlanningID AND ssy.SeasonYearID = @SeasonYearID)
		SELECT DISTINCT pm.*
		INTO #tmp0
		FROM vwx_PlanningMaterial_SEL pm
		INNER JOIN MatColor mc ON pm.MaterialID = mc.MaterialID
		INNER JOIN SelectedColors sc ON mc.ColorPaletteID = sc.ColorPaletteID
		WHERE pm.PlanningID = @PlanningID AND pm.SeasonYearID = @SeasonYearID
			
		DECLARE @PagedSql NVARCHAR(MAX) = dbo.fnx_CreatePagingString('#tmp0', @PageNo, @PageSize, @SortOrder, @WhereClause)
		exec sp_executesql @PagedSql
		DROP TABLE #tmp0
	end
	else
	begin
		;WITH SelectedColors AS (
			SELECT pc.ColorPaletteID
			FROM dbo.fnx_Split(@SelectedColors, ',') sc
			INNER JOIN pPlanningColor pc ON sc.value = pc.PlanningColorID
		), MatColor AS (
			SELECT DISTINCT sb.MaterialID, cp.ColorPaletteID
			FROM pPlanningItem pi
			INNER JOIN pStyleSeasonYear ssy ON pi.StyleSeasonYearID = ssy.StyleSeasonYearID
			INNER JOIN pStyleBOM sb ON pi.StyleBOMDimensionID = sb.StyleBOMDimensionId
			INNER JOIN pStyleBOMItem sbi ON sb.StyleMaterialID = sbi.StyleMaterialID
			INNER JOIN pMaterialColor mc ON sbi.MaterialColorId = mc.MaterialColorID
			INNER JOIN pColorPalette cp ON mc.ColorPaletteID = cp.ColorPaletteID
			WHERE PlanningID = @PlanningID AND ssy.SeasonYearID = @SeasonYearID)
		SELECT DISTINCT pm.*
		INTO #tmp1
		FROM vwx_PlanningMaterial_SEL pm		
		WHERE pm.PlanningID = @PlanningID 
			AND pm.SeasonYearID = @SeasonYearID
			AND NOT EXISTS(
				SELECT * FROM SelectedColors sc
				LEFT JOIN MatColor mc ON sc.ColorPaletteID = mc.ColorPaletteID AND pm.MaterialID = mc.MaterialID
				WHERE mc.MaterialID IS NULL
			)		
				
		DECLARE @PagedSql2 NVARCHAR(MAX) = dbo.fnx_CreatePagingString('#tmp1', @PageNo, @PageSize, @SortOrder, @WhereClause)
		exec sp_executesql @PagedSql2
		DROP TABLE #tmp1
	end

END




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09926', GetDate())
GO
