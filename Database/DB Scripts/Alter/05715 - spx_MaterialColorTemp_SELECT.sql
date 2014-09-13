/****** Object:  StoredProcedure [dbo].[spx_MaterialColorTemp_SELECT]    Script Date: 05/21/2013 12:06:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialColorTemp_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialColorTemp_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialColorTemp_SELECT]	
	@MaterialID UNIQUEIDENTIFIER	
AS
BEGIN
	SELECT * FROM tmpMaterialColor tmc
	INNER JOIN pColorPalette cp ON tmc.ColorPaletteID = cp.ColorPaletteID
	WHERE tmc.MaterialID = @MaterialID
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05715', GetDate())
GO
