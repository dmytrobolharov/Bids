IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_PlanningMaterial_UsedInBOM_SEL]'))
DROP VIEW [dbo].[vwx_PlanningMaterial_UsedInBOM_SEL]
GO


CREATE VIEW [dbo].[vwx_PlanningMaterial_UsedInBOM_SEL]
AS
SELECT pm.*
FROM pPlanningItem pli
	INNER JOIN pStyleBOM sb ON pli.StyleBOMDimensionID = sb.StyleBOMDimensionId
	INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
	INNER JOIN pPlanningMaterial pm ON pli.PlanningID = pm.PlanningID
		AND ssy.SeasonYearID = pm.SeasonYearID
		AND sb.MaterialID = pm.MaterialID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07730', GetDate())
GO
