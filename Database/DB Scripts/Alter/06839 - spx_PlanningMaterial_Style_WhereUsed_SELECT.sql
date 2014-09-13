IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningMaterial_Style_WhereUsed_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningMaterial_Style_WhereUsed_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_PlanningMaterial_Style_WhereUsed_SELECT]
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER,
	@WhereClause NVARCHAR(MAX),
	@SelectedMaterials NVARCHAR(MAX),
	@SelectMode INT = 0 /* 0 - has any, 1 - has all */
AS
BEGIN

	if @SelectMode = 0
	begin
		SELECT DISTINCT vpi.*
		INTO #tmp0
		FROM vwx_PlanningItem_SELECT vpi	
			INNER JOIN pStyleBOM sb ON vpi.StyleBOMDimensionID = sb.StyleBOMDimensionID
			INNER JOIN (SELECT pm.MaterialID FROM dbo.fnx_Split(@SelectedMaterials, ',') spm
						INNER JOIN pPlanningMaterial pm ON spm.value = pm.PlanningMaterialID) sm ON sm.MaterialID = sb.MaterialID
		WHERE vpi.PlanningID = @PlanningID 
			AND vpi.SeasonYearID = @SeasonYearID 
			AND vpi.TeamId = @TeamID
			
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
				SELECT sb.StyleBOMDimensionID
				FROM dbo.fnx_Split(@SelectedMaterials, ',') spm
					INNER JOIN pPlanningMaterial pm ON spm.value = pm.PlanningMaterialID
					LEFT JOIN pStyleBOM sb ON sb.MaterialID = pm.MaterialID AND sb.StyleBOMDimensionID = vpi.StyleBOMDimensionID
				WHERE sb.StyleBOMDimensionID IS NULL)
				
		EXEC('SELECT * FROM #tmp1 ' + @WhereClause)
					
		DROP TABLE #tmp1
	end

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06839', GetDate())
GO
