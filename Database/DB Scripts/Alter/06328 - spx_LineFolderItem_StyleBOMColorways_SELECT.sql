/****** Object:  StoredProcedure [dbo].[spx_LineFolderItem_StyleBOMColorways_SELECT]    Script Date: 09/23/2013 14:21:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderItem_StyleBOMColorways_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderItem_StyleBOMColorways_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineFolderItem_StyleBOMColorways_SELECT]    Script Date: 09/23/2013 14:21:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_LineFolderItem_StyleBOMColorways_SELECT]
	@LineFolderItemID UNIQUEIDENTIFIER
AS
BEGIN

	/* select colorways from Dim BOM page */
	SELECT pColorPalette.ColorFolderID, pColorPalette.ColorPaletteID, pColorPalette.ColorCode, pColorPalette.ColorName,
			pColorPalette.ColorCode as StyleColorNo, pColorPalette.ColorName as StyleColorName, NULL as StyleColorID, 
			coalesce(pStyleBOMDimensionItem.ItemDim1Sort, pStyleBOMDimensionItem.ItemDim2Sort, pStyleBOMDimensionItem.ItemDim3Sort, 0) as Sort,
			1 AS IsVisible, NULL AS MaterialColorImageID, NULL AS MaterialColorImageVersion
	FROM pLineFolderItem
		INNER JOIN pStyleBOMDimension ON pLineFolderItem.StyleBOMDimensionID = pStyleBOMDimension.StyleBOMDimensionID 
		INNER JOIN pStyleBOMDimensionItem ON pStyleBOMDimension.StyleBOMDimensionID = pStyleBOMDimensionItem.StyleBOMDimensionID 
		INNER JOIN pColorPalette ON pStyleBOMDimensionItem.ItemDim1Id = pColorPalette.ColorPaletteID OR pStyleBOMDimensionItem.ItemDim2Id = pColorPalette.ColorPaletteID OR pStyleBOMDimensionItem.ItemDim3Id = pColorPalette.ColorPaletteID
	WHERE pLineFolderItem.LineFolderItemID = @LineFolderItemID
	UNION SELECT
	'00000000-0000-0000-0000-000000000000' AS ColorFolderID, '00000000-0000-0000-0000-000000000000' AS ColorPaletteID,
	'No Color' AS ColorCode, 'No Color' AS ColorName, 'No Color' AS StyleColorNo, 'No Color' AS StyleColorName, 
	'00000000-0000-0000-0000-000000000000' As StyleColorID, NULL AS Sort, 0 AS IsVisible, 
	NULL AS MaterialColorImageID, NULL AS MaterialColorImageVersion
	ORDER BY IsVisible, Sort, StyleColorNo, StyleColorName

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06328', GetDate())
GO