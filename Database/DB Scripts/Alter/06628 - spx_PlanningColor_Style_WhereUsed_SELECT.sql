IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningColor_Style_WhereUsed_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningColor_Style_WhereUsed_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_PlanningColor_Style_WhereUsed_SELECT]
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER,
	@WhereClause NVARCHAR(MAX),
	@SelectedColors NVARCHAR(MAX),
	@SelectMode INT = 0 /* 0 - has any, 1 - has all */
AS
BEGIN

	if @SelectMode = 0
	begin
		SELECT DISTINCT vpi.*
		INTO #tmp0
		FROM vwx_PlanningItem_SELECT vpi	
		INNER JOIN pStyleBOMDimensionItem sbdi ON vpi.StyleBOMDimensionID = sbdi.StyleBOMDimensionID
		INNER JOIN (
			SELECT pc.ColorPaletteID FROM dbo.fnx_Split(@SelectedColors, ',') sc
			INNER JOIN pPlanningColor pc ON sc.value = pc.PlanningColorID
		) sc ON sc.ColorPaletteID IN (sbdi.ItemDim1Id, sbdi.ItemDim2Id, sbdi.ItemDim3Id)
		WHERE vpi.PlanningID = @PlanningID 
			AND vpi.SeasonYearID = @SeasonYearID 
			AND vpi.TeamId = @TeamID
			AND (sbdi.ItemDim1Id IS NULL OR sbdi.ItemDim1Active = 1)
			AND (sbdi.ItemDim2Id IS NULL OR sbdi.ItemDim2Active = 1)
			AND (sbdi.ItemDim3Id IS NULL OR sbdi.ItemDim3Active = 1)
			
		EXEC('SELECT * FROM #tmp0 ' + @WhereClause)
			
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
				SELECT sbdi.StyleBOMDimensionID, ColorPaletteID
				FROM dbo.fnx_Split(@SelectedColors, ',') sc
				INNER JOIN pPlanningColor pc ON sc.value = pc.PlanningColorID
				LEFT JOIN pStyleBOMDimensionItem sbdi ON pc.ColorPaletteID IN (sbdi.ItemDim1Id, sbdi.ItemDim1Id, sbdi.ItemDim1Id)
					AND sbdi.StyleBOMDimensionID = vpi.StyleBOMDimensionID
					AND (sbdi.ItemDim1Id IS NULL OR sbdi.ItemDim1Active = 1)
					AND (sbdi.ItemDim2Id IS NULL OR sbdi.ItemDim2Active = 1)
					AND (sbdi.ItemDim3Id IS NULL OR sbdi.ItemDim3Active = 1)
				WHERE sbdi.StyleBOMDimensionID IS NULL)
				
		EXEC('SELECT * FROM #tmp1 ' + @WhereClause)
					
		DROP TABLE #tmp1
	end

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06628', GetDate())
GO
