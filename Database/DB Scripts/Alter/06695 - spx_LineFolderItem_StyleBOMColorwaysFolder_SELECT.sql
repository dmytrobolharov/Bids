IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderItem_StyleBOMColorwaysFolder_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderItem_StyleBOMColorwaysFolder_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LineFolderItem_StyleBOMColorwaysFolder_SELECT]
	@LineFolderItemID UNIQUEIDENTIFIER
AS
BEGIN
	/* select colorways from Dim BOM page */
	--SELECT pColorPalette.ColorFolderID, pColorPalette.ColorPaletteID, pColorPalette.ColorCode, pColorPalette.ColorName,
	--		pColorPalette.ColorCode as StyleColorNo, pColorPalette.ColorName as StyleColorName, NULL as StyleColorID, 
	--		coalesce(pStyleBOMDimensionItem.ItemDim1Sort, pStyleBOMDimensionItem.ItemDim2Sort, pStyleBOMDimensionItem.ItemDim3Sort, 0) as Sort,
	--		1 AS IsVisible, NULL AS MaterialColorImageID, NULL AS MaterialColorImageVersion,
	--		1 - coalesce(pStyleBOMDimensionItem.ItemDim1Active, pStyleBOMDimensionItem.ItemDim2Active, pStyleBOMDimensionItem.ItemDim3Active, 0) as LineFolderItemColorDrop
	--FROM pLineFolderItem
	--	INNER JOIN pStyleBOMDimension ON pLineFolderItem.StyleBOMDimensionID = pStyleBOMDimension.StyleBOMDimensionID 
	--	INNER JOIN pStyleBOMDimensionItem ON pStyleBOMDimension.StyleBOMDimensionID = pStyleBOMDimensionItem.StyleBOMDimensionID 
	--	INNER JOIN pColorPalette ON pStyleBOMDimensionItem.ItemDim1Id = pColorPalette.ColorPaletteID OR pStyleBOMDimensionItem.ItemDim2Id = pColorPalette.ColorPaletteID OR pStyleBOMDimensionItem.ItemDim3Id = pColorPalette.ColorPaletteID
	--WHERE pLineFolderItem.LineFolderItemID = @LineFolderItemID
	--ORDER BY IsVisible, Sort, StyleColorNo, StyleColorName

	-- Changed to use a View that Mobility can use as well.
	SELECT * FROM vwx_LineFolderItemStyleBOMColorChip_SEL
	WHERE LineFolderItemID = @LineFolderItemID 
	AND LineFolderItemColorDrop <> 1 -- to show just Active colors from DimBOM
	ORDER BY IsVisible, Sort, StyleColorNo, StyleColorName
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06695', GetDate())
GO
