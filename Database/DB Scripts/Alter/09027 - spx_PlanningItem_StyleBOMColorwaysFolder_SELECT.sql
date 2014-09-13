DROP PROCEDURE [dbo].[spx_PlanningItem_StyleBOMColorwaysFolder_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_PlanningItem_StyleBOMColorwaysFolder_SELECT]
	@PlanningItemID UNIQUEIDENTIFIER
AS
BEGIN
	/* select colorways from Dim BOM page */
	SELECT pColorPalette.ColorFolderID, pColorPalette.ColorPaletteID, pColorPalette.ColorCode, pColorPalette.ColorName,
			pColorPalette.ColorCode as StyleColorNo, pColorPalette.ColorName as StyleColorName, NULL as StyleColorID, 
			coalesce(pStyleBOMDimensionItem.ItemDim1Sort, pStyleBOMDimensionItem.ItemDim2Sort, pStyleBOMDimensionItem.ItemDim3Sort, 0) as Sort,
			1 AS IsVisible, NULL AS MaterialColorImageID, NULL AS MaterialColorImageVersion,
			coalesce(pStyleBOMDimensionItem.ItemDim1Active, pStyleBOMDimensionItem.ItemDim2Active, pStyleBOMDimensionItem.ItemDim3Active, 0) as Active
	FROM pPlanningItem
		INNER JOIN pStyleBOMDimension ON pPlanningItem.StyleBOMDimensionID = pStyleBOMDimension.StyleBOMDimensionID 
		INNER JOIN pStyleBOMDimensionItem ON pStyleBOMDimension.StyleBOMDimensionID = pStyleBOMDimensionItem.StyleBOMDimensionID 
		INNER JOIN pStyleColorway ON pStyleColorway.StyleColorID IN (pStyleBOMDimensionItem.ItemDim1Id, pStyleBOMDimensionItem.ItemDim2Id, pStyleBOMDimensionItem.ItemDim3Id)
		INNER JOIN pColorPalette ON pStyleColorway.ColorPaletteID = pColorPalette.ColorPaletteID
	WHERE pPlanningItem.PlanningItemID = @PlanningItemID
	AND coalesce(pStyleBOMDimensionItem.ItemDim1Active, pStyleBOMDimensionItem.ItemDim2Active, pStyleBOMDimensionItem.ItemDim3Active, 0) = 1
	ORDER BY Sort, StyleColorNo, StyleColorName
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '09027', GetDate())
GO
