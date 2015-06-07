IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_SeasonalMaterialColorwayBOM_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_SeasonalMaterialColorwayBOM_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Style_SeasonalMaterialColorwayBOM_SELECT]  
(
	@WorkflowItemID UNIQUEIDENTIFIER
)
AS
BEGIN
	SELECT DISTINCT
		sb.StyleMaterialID
		, sb.MaterialNo
		, sb.MaterialName
		, tprl.TradePartnerFullName
		, sb.Qty
		, ms.MaterialSize
		, sb.Placement
		, cp.ColorCode
		, cp.ColorName
		, mc.ColorCode AS MaterialColorCode
		, mc.ColorName AS MaterialColorName
		, dbo.fnx_GetStreamingColorImagePath(mc.ColorFolderID, mc.ColorPaletteID, '100') AS MaterialColorFilePath
		, dbo.fnx_GetStreamingColorImagePath(cp.ColorFolderID, cp.ColorPaletteID, '100') AS ColorFilePath
		, CASE
			WHEN sbdi.ItemDim1Id IS NULL THEN sbdi.ItemDim1Sort
			WHEN sbdi.ItemDim2Id IS NULL THEN sbdi.ItemDim2Sort
			ELSE sbdi.ItemDim3Sort
		  END AS DimSort
		, sb.MainMaterial
		, ct.ComponentOrder
		, sb.MaterialSort
	FROM pStyleBOM sb
		INNER JOIN pComponentType ct ON sb.MaterialType = ct.ComponentTypeID
		INNER JOIN pStyleBOMDimensionItem sbdi ON sb.StyleBOMDimensionId = sbdi.StyleBOMDimensionID
		INNER JOIN pStyleColorway sc ON (sbdi.ItemDim1Id = sc.StyleColorID AND sbdi.ItemDim1Active = 1)
									 OR (sbdi.ItemDim2Id = sc.StyleColorID AND sbdi.ItemDim1Active = 1)
									 OR (sbdi.ItemDim3Id = sc.StyleColorID AND sbdi.ItemDim1Active = 1)
		INNER JOIN pColorPalette cp ON sc.ColorPaletteID = cp.ColorPaletteID
		INNER JOIN pStyleBOMItem sbi ON sb.StyleMaterialID = sbi.StyleMaterialID AND (sc.StyleColorID IN(sbdi.ItemDim1Id, sbdi.ItemDim2Id, sbdi.ItemDim3Id))
		LEFT JOIN pMaterialColor mc ON sbi.MaterialColorId = mc.MaterialColorID
		LEFT JOIN pMaterialSize ms ON sb.MaterialSizeID = ms.MaterialSizeID
		LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON sb.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
	WHERE sb.WorkFlowItemID = @WorkflowItemID 
	ORDER BY
		sb.MainMaterial DESC
		, ct.ComponentOrder
		, sb.MaterialSort
		, sb.MaterialNo
		, sb.MaterialName
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10288', GetUTCDate())
GO