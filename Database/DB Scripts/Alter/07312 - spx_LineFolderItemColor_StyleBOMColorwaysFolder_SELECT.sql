IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderItemColor_StyleBOMColorwaysFolder_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderItemColor_StyleBOMColorwaysFolder_SELECT]
GO



CREATE PROCEDURE [dbo].[spx_LineFolderItemColor_StyleBOMColorwaysFolder_SELECT]
	@StyleBOMDimensionID UNIQUEIDENTIFIER
AS
BEGIN
	/* select colorways from Dim BOM page */
	SELECT NULL as LineFolderItemColorID, 
			pColorPalette.ColorFolderID, pColorPalette.ColorPaletteID, 
			pColorPalette.ColorCode as StyleColorNo, pColorPalette.ColorName as StyleColorName,
			pColorPalette.ColorName as ColorComboDescription, pStyleColorway.StyleColorID, 
			CASE WHEN pStyleBOMDimensionItem.ItemDim1Id IS NOT NULL THEN pStyleBOMDimensionItem.ItemDim1Sort
				 WHEN pStyleBOMDimensionItem.ItemDim2Id IS NOT NULL THEN pStyleBOMDimensionItem.ItemDim2Sort
				 WHEN pStyleBOMDimensionItem.ItemDim3Id IS NOT NULL THEN pStyleBOMDimensionItem.ItemDim3Sort
				 ELSE 0 
			END Sort,
			CASE WHEN pStyleBOMDimensionItem.ItemDim1Id IS NOT NULL THEN pStyleBOMDimensionItem.ItemDim1Active
				 WHEN pStyleBOMDimensionItem.ItemDim2Id IS NOT NULL THEN pStyleBOMDimensionItem.ItemDim2Active
				 WHEN pStyleBOMDimensionItem.ItemDim3Id IS NOT NULL THEN pStyleBOMDimensionItem.ItemDim3Active
				 ELSE 0 
			END Active,
			1 - (CASE WHEN pStyleBOMDimensionItem.ItemDim1Id IS NOT NULL THEN pStyleBOMDimensionItem.ItemDim1Active
					 WHEN pStyleBOMDimensionItem.ItemDim2Id IS NOT NULL THEN pStyleBOMDimensionItem.ItemDim2Active
					 WHEN pStyleBOMDimensionItem.ItemDim3Id IS NOT NULL THEN pStyleBOMDimensionItem.ItemDim3Active
					 ELSE 0 
				END) as LineFolderItemColorDrop,
			NULL as LineFolderItemColorDropUser, NULL as LineFolderItemColorDropDate
	FROM pStyleBOMDimension
		INNER JOIN pStyleBOMDimensionItem ON pStyleBOMDimension.StyleBOMDimensionID = pStyleBOMDimensionItem.StyleBOMDimensionID 
		INNER JOIN pStyleColorway ON 
			pStyleBOMDimensionItem.ItemDim1Id = pStyleColorway.StyleColorID OR 
			pStyleBOMDimensionItem.ItemDim2Id = pStyleColorway.StyleColorID OR 
			pStyleBOMDimensionItem.ItemDim3Id = pStyleColorway.StyleColorID
		INNER JOIN pColorPalette ON pStyleColorway.ColorPaletteID = pColorPalette.ColorPaletteID
	WHERE pStyleBOMDimension.StyleBOMDimensionID = @StyleBOMDimensionID
	ORDER BY Sort, StyleColorNo, StyleColorName

END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07312', GetDate())
GO
