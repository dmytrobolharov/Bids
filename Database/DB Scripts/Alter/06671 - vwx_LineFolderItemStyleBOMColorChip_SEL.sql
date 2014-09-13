IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_LineFolderItemStyleBOMColorChip_SEL]'))
DROP VIEW [dbo].[vwx_LineFolderItemStyleBOMColorChip_SEL]
GO


CREATE VIEW [dbo].[vwx_LineFolderItemStyleBOMColorChip_SEL]
AS
	SELECT pLineFolderItem.LineFolderItemID, pColorPalette.ColorFolderID, pColorPalette.ColorPaletteID, pColorPalette.ColorCode, pColorPalette.ColorName,
			pColorPalette.ColorCode as StyleColorNo, pColorPalette.ColorName as StyleColorName, NULL as StyleColorID, 
			coalesce(pStyleBOMDimensionItem.ItemDim1Sort, pStyleBOMDimensionItem.ItemDim2Sort, pStyleBOMDimensionItem.ItemDim3Sort, 0) as Sort,
			1 AS IsVisible, NULL AS MaterialColorImageID, NULL AS MaterialColorImageVersion,
			coalesce(pStyleBOMDimensionItem.ItemDim1Active, pStyleBOMDimensionItem.ItemDim2Active, pStyleBOMDimensionItem.ItemDim3Active, 0) as Active
	FROM pLineFolderItem
		INNER JOIN pStyleBOMDimension ON pLineFolderItem.StyleBOMDimensionID = pStyleBOMDimension.StyleBOMDimensionID 
		INNER JOIN pStyleBOMDimensionItem ON pStyleBOMDimension.StyleBOMDimensionID = pStyleBOMDimensionItem.StyleBOMDimensionID 
		INNER JOIN pColorPalette ON pStyleBOMDimensionItem.ItemDim1Id = pColorPalette.ColorPaletteID OR pStyleBOMDimensionItem.ItemDim2Id = pColorPalette.ColorPaletteID OR pStyleBOMDimensionItem.ItemDim3Id = pColorPalette.ColorPaletteID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06671', GetDate())
GO
