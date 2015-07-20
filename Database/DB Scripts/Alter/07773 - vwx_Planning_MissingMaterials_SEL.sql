IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Planning_MissingMaterials_SEL]'))
DROP VIEW [dbo].[vwx_Planning_MissingMaterials_SEL]
GO

CREATE VIEW [dbo].[vwx_Planning_MissingMaterials_SEL]

AS
SELECT DISTINCT pli.PlanningID, ssy.SeasonYearID, ct.ComponentDescription, m.*
FROM pPlanningItem pli 
	INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
	INNER JOIN pStyleBOM sb ON pli.StyleBOMDimensionID = sb.StyleBOMDimensionId
	INNER JOIN pMaterial m ON sb.MaterialID = m.MaterialID
	INNER JOIN pComponentType ct ON m.MaterialType = ct.ComponentTypeID
	LEFT JOIN pPlanningMaterial pm ON sb.MaterialID = pm.MaterialID
		AND pm.PlanningID = pli.PlanningID AND pm.SeasonYearID = ssy.SeasonYearID
WHERE pm.MaterialID IS NULL AND pli.PlanningItemDrop = 'No'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07773', GetDate())
GO