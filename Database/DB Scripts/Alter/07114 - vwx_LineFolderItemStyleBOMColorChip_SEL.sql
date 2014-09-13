IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_LineFolderItemStyleBOMColorChip_SEL]'))
DROP VIEW [dbo].[vwx_LineFolderItemStyleBOMColorChip_SEL]
GO


CREATE VIEW [dbo].[vwx_LineFolderItemStyleBOMColorChip_SEL]
AS
	SELECT pLineFolderItem.LineFolderItemID, pColorPalette.ColorFolderID, pColorPalette.ColorPaletteID, pColorPalette.ColorCode, pColorPalette.ColorName,
			pColorPalette.ColorCode as StyleColorNo, pColorPalette.ColorName as StyleColorName, NULL as StyleColorID, 
			CASE WHEN pStyleBOMDimensionItem.ItemDim1Id IS NOT NULL THEN pStyleBOMDimensionItem.ItemDim1Sort
				 WHEN pStyleBOMDimensionItem.ItemDim2Id IS NOT NULL THEN pStyleBOMDimensionItem.ItemDim2Sort
				 WHEN pStyleBOMDimensionItem.ItemDim3Id IS NOT NULL THEN pStyleBOMDimensionItem.ItemDim3Sort
				 ELSE 0 
			END Sort,
			1 AS IsVisible, NULL AS MaterialColorImageID, NULL AS MaterialColorImageVersion,
			1 - (CASE WHEN pStyleBOMDimensionItem.ItemDim1Id IS NOT NULL THEN pStyleBOMDimensionItem.ItemDim1Active
					 WHEN pStyleBOMDimensionItem.ItemDim2Id IS NOT NULL THEN pStyleBOMDimensionItem.ItemDim2Active
					 WHEN pStyleBOMDimensionItem.ItemDim3Id IS NOT NULL THEN pStyleBOMDimensionItem.ItemDim3Active
					 ELSE 0 
				END)
			as LineFolderItemColorDrop
	FROM pLineFolderItem
		INNER JOIN pStyleBOMDimension ON pLineFolderItem.StyleBOMDimensionID = pStyleBOMDimension.StyleBOMDimensionID 
		INNER JOIN pStyleBOMDimensionItem ON pStyleBOMDimension.StyleBOMDimensionID = pStyleBOMDimensionItem.StyleBOMDimensionID 
		INNER JOIN pColorPalette ON 
			pStyleBOMDimensionItem.ItemDim1Id = pColorPalette.ColorPaletteID OR 
			pStyleBOMDimensionItem.ItemDim2Id = pColorPalette.ColorPaletteID OR 
			pStyleBOMDimensionItem.ItemDim3Id = pColorPalette.ColorPaletteID


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07114', GetDate())
GO
