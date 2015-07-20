IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMDimMaterial_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMDimMaterial_Select]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



Create PROCEDURE [dbo].[spx_StyleBOMDimMaterial_Select]
(
@StyleBOMDimensionId nvarchar(50)
)
AS 

SELECT StyleMaterialId, MaterialNo, MaterialName, UOM, MainMaterial, MaterialType, MaterialSort, ComponentOrder,
Dim1TypeSel, Dim2TypeSel, Dim3TypeSel, MaterialColorID = COALESCE(MaterialColorID,'00000000-0000-0000-0000-000000000000') ,  
MaterialSizeID = COALESCE(MaterialSizeID,'00000000-0000-0000-0000-000000000000'), MaterialQty = COALESCE(Qty,'0'), MaterialPrice							           
FROM pstylebom INNER JOIN pComponentType ON pStyleBOM.MaterialType = pComponentType.ComponentTypeID
where styleBOMDimensionId=@StyleBOMDimensionId 
ORDER BY MainMaterial DESC, ComponentOrder, MaterialSort, MaterialNo, MaterialName	
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03474', GetDate())
GO