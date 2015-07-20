IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Planning_MissingMaterials_SEL]'))
DROP VIEW [dbo].[vwx_Planning_MissingMaterials_SEL]
GO

CREATE VIEW [dbo].[vwx_Planning_MissingMaterials_SEL]

AS
SELECT pli.PlanningID, ssy.SeasonYearID, ct.ComponentDescription, m.*
FROM pPlanningItem pli 
	INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
	INNER JOIN pStyleBOM sb ON pli.StyleBOMDimensionID = sb.StyleBOMDimensionId
	INNER JOIN pMaterial m ON sb.MaterialID = m.MaterialID
	INNER JOIN pComponentType ct ON m.MaterialType = ct.ComponentTypeID
	LEFT JOIN pPlanningMaterial pm ON sb.MaterialID = pm.MaterialID
WHERE pm.MaterialID IS NULL

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06730', GetDate())
GO
