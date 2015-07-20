IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMDimension_Items_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMDimension_Items_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleBOMDimension_Items_SELECT]
	@StyleBOMDimensionID UNIQUEIDENTIFIER,
	@DimNo INT
AS
BEGIN
	
	SELECT sbdi.StyleBOMDimensionItemID
		, V.*
		, CASE WHEN UPPER(RTRIM(LTRIM(sbdt.DimTypeName))) = 'COLOR' THEN 1 ELSE 0 END AS IsColor
		, cp.ColorFolderID
		, cp.ColorPaletteID
		, cp.ColorCode
	FROM pStyleBOMDimensionItem sbdi 
	CROSS APPLY (VALUES (sbdi.ItemDim1TypeId, sbdi.ItemDim1Id, sbdi.ItemDim1Name, sbdi.ItemDim1Sort, sbdi.ItemDim1Active, 1),
						(sbdi.ItemDim2TypeId, sbdi.ItemDim2Id, sbdi.ItemDim2Name, sbdi.ItemDim2Sort, sbdi.ItemDim2Active, 2),
						(sbdi.ItemDim3TypeId, sbdi.ItemDim3Id, sbdi.ItemDim3Name, sbdi.ItemDim3Sort, sbdi.ItemDim3Active, 3))
					  V (DimTypeID, DimItemID, DimItemName, DimItemSort, DimItemActive, DimNo)
	INNER JOIN pStyleBOMDimType sbdt ON v.DimTypeID = sbdt.DimTypeID
	LEFT JOIN pStyleColorway sc ON V.DimItemID = sc.StyleColorID
	LEFT JOIN pColorPalette cp ON sc.ColorPaletteID = cp.ColorPaletteID
	WHERE V.DimItemID IS NOT NULL AND sbdi.StyleBOMDimensionID = @StyleBOMDimensionID AND V.DimNo = @DimNo
	ORDER BY V.DimItemSort
	
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07558', GetDate())
GO
