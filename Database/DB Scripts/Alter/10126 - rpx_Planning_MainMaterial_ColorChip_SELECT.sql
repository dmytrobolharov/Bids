IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Planning_MainMaterial_ColorChip_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Planning_MainMaterial_ColorChip_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Planning_MainMaterial_ColorChip_SELECT]
(
	@PlanningItemID UNIQUEIDENTIFIER
)
AS
BEGIN
	SELECT
		ROW_NUMBER() OVER(ORDER BY cp.ColorCode, cp.ColorName) / 7 AS [Row]
		, ROW_NUMBER() OVER(ORDER BY cp.ColorCode, cp.ColorName) % 7 AS [Column]
		, dbo.fnx_GetStreamingColorImagePath(cp.ColorFolderID, cp.ColorPaletteID, '100') as FilePath
		, cp.ColorName
		, cp.ColorCode	
	FROM pPlanningItem pi
		INNER JOIN (
			SELECT StyleBomDimensionID, V.* FROM pStyleBOMDimensionItem
				CROSS APPLY (VALUES (ItemDim1TypeId, ItemDim1Id, ItemDim1Active),
									(ItemDim2TypeId, ItemDim2Id, ItemDim2Active),
									(ItemDim3TypeId, ItemDim3Id, ItemDim3Active)
							) V (ItemDimTypeID, ItemDimID, ItemDimActive)
				INNER JOIN pStyleBOMDimType sbdt ON V.ItemDimTypeID = sbdt.DimTypeID
			WHERE v.ItemDimID IS NOT NULL AND sbdt.DimTypeName = 'Color' AND V.ItemDimActive = 1
			) sbdi ON pi.StyleBOMDimensionID = sbdi.StyleBOMDimensionID
		INNER JOIN pStyleColorway sc ON sbdi.ItemDimID = sc.StyleColorID
		INNER JOIN pColorPalette cp ON sc.ColorPaletteID = cp.ColorPaletteID
	WHERE pi.PlanningItemID = @PlanningItemID
END
GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10126', GetUTCDate())
GO