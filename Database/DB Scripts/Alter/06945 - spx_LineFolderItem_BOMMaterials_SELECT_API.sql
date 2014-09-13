

/****** Object:  StoredProcedure [dbo].[spx_LineFolderItem_BOMMaterials_SELECT_API]    Script Date: 01/16/2014 14:40:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderItem_BOMMaterials_SELECT_API]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderItem_BOMMaterials_SELECT_API]
GO


/****** Object:  StoredProcedure [dbo].[spx_LineFolderItem_BOMMaterials_SELECT_API]    Script Date: 01/16/2014 14:40:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_LineFolderItem_BOMMaterials_SELECT_API]
	@StyleBOMDimensionID UNIQUEIDENTIFIER
AS
BEGIN

	SELECT bom.StyleMaterialID, bom.MaterialID, COALESCE(bom.MaterialImageID,'00000000-0000-0000-0000-000000000000') as MaterialImageID , COALESCE(bom.MaterialImageVersion,1) as MaterialImageVersion,
		bom.MaterialNo, bom.MaterialName, bom.MainMaterial, mat.DutyCategoryID, 1 as IsVisible 
	FROM pStyleBOM bom
		LEFT JOIN pMaterial mat ON bom.MaterialID = mat.MaterialID 
	WHERE bom.StyleBOMDimensionID = @StyleBOMDimensionID
	ORDER BY IsVisible, MainMaterial DESC, MaterialNo ASC

END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '06945', GetDate())
GO
