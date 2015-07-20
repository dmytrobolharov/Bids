IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_SeasonalMaterialColorwayBOM_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_SeasonalMaterialColorwayBOM_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Style_SeasonalMaterialColorwayBOM_SELECT]  
(
	@WorkflowItemID UNIQUEIDENTIFIER
)
AS
BEGIN

DECLARE @StyleBOMDimensionId UNIQUEIDENTIFIER

SELECT @StyleBOMDimensionId=StyleBOMDimensionID FROM pStyleBOMDimension WHERE WorkFlowItemID = @WorkflowItemID

SELECT DISTINCT
	sb.MaterialNo
	, sb.MaterialName
	, sb.Placement
	, sbi.ItemDim1Id AS ColorID
	, sbi.MaterialColorId
	, cp.ColorCode
	, cp.ColorName
	, mc.ColorCode AS MaterialColorCode
	, mc.ColorName AS MaterialColorName
	, dbo.fnx_GetStreamingColorImagePath(mc.ColorFolderID,mc.ColorPaletteID) AS MaterialColorFilePath
	, dbo.fnx_GetStreamingColorImagePath(cp.ColorFolderID,cp.ColorPaletteID) AS ColorFilePath
FROM pStyleBOMDimension sbd
	INNER JOIN pStyleBOM sb ON sbd.StyleBOMDimensionID = sb.StyleBOMDimensionId
	INNER JOIN pStyleBOMItem sbi ON sb.StyleMaterialID = sbi.StyleMaterialID
	LEFT JOIN pColorPalette cp ON sbi.ItemDim1Id = cp.ColorPaletteID
	LEFT JOIN pMaterialColor mc ON sbi.MaterialColorId = mc.MaterialColorID
WHERE
	sbd.StyleBOMDimensionID = @StyleBOMDimensionId
	AND LOWER(sbd.ItemDim1TypeName) = 'color'

UNION
SELECT DISTINCT
	sb.MaterialNo
	, sb.MaterialName
	, sb.Placement
	, sbi.ItemDim2Id AS ColorID
	, sbi.MaterialColorId
	, cp.ColorCode
	, cp.ColorName
	, mc.ColorCode AS MaterialColorCode
	, mc.ColorName AS MaterialColorName
	, dbo.fnx_GetStreamingColorImagePath(mc.ColorFolderID,mc.ColorPaletteID) AS MaterialColorFilePath
	, dbo.fnx_GetStreamingColorImagePath(cp.ColorFolderID,cp.ColorPaletteID) AS ColorFilePath
FROM pStyleBOMDimension sbd
	INNER JOIN pStyleBOM sb ON sbd.StyleBOMDimensionID = sb.StyleBOMDimensionId
	INNER JOIN pStyleBOMItem sbi ON sb.StyleMaterialID = sbi.StyleMaterialID
	LEFT JOIN pColorPalette cp ON sbi.ItemDim2Id = cp.ColorPaletteID
	LEFT JOIN pMaterialColor mc ON sbi.MaterialColorId = mc.MaterialColorID
WHERE
	sbd.StyleBOMDimensionID = @StyleBOMDimensionId
	AND LOWER(sbd.ItemDim2TypeName) = 'color'
	
UNION
SELECT DISTINCT
	sb.MaterialNo
	, sb.MaterialName
	, sb.Placement
	, sbi.ItemDim3Id AS ColorID
	, sbi.MaterialColorId
	, cp.ColorCode
	, cp.ColorName
	, mc.ColorCode AS MaterialColorCode
	, mc.ColorName AS MaterialColorName
	, dbo.fnx_GetStreamingColorImagePath(mc.ColorFolderID,mc.ColorPaletteID) AS MaterialColorFilePath
	, dbo.fnx_GetStreamingColorImagePath(cp.ColorFolderID,cp.ColorPaletteID) AS ColorFilePath
FROM pStyleBOMDimension sbd
	INNER JOIN pStyleBOM sb ON sbd.StyleBOMDimensionID = sb.StyleBOMDimensionId
	INNER JOIN pStyleBOMItem sbi ON sb.StyleMaterialID = sbi.StyleMaterialID
	LEFT JOIN pColorPalette cp ON sbi.ItemDim3Id = cp.ColorPaletteID
	LEFT JOIN pMaterialColor mc ON sbi.MaterialColorId = mc.MaterialColorID
WHERE
	sbd.StyleBOMDimensionID = @StyleBOMDimensionId
	AND LOWER(sbd.ItemDim3TypeName) = 'color'
ORDER BY sb.MaterialName

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05619', GetDate())
GO
