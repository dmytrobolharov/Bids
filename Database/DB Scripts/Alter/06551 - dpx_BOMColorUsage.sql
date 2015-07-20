IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_BOMColorUsage]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_BOMColorUsage]
GO

CREATE PROCEDURE [dbo].[dpx_BOMColorUsage]

AS
BEGIN

CREATE TABLE #tmpColorMat
(
	Season NVARCHAR(200)
	, Year NVARCHAR(200)
	, DivisionID UNIQUEIDENTIFIER
	, Division NVARCHAR(200)
	, ColorDescription NVARCHAR(500)
	, MaterialColorId UNIQUEIDENTIFIER
	, MaterialID UNIQUEIDENTIFIER
	, StyleMaterialID UNIQUEIDENTIFIER
	, MaterialNo NVARCHAR(50)
	, MaterialName NVARCHAR(200)
	, StyleID UNIQUEIDENTIFIER
	, StyleNo NVARCHAR(500)
	, Description NVARCHAR(500)
	, Qty NUMERIC(18,4)
	, MaterialPrice NUMERIC(18,4)
	, Units NUMERIC(18,4)
)

INSERT INTO #tmpColorMat
SELECT DISTINCT
	ssy.StyleSeason AS Season
	, ssy.StyleYear AS Year
	, d.CustomID AS DivisionID
	, d.Custom AS Division
	, ISNULL(cpn.ColorName, '') + ISNULL (' (' + cpn.ColorCode + ')', '') AS ColorDescription
	, sbi.MaterialColorId
	, sb.MaterialID
	, sb.StyleMaterialID
	, sb.MaterialNo
	, sb.MaterialName
	, sh.StyleID
	, sh.StyleNo
	, sh.Description
	, ISNULL(sb.Qty, 0) AS Qty
	, ISNULL(sb.MaterialPrice, 0) AS MaterialPrice
	, ISNULL(scsy.Units, 0) AS Units
FROM pStyleBOM sb
	INNER JOIN pStyleHeader sh ON sb.StyleID = sh.StyleID
	INNER JOIN iCustom1 d ON sh.DivisionID = d.CustomID
	INNER JOIN pStyleBOMItem sbi ON sb.StyleMaterialID = sbi.StyleMaterialID AND sb.StyleID = sbi.StyleID
	INNER JOIN pStyleBOMDimension sbd ON sb.StyleBOMDimensionId = sbd.StyleBOMDimensionID
	INNER JOIN pStyleBOMConfig sbc ON sb.StyleBOMDimensionId = sbc.StyleBOMDimensionID AND sbc.DimBOM = 0
	INNER JOIN pWorkFlowItem wfi ON sbd.WorkFlowItemID = wfi.WorkFlowItemID
	INNER JOIN pStyleSeasonYear ssy ON wfi.StyleSeasonYearID = ssy.StyleSeasonYearID
	INNER JOIN pColorPalette cp ON sbi.ItemDim1Id = cp.ColorPaletteID OR sbi.ItemDim2Id = cp.ColorPaletteID OR sbi.ItemDim3Id = cp.ColorPaletteID
	INNER JOIN pStyleColorwaySeasonYear scsy ON cp.ColorPaletteID = scsy.ColorPaletteID AND sbi.StyleID = scsy.StyleID
	INNER JOIN pMaterialColor mc ON sbi.MaterialColorId = mc.MaterialColorID
	LEFT JOIN pColorPalette cpn ON mc.ColorPaletteID = cpn.ColorPaletteID
WHERE wfi.WorkStatus <> 101

SELECT 
	Season
	, Year
	, DivisionID
	, Division
	, ColorDescription
	, MaterialColorId
	, MaterialID
	, StyleMaterialID
	, MaterialNo
	, MaterialName
	, StyleID
	, StyleNo
	, Description
	, Qty
	, MaterialPrice
	, SUM(Units) AS Units
FROM #tmpColorMat	
GROUP BY
	Season
	, Year
	, DivisionID
	, Division
	, ColorDescription
	, MaterialColorId
	, MaterialID
	, StyleMaterialID
	, MaterialNo
	, MaterialName
	, StyleID
	, StyleNo
	, Description
	, Qty
	, MaterialPrice
	
DROP TABLE #tmpColorMat

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06551', GetDate())
GO
