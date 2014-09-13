IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMMultiDimMaterial_select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMMultiDimMaterial_select]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleBOMMultiDimMaterial_select](
@StyleBOMDimensionId nvarchar(50),
@StyleID nvarchar(50), 
@StyleSet INT ,
@WorkflowID nvarchar(50), 
@WorkflowItemID nvarchar(50),
@DimSel nvarchar(5)
)
AS 

if @DimSel='12'
	begin
		SELECT StyleMaterialId, MaterialNo, MaterialName, UOM.UOM, MainMaterial, MaterialType, MaterialSort, ComponentOrder,
		Dim1TypeSel, Dim2TypeSel, Dim3TypeSel, MaterialColorID = COALESCE(MaterialColorID,'00000000-0000-0000-0000-000000000000') ,  
		MaterialSizeID = COALESCE(MaterialSizeID,'00000000-0000-0000-0000-000000000000'), MaterialQty = COALESCE(Qty,'0'), MaterialPrice							           
		FROM pstylebom INNER JOIN pComponentType ON pStyleBOM.MaterialType = pComponentType.ComponentTypeID
		LEFT OUTER JOIN UOM ON pStyleBOM.UOM = UOM.UOMvalue
		where styleBOMDimensionId=@StyleBOMDimensionId and Dim1TypeSel=1 and Dim2TypeSel=1 and (Dim3TypeSel=0 or Dim3TypeSel is null)
		ORDER BY MainMaterial DESC, ComponentOrder, MaterialSort, MaterialNo, MaterialName
	end	
	
if @DimSel='123'
	begin
		SELECT StyleMaterialId, MaterialNo, MaterialName, UOM.UOM, MainMaterial, MaterialType, MaterialSort, ComponentOrder,
		Dim1TypeSel, Dim2TypeSel, Dim3TypeSel, MaterialColorID = COALESCE(MaterialColorID,'00000000-0000-0000-0000-000000000000') ,  
		MaterialSizeID = COALESCE(MaterialSizeID,'00000000-0000-0000-0000-000000000000'), MaterialQty = COALESCE(Qty,'0'), MaterialPrice							           
		FROM pstylebom INNER JOIN pComponentType ON pStyleBOM.MaterialType = pComponentType.ComponentTypeID
		LEFT OUTER JOIN UOM ON pStyleBOM.UOM = UOM.UOMvalue
		where styleBOMDimensionId=@StyleBOMDimensionId and Dim1TypeSel=1 and Dim2TypeSel=1 and Dim3TypeSel=1 
		ORDER BY MainMaterial DESC, ComponentOrder, MaterialSort, MaterialNo, MaterialName
	end		
	
if @DimSel='13'
	begin
		SELECT StyleMaterialId, MaterialNo, MaterialName, UOM.UOM, MainMaterial, MaterialType, MaterialSort, ComponentOrder,
		Dim1TypeSel, Dim2TypeSel, Dim3TypeSel, MaterialColorID = COALESCE(MaterialColorID,'00000000-0000-0000-0000-000000000000') ,  
		MaterialSizeID = COALESCE(MaterialSizeID,'00000000-0000-0000-0000-000000000000'), MaterialQty = COALESCE(Qty,'0'), MaterialPrice							           
		FROM pstylebom INNER JOIN pComponentType ON pStyleBOM.MaterialType = pComponentType.ComponentTypeID
		LEFT OUTER JOIN UOM ON pStyleBOM.UOM = UOM.UOMvalue
		where styleBOMDimensionId=@StyleBOMDimensionId and Dim1TypeSel=1 and Dim3TypeSel=1 and (Dim2TypeSel=0 or Dim2TypeSel is null)
		ORDER BY MainMaterial DESC, ComponentOrder, MaterialSort, MaterialNo, MaterialName
	end		
	
if @DimSel='23'
begin
	SELECT StyleMaterialId, MaterialNo, MaterialName, UOM.UOM, MainMaterial, MaterialType, MaterialSort, ComponentOrder,
	Dim1TypeSel, Dim2TypeSel, Dim3TypeSel, MaterialColorID = COALESCE(MaterialColorID,'00000000-0000-0000-0000-000000000000') ,  
	MaterialSizeID = COALESCE(MaterialSizeID,'00000000-0000-0000-0000-000000000000'), MaterialQty = COALESCE(Qty,'0'), MaterialPrice							           
	FROM pstylebom INNER JOIN pComponentType ON pStyleBOM.MaterialType = pComponentType.ComponentTypeID
	LEFT OUTER JOIN UOM ON pStyleBOM.UOM = UOM.UOMvalue
	where styleBOMDimensionId=@StyleBOMDimensionId and Dim2TypeSel=1 and Dim3TypeSel=1 and (Dim1TypeSel=0 or Dim1TypeSel is null)
	ORDER BY MainMaterial DESC, ComponentOrder, MaterialSort, MaterialNo, MaterialName
end	
	
if @DimSel='1'
begin
	SELECT StyleMaterialId, MaterialNo, MaterialName, UOM.UOM, MainMaterial, MaterialType, MaterialSort, ComponentOrder,
	Dim1TypeSel, Dim2TypeSel, Dim3TypeSel, MaterialColorID = COALESCE(MaterialColorID,'00000000-0000-0000-0000-000000000000') ,  
	MaterialSizeID = COALESCE(MaterialSizeID,'00000000-0000-0000-0000-000000000000'), MaterialQty = COALESCE(Qty,'0'), MaterialPrice							           
	FROM pstylebom INNER JOIN pComponentType ON pStyleBOM.MaterialType = pComponentType.ComponentTypeID
	LEFT OUTER JOIN UOM ON pStyleBOM.UOM = UOM.UOMvalue
	where styleBOMDimensionId=@StyleBOMDimensionId and Dim1TypeSel=1 and (Dim2TypeSel=0 or Dim2TypeSel is null) and (Dim3TypeSel=0 or Dim3TypeSel is null)
	ORDER BY MainMaterial DESC, ComponentOrder, MaterialSort, MaterialNo, MaterialName
end	

if @DimSel='2'
begin
	SELECT StyleMaterialId, MaterialNo, MaterialName, UOM.UOM, MainMaterial, MaterialType, MaterialSort, ComponentOrder,
	Dim1TypeSel, Dim2TypeSel, Dim3TypeSel, MaterialColorID = COALESCE(MaterialColorID,'00000000-0000-0000-0000-000000000000') ,  
	MaterialSizeID = COALESCE(MaterialSizeID,'00000000-0000-0000-0000-000000000000'), MaterialQty = COALESCE(Qty,'0'), MaterialPrice							           
	FROM pstylebom INNER JOIN pComponentType ON pStyleBOM.MaterialType = pComponentType.ComponentTypeID
	LEFT OUTER JOIN UOM ON pStyleBOM.UOM = UOM.UOMvalue
	where styleBOMDimensionId=@StyleBOMDimensionId and Dim2TypeSel=1 and (Dim1TypeSel=0 or Dim1TypeSel is null) and (Dim3TypeSel=0 or Dim3TypeSel is null)
	ORDER BY MainMaterial DESC, ComponentOrder, MaterialSort, MaterialNo, MaterialName
end	


if @DimSel='3'
begin
	SELECT StyleMaterialId, MaterialNo, MaterialName, UOM.UOM, MainMaterial, MaterialType, MaterialSort, ComponentOrder,
	Dim1TypeSel, Dim2TypeSel, Dim3TypeSel, MaterialColorID = COALESCE(MaterialColorID,'00000000-0000-0000-0000-000000000000') ,  
	MaterialSizeID = COALESCE(MaterialSizeID,'00000000-0000-0000-0000-000000000000'), MaterialQty = COALESCE(Qty,'0'), MaterialPrice							           
	FROM pstylebom INNER JOIN pComponentType ON pStyleBOM.MaterialType = pComponentType.ComponentTypeID
	LEFT OUTER JOIN UOM ON pStyleBOM.UOM = UOM.UOMvalue
	where styleBOMDimensionId=@StyleBOMDimensionId and Dim3TypeSel=1 and (Dim2TypeSel=0 or Dim2TypeSel is null) and (Dim1TypeSel=0 or Dim1TypeSel is null)
	ORDER BY MainMaterial DESC, ComponentOrder, MaterialSort, MaterialNo, MaterialName
end	

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03628', GetDate())
GO