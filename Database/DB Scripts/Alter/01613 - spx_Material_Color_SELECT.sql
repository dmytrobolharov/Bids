IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Material_Color_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_Material_Color_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Material_Color_SELECT](
	@MaterialID UNIQUEIDENTIFIER
)
AS 

	SELECT a.MaterialColorID, a.MaterialColorImageID, a.MaterialColorImageVersion, 
		a.MaterialColorNote,
		b.ColorCode, b.ColorName, b.ColorPaletteCustom4 , b.ColorSource,
		b.ColorPaletteID, b.ColorFolderID, b.Hex, b.R, b.G, b.B, b.LAB_A, b.LAB_B, b.LAB_L
	FROM dbo.pMaterialColor a WITH(NOLOCK)
		INNER JOIN dbo.pColorPalette b WITH(NOLOCK)  ON a.ColorPaletteID = b.ColorPaletteID
	WHERE a.MaterialID = @MaterialID
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01613'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01613', GetDate())
END	

GO
