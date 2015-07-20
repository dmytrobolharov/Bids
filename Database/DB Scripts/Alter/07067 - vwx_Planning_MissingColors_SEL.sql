IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Planning_MissingColors_SEL]'))
DROP VIEW [dbo].[vwx_Planning_MissingColors_SEL]
GO

CREATE VIEW [dbo].[vwx_Planning_MissingColors_SEL]

AS
	SELECT ct.PlanningID, ct.SeasonYearID, ct.UsedInBOM, ct.UsedInBOMMaterial, cp.* FROM
	(
		SELECT ct.ColorPaletteID, ct.PlanningID, ct.SeasonYearID, SUM(ct.UsedInBOM) AS UsedInBOM, SUM(ct.UsedInBOMMaterial) AS UsedInBOMMaterial FROM (
			SELECT cp.ColorPaletteID, ssy.SeasonYearID, pli.PlanningID, 1 AS UsedInBOM, 0 AS UsedInBOMMaterial
			FROM pPlanningItem pli
				INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
				INNER JOIN pStyleBOMDimensionItem sbdi
					INNER JOIN pColorPalette cp ON sbdi.ItemDim1Id = cp.ColorPaletteID OR sbdi.ItemDim2Id = cp.ColorPaletteID OR sbdi.ItemDim3Id = cp.ColorPaletteID
				ON pli.StyleBOMDimensionId = sbdi.StyleBOMDimensionID
			WHERE (sbdi.ItemDim1Id IS NOT NULL AND sbdi.ItemDim1Active = 1)
				OR (sbdi.ItemDim2Id IS NOT NULL AND sbdi.ItemDim2Active = 1)
				OR (sbdi.ItemDim3Id IS NOT NULL AND sbdi.ItemDim3Active = 1)
			UNION
			SELECT mc.ColorPaletteID, ssy.SeasonYearID, pli.PlanningID, 0 AS UsedInBOM, 1 AS UsedInBOMMaterial
			FROM pPlanningItem pli
				INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
				INNER JOIN pStyleBOMItem sbi ON pli.StyleBOMDimensionID = sbi.StyleBOMDimensionID
				INNER JOIN pStyleBOMDimensionItem sbdi 
					INNER JOIN pColorPalette cp ON cp.ColorPaletteID IN (sbdi.ItemDim1Id, sbdi.ItemDim2Id, sbdi.ItemDim3Id) 
					ON sbi.StyleBOMDimensionID = sbdi.StyleBOMDimensionID 
						AND (sbi.ItemDim1Id = sbdi.ItemDim1Id OR sbi.ItemDim2Id = sbdi.ItemDim2Id OR sbi.ItemDim3Id = sbdi.ItemDim3Id)
				INNER JOIN pMaterialColor mc ON sbi.MaterialColorId = mc.MaterialColorID
			WHERE (sbdi.ItemDim1Id IS NOT NULL AND sbdi.ItemDim1Active = 1)
				OR (sbdi.ItemDim2Id IS NOT NULL AND sbdi.ItemDim2Active = 1)
				OR (sbdi.ItemDim3Id IS NOT NULL AND sbdi.ItemDim3Active = 1)
			GROUP BY mc.ColorPaletteID, pli.PlanningID, ssy.SeasonYearID
		) ct GROUP BY ct.ColorPaletteID, ct.PlanningID, ct.SeasonYearID
	) ct
	INNER JOIN pColorPalette cp ON ct.ColorPaletteID = cp.ColorPaletteID
	LEFT JOIN pPlanningColor pc ON ct.ColorPaletteID = pc.ColorPaletteID
		AND ct.PlanningID = pc.PlanningID AND ct.SeasonYearID = pc.SeasonYearID
	
	WHERE pc.ColorPaletteID IS NULL

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07067', GetDate())
GO
