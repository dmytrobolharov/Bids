IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderItem_StyleBOMColorways_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderItem_StyleBOMColorways_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_LineFolderItem_StyleBOMColorways_SELECT]
	@StyleBOMDimensionID UNIQUEIDENTIFIER,
	@nOption INT = 0
AS
BEGIN
/* select colorways from Dim BOM page */

/**************************************************
-- @nOption	= 0	Select all
			= 1	Select DROPPED
			= 2	Select ACTIVE
**************************************************/

	IF @nOption = 0
	BEGIN
		SELECT pColorPalette.ColorFolderID, pColorPalette.ColorPaletteID, pColorPalette.ColorCode, pColorPalette.ColorName,
				pColorPalette.ColorCode as StyleColorNo, pColorPalette.ColorName as StyleColorName, NULL as StyleColorID, 
				CASE WHEN pStyleBOMDimensionItem.ItemDim1Id IS NOT NULL THEN pStyleBOMDimensionItem.ItemDim1Sort
					 WHEN pStyleBOMDimensionItem.ItemDim2Id IS NOT NULL THEN pStyleBOMDimensionItem.ItemDim2Sort
					 WHEN pStyleBOMDimensionItem.ItemDim3Id IS NOT NULL THEN pStyleBOMDimensionItem.ItemDim3Sort
					 ELSE 0 
				END Sort,
				1 AS IsVisible, NULL AS MaterialColorImageID, NULL AS MaterialColorImageVersion
		FROM pStyleBOMDimension
			INNER JOIN pStyleBOMDimensionItem ON pStyleBOMDimension.StyleBOMDimensionID = pStyleBOMDimensionItem.StyleBOMDimensionID 
			INNER JOIN pColorPalette ON 
				pStyleBOMDimensionItem.ItemDim1Id = pColorPalette.ColorPaletteID
				OR pStyleBOMDimensionItem.ItemDim2Id = pColorPalette.ColorPaletteID
				OR pStyleBOMDimensionItem.ItemDim3Id = pColorPalette.ColorPaletteID
		WHERE pStyleBOMDimension.StyleBOMDimensionID = @StyleBOMDimensionID
		UNION SELECT
		'00000000-0000-0000-0000-000000000000' AS ColorFolderID, '00000000-0000-0000-0000-000000000000' AS ColorPaletteID,
		'No Color' AS ColorCode, 'No Color' AS ColorName, 'No Color' AS StyleColorNo, 'No Color' AS StyleColorName, 
		'00000000-0000-0000-0000-000000000000' As StyleColorID, NULL AS Sort, 0 AS IsVisible, 
		NULL AS MaterialColorImageID, NULL AS MaterialColorImageVersion
		ORDER BY IsVisible, Sort, StyleColorNo, StyleColorName
	END
	ELSE IF @nOption = 1
	BEGIN
		SELECT pColorPalette.ColorFolderID, pColorPalette.ColorPaletteID, pColorPalette.ColorCode, pColorPalette.ColorName,
				pColorPalette.ColorCode as StyleColorNo, pColorPalette.ColorName as StyleColorName, NULL as StyleColorID, 
				CASE WHEN pStyleBOMDimensionItem.ItemDim1Id IS NOT NULL THEN pStyleBOMDimensionItem.ItemDim1Sort
					 WHEN pStyleBOMDimensionItem.ItemDim2Id IS NOT NULL THEN pStyleBOMDimensionItem.ItemDim2Sort
					 WHEN pStyleBOMDimensionItem.ItemDim3Id IS NOT NULL THEN pStyleBOMDimensionItem.ItemDim3Sort
					 ELSE 0 
				END Sort
		FROM pStyleBOMDimension
			INNER JOIN pStyleBOMDimensionItem ON pStyleBOMDimension.StyleBOMDimensionID = pStyleBOMDimensionItem.StyleBOMDimensionID 
			INNER JOIN pColorPalette ON 
				(pStyleBOMDimensionItem.ItemDim1Id = pColorPalette.ColorPaletteID AND pStyleBOMDimensionItem.ItemDim1Active = 0) 
				OR (pStyleBOMDimensionItem.ItemDim2Id = pColorPalette.ColorPaletteID AND pStyleBOMDimensionItem.ItemDim2Active = 0)
				OR (pStyleBOMDimensionItem.ItemDim3Id = pColorPalette.ColorPaletteID AND pStyleBOMDimensionItem.ItemDim3Active = 0)
		WHERE pStyleBOMDimension.StyleBOMDimensionID = @StyleBOMDimensionID
		ORDER BY Sort, StyleColorNo, StyleColorName
	END
	ELSE IF @nOption = 2
	BEGIN
		SELECT pColorPalette.ColorFolderID, pColorPalette.ColorPaletteID, pColorPalette.ColorCode, pColorPalette.ColorName,
				pColorPalette.ColorCode as StyleColorNo, pColorPalette.ColorName as StyleColorName, NULL as StyleColorID, 
				CASE WHEN pStyleBOMDimensionItem.ItemDim1Id IS NOT NULL THEN pStyleBOMDimensionItem.ItemDim1Sort
					 WHEN pStyleBOMDimensionItem.ItemDim2Id IS NOT NULL THEN pStyleBOMDimensionItem.ItemDim2Sort
					 WHEN pStyleBOMDimensionItem.ItemDim3Id IS NOT NULL THEN pStyleBOMDimensionItem.ItemDim3Sort
					 ELSE 0 
				END Sort,
				1 AS IsVisible, NULL AS MaterialColorImageID, NULL AS MaterialColorImageVersion
		FROM pStyleBOMDimension
			INNER JOIN pStyleBOMDimensionItem ON pStyleBOMDimension.StyleBOMDimensionID = pStyleBOMDimensionItem.StyleBOMDimensionID 
			INNER JOIN pColorPalette ON 
				(pStyleBOMDimensionItem.ItemDim1Id = pColorPalette.ColorPaletteID AND pStyleBOMDimensionItem.ItemDim1Active = 1) 
				OR (pStyleBOMDimensionItem.ItemDim2Id = pColorPalette.ColorPaletteID AND pStyleBOMDimensionItem.ItemDim2Active = 1)
				OR (pStyleBOMDimensionItem.ItemDim3Id = pColorPalette.ColorPaletteID AND pStyleBOMDimensionItem.ItemDim3Active = 1)
		WHERE pStyleBOMDimension.StyleBOMDimensionID = @StyleBOMDimensionID
		UNION SELECT
		'00000000-0000-0000-0000-000000000000' AS ColorFolderID, '00000000-0000-0000-0000-000000000000' AS ColorPaletteID,
		'No Color' AS ColorCode, 'No Color' AS ColorName, 'No Color' AS StyleColorNo, 'No Color' AS StyleColorName, 
		'00000000-0000-0000-0000-000000000000' As StyleColorID, NULL AS Sort, 0 AS IsVisible, 
		NULL AS MaterialColorImageID, NULL AS MaterialColorImageVersion
		ORDER BY IsVisible, Sort, StyleColorNo, StyleColorName
	END	

END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07116', GetDate())
GO
