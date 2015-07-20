IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderItem_StyleBOMColorways_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderItem_StyleBOMColorways_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_LineFolderItem_StyleBOMColorways_SELECT]
	@StyleBOMDimensionID UNIQUEIDENTIFIER
AS
BEGIN

	/* select colorways from Dim BOM page */
	SELECT pColorPalette.ColorFolderID, pColorPalette.ColorPaletteID, pColorPalette.ColorCode, pColorPalette.ColorName,
			pColorPalette.ColorCode as StyleColorNo, pColorPalette.ColorName as StyleColorName, NULL as StyleColorID, 
			coalesce(pStyleBOMDimensionItem.ItemDim1Sort, pStyleBOMDimensionItem.ItemDim2Sort, pStyleBOMDimensionItem.ItemDim3Sort, 0) as Sort,
			1 AS IsVisible, NULL AS MaterialColorImageID, NULL AS MaterialColorImageVersion
	FROM pStyleBOMDimension
		INNER JOIN pStyleBOMDimensionItem ON pStyleBOMDimension.StyleBOMDimensionID = pStyleBOMDimensionItem.StyleBOMDimensionID 
		INNER JOIN pColorPalette ON pStyleBOMDimensionItem.ItemDim1Id = pColorPalette.ColorPaletteID OR pStyleBOMDimensionItem.ItemDim2Id = pColorPalette.ColorPaletteID OR pStyleBOMDimensionItem.ItemDim3Id = pColorPalette.ColorPaletteID
	WHERE pStyleBOMDimension.StyleBOMDimensionID = @StyleBOMDimensionID
	UNION SELECT
	'00000000-0000-0000-0000-000000000000' AS ColorFolderID, '00000000-0000-0000-0000-000000000000' AS ColorPaletteID,
	'No Color' AS ColorCode, 'No Color' AS ColorName, 'No Color' AS StyleColorNo, 'No Color' AS StyleColorName, 
	'00000000-0000-0000-0000-000000000000' As StyleColorID, NULL AS Sort, 0 AS IsVisible, 
	NULL AS MaterialColorImageID, NULL AS MaterialColorImageVersion
	ORDER BY IsVisible, Sort, StyleColorNo, StyleColorName

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06681', GetDate())
GO
