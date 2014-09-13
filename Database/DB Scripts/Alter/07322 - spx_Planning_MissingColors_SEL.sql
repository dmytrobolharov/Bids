IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_MissingColors_SEL]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_MissingColors_SEL]
GO



CREATE PROCEDURE [dbo].[spx_Planning_MissingColors_SEL]
(
	@PlanningID UNIQUEIDENTIFIER
	, @SeasonYearID UNIQUEIDENTIFIER
	, @ColorPaletteID UNIQUEIDENTIFIER
)
AS

BEGIN
	SELECT * FROM
	(
		SELECT sh.StyleID AS ItemID, sh.Description AS ItemName, sh.StyleNo AS ItemNo, sh.DesignSketchID AS ItemImageID, sh.DesignSketchVersion AS ItemImageVersion, 0 AS Sort
		FROM pPlanningItem pli
			INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
				AND ssy.SeasonYearID = @SeasonYearID
				AND pli.PlanningID = @PlanningID
			INNER JOIN pStyleBOMDimensionItem sbdi
				INNER JOIN pStyleColorway sc ON sc.StyleColorID IN (sbdi.ItemDim1Id, sbdi.ItemDim2Id, sbdi.ItemDim3Id) 
			ON pli.StyleBOMDimensionId = sbdi.StyleBOMDimensionID
			INNER JOIN pStyleHeader sh ON pli.StyleID = sh.StyleID
			LEFT JOIN pPlanningColor pc ON sc.ColorPaletteID = pc.ColorPaletteID
				AND pc.PlanningID = @PlanningID AND pc.SeasonYearID = @SeasonYearID
		WHERE pc.ColorPaletteID IS NULL AND sc.ColorPaletteID = @ColorPaletteID
		UNION
		SELECT m.MaterialID AS ItemID, m.MaterialName AS ItemName, m.MaterialNo AS ItemNo, m.MaterialImageID AS ItemImageID, m.MaterialImageVersion AS ItemImageVersion, 1 AS Sort
		FROM pPlanningItem pli
			INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
				AND ssy.SeasonYearID = @SeasonYearID
				AND pli.PlanningID = @PlanningID
			INNER JOIN pStyleBOMItem sbi ON pli.StyleBOMDimensionID = sbi.StyleBOMDimensionID
			INNER JOIN pStyleBOMDimensionItem sbdi 
				INNER JOIN pStyleColorway sc ON sc.StyleColorID IN (sbdi.ItemDim1Id, sbdi.ItemDim2Id, sbdi.ItemDim3Id) 
				ON sbi.StyleBOMDimensionID = sbdi.StyleBOMDimensionID 
					AND (sbi.ItemDim1Id = sbdi.ItemDim1Id OR sbi.ItemDim2Id = sbdi.ItemDim2Id OR sbi.ItemDim3Id = sbdi.ItemDim3Id)
			INNER JOIN pMaterialColor mc ON sbi.MaterialColorId = mc.MaterialColorID
			INNER JOIN pMaterial m ON  mc.MaterialID = m.MaterialID
			LEFT JOIN pPlanningColor pc ON mc.ColorPaletteID = pc.ColorPaletteID
				AND pc.PlanningID = @PlanningID AND pc.SeasonYearID = @SeasonYearID
		WHERE pc.ColorPaletteID IS NULL AND mc.ColorPaletteID = @ColorPaletteID
			AND ((sbdi.ItemDim1Id IS NOT NULL AND sbdi.ItemDim1Active = 1)
			OR (sbdi.ItemDim2Id IS NOT NULL AND sbdi.ItemDim2Active = 1)
			OR (sbdi.ItemDim3Id IS NOT NULL AND sbdi.ItemDim3Active = 1))
	) ct
	ORDER BY Sort, ItemNo, ItemName
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07322', GetDate())
GO
