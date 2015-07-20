IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderItem_BOMMaterials_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderItem_BOMMaterials_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LineFolderItem_BOMMaterials_SELECT]
	@StyleBOMDimensionID UNIQUEIDENTIFIER
AS
BEGIN

	SELECT bom.StyleMaterialID, bom.MaterialID, bom.MaterialImageID, bom.MaterialImageVersion, 
		bom.MaterialNo, bom.MaterialName, bom.MainMaterial, mat.DutyCategoryID, 1 as IsVisible 
	FROM pStyleBOM bom
		LEFT JOIN pMaterial mat ON bom.MaterialID = mat.MaterialID 
	WHERE bom.StyleBOMDimensionID = @StyleBOMDimensionID
	UNION
	SELECT '00000000-0000-0000-0000-000000000000' as StyleMaterialID, '00000000-0000-0000-0000-000000000000' as MaterialID, 
		NULL as MaterialImageID, NULL as MaterialImageVersion, 
		'No Material' as MaterialNo, 'No Material' as MaterialName, NULL as MainMaterial, NULL as DutyCategoryID, 0 as IsVisible
	ORDER BY IsVisible, MainMaterial DESC, MaterialNo ASC

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06107', GetDate())
GO
