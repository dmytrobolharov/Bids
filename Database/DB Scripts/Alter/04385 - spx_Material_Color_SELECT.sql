IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Material_Color_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Material_Color_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_Material_Color_SELECT](
	@MaterialID UNIQUEIDENTIFIER
)
AS 

	SELECT a.MaterialColorID, a.MaterialColorImageID, a.MaterialColorImageVersion, 
		a.MaterialColorNote,
		a.ColorCode, a.ColorName, b.ColorPaletteCustom4 , b.ColorSource,
		b.ColorPaletteID, b.ColorFolderID, b.Hex, b.R, b.G, b.B, b.LAB_A, b.LAB_B, b.LAB_L
	FROM dbo.pMaterialColor a WITH(NOLOCK)
		INNER JOIN dbo.pColorPalette b WITH(NOLOCK)  ON a.ColorPaletteID = b.ColorPaletteID
	WHERE a.MaterialID = @MaterialID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04385', GetDate())
GO
