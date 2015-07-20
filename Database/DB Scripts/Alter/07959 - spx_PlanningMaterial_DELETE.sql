IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningMaterial_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningMaterial_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_PlanningMaterial_DELETE]
	@PlanningMaterialID UNIQUEIDENTIFIER
AS
BEGIN

	IF NOT EXISTS (
		SELECT pli.*
		FROM pPlanningItem pli
			INNER JOIN pStyleBOM sb ON pli.StyleBOMDimensionID = sb.StyleBOMDimensionId
			INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
			INNER JOIN pPlanningMaterial pm ON pli.PlanningID = pm.PlanningID
				AND ssy.SeasonYearID = pm.SeasonYearID
				AND sb.MaterialID = pm.MaterialID
		WHERE pm.PlanningMaterialID = @PlanningMaterialID AND pli.PlanningItemDrop = 'No')
		
		BEGIN
			DELETE FROM pPlanningMaterial WHERE PlanningMaterialID = @PlanningMaterialID
			SELECT 1
		END
	ELSE
		BEGIN
			SELECT 0
		END
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07959', GetDate())
GO
