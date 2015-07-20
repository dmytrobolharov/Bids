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
			pColorPalette.ColorName as ColorComboDescription, pColorPalette.ColorPaletteID as StyleColorID, 
			coalesce(pStyleBOMDimensionItem.ItemDim1Sort, pStyleBOMDimensionItem.ItemDim2Sort, pStyleBOMDimensionItem.ItemDim3Sort, 0) as Sort,
			coalesce(pStyleBOMDimensionItem.ItemDim1Active, pStyleBOMDimensionItem.ItemDim2Active, pStyleBOMDimensionItem.ItemDim3Active, 0) as Active,
			CASE WHEN coalesce(pStyleBOMDimensionItem.ItemDim1Active, pStyleBOMDimensionItem.ItemDim2Active, pStyleBOMDimensionItem.ItemDim3Active, 0) = 1 THEN 0 ELSE 1 END as LineFolderItemColorDrop, 
			NULL as LineFolderItemColorDropUser, NULL as LineFolderItemColorDropDate
	FROM pStyleBOMDimension
		INNER JOIN pStyleBOMDimensionItem ON pStyleBOMDimension.StyleBOMDimensionID = pStyleBOMDimensionItem.StyleBOMDimensionID 
		INNER JOIN pColorPalette ON pStyleBOMDimensionItem.ItemDim1Id = pColorPalette.ColorPaletteID OR pStyleBOMDimensionItem.ItemDim2Id = pColorPalette.ColorPaletteID OR pStyleBOMDimensionItem.ItemDim3Id = pColorPalette.ColorPaletteID
	WHERE pStyleBOMDimension.StyleBOMDimensionID = @StyleBOMDimensionID
	ORDER BY Sort, StyleColorNo, StyleColorName

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06696', GetDate())
GO
