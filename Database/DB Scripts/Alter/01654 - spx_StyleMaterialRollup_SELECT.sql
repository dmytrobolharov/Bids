/****** Object:  StoredProcedure [dbo].[spx_StyleMaterialRollup_SELECT]    Script Date: 06/9/2011 19:14:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMaterialRollup_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMaterialRollup_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleMaterialRollup_SELECT]    Script Date: 06/9/2011 19:14:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleMaterialRollup_SELECT]
(
@StyleId uniqueidentifier,
@StyleSet int
)
AS

--SELECT '   ' AS cellSpace, 'BOM Costing  ' AS [Cost Type ], '$' + CAST(CAST(SUM(ISNULL(Qty,1) * MaterialPrice) AS DECIMAL(18,2)) AS VARCHAR(10)) + '' AS [Total Cost], '   ' AS cellSpace1
--FROM         dbo.pStyleMaterials
--WHERE pStyleMaterials.StyleId = @StyleId AND pStyleMaterials.StyleSet = @StyleSet AND MaterialBOM = 1
--GROUP BY StyleID, MaterialBOM
--UNION ALL
--SELECT '   ' AS cellSpace, 'Total Costing  ' AS [Cost Type ], '$' +  CAST(CAST(SUM(ISNULL(Qty,1) * MaterialPrice) AS DECIMAL(18,2)) AS VARCHAR(10)) + '' AS Total, '   ' AS cellSpace1
--FROM         dbo.pStyleMaterials
--WHERE pStyleMaterials.StyleId = @StyleId AND pStyleMaterials.StyleSet = @StyleSet
--GROUP BY StyleID

Declare @MaterialPrice1 DECIMAL(18,2)
Declare @MaterialPrice0 DECIMAL(18,2)
Set @MaterialPrice1 = 1.00
Set @MaterialPrice0 = 0.00

SELECT '   ' AS cellSpace, 'BOM Costing  ' AS [Cost Type ], '$' + CAST(CAST(SUM(ISNULL(CASE WHEN Qty<>@MaterialPrice0 THEN Qty ELSE @MaterialPrice1 END,1) * isnull(MaterialPrice,VolumePrice)) AS DECIMAL(18,2)) AS VARCHAR(10)) + '' AS [Total Cost], '   ' AS cellSpace1
FROM         dbo.pStyleMaterials
WHERE pStyleMaterials.StyleId = @StyleId AND pStyleMaterials.StyleSet = @StyleSet AND MaterialBOM = 1
GROUP BY StyleID, MaterialBOM
UNION ALL
SELECT '   ' AS cellSpace, 'Total Costing  ' AS [Cost Type ], '$' +  CAST(CAST(SUM(ISNULL(CASE WHEN Qty<>@MaterialPrice0 THEN Qty ELSE @MaterialPrice1 END,1) * isnull(MaterialPrice,VolumePrice)) AS DECIMAL(18,2)) AS VARCHAR(10)) + '' AS Total, '   ' AS cellSpace1
FROM         dbo.pStyleMaterials
WHERE pStyleMaterials.StyleId = @StyleId AND pStyleMaterials.StyleSet = @StyleSet
GROUP BY StyleID

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01654'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01654', GetDate())
END
GO