 IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Material_Color_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_Material_Color_SELECT]
GO



CREATE PROCEDURE dbo.spx_Material_Color_SELECT(
	@MaterialID UNIQUEIDENTIFIER
)
AS 

	SELECT a.MaterialColorID, b.ColorCode, b.ColorName, b.ColorPaletteCustom4 , b.ColorSource,
		a.MaterialColorImageID, a.MaterialColorImageVersion, b.ColorPaletteID, b.ColorFolderID
	FROM dbo.pMaterialColor a WITH(NOLOCK)
		INNER JOIN dbo.pColorPalette b WITH(NOLOCK)  ON a.ColorPaletteID = b.ColorPaletteID
	WHERE a.MaterialID = @MaterialID
	
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01357', GetDate())
GO

