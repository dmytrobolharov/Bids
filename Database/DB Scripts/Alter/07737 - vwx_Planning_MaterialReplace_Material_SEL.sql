IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Planning_MaterialReplace_Material_SEL]'))
DROP VIEW [dbo].[vwx_Planning_MaterialReplace_Material_SEL]
GO

CREATE VIEW [dbo].[vwx_Planning_MaterialReplace_Material_SEL]
AS

SELECT TOP 100 PERCENT * FROM 
(
	SELECT DISTINCT pli.PlanningID, ssy.SeasonYearID, ct.ComponentOrder, m.*
	FROM pPlanningItem pli
		INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
		INNER JOIN pStyleBOM sb ON pli.StyleBOMDimensionID = sb.StyleBOMDimensionId
		INNER JOIN pMaterial m ON sb.MaterialID = m.MaterialID
		INNER JOIN pComponentType ct ON m.MaterialType = ct.ComponentTypeID
	UNION
	SELECT DISTINCT vpm.PlanningID, vpm.SeasonYearID, ct.ComponentOrder, m.*
	FROM vwx_PlanningMaterial_SEL vpm
		INNER JOIN pMaterial m ON vpm.MaterialID = m.MaterialID
		INNER JOIN pComponentType ct ON m.MaterialType = ct.ComponentTypeID
) Mat
ORDER BY mat.ComponentOrder, mat.MaterialNo

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07737', GetDate())
GO
