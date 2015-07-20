IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Plannig_MissingMaterial_WhereUsed_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Plannig_MissingMaterial_WhereUsed_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Plannig_MissingMaterial_WhereUsed_SELECT]
(
	@PlanningID UNIQUEIDENTIFIER
	, @SeasonYearID UNIQUEIDENTIFIER
	, @SelectedMaterials NVARCHAR(MAX)
)

AS

BEGIN
	SELECT CAST(value AS UNIQUEIDENTIFIER) AS MaterialID INTO #tmpMaterialID FROM dbo.fnx_Split(@SelectedMaterials,',')

	SELECT DISTINCT PlanningItemID
	FROM pPlanningItem pli
		INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
		INNER JOIN pStyleBOM sb ON pli.StyleBOMDimensionID = sb.StyleBOMDimensionId
		INNER JOIN #tmpMaterialID tm ON sb.MaterialID = tm.MaterialID
	WHERE pli.PlanningID = @PlanningID AND ssy.SeasonYearID = @SeasonYearID

	DROP TABLE #tmpMaterialID
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07735', GetDate())
GO
