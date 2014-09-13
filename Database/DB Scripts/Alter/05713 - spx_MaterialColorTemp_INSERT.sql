/****** Object:  StoredProcedure [dbo].[spx_MaterialColorTemp_INSERT]    Script Date: 05/21/2013 12:06:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialColorTemp_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialColorTemp_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialColorTemp_INSERT]	
	@MaterialID UNIQUEIDENTIFIER,
	@ColorPaletteID UNIQUEIDENTIFIER
AS
BEGIN
	if NOT EXISTS(SELECT * FROM tmpMaterialColor WHERE MaterialID = @MaterialID AND ColorPaletteID = @ColorPaletteID)
	begin
		INSERT INTO tmpMaterialColor(MaterialID, ColorPaletteID)
		VALUES(@MaterialID, @ColorPaletteID)
	end
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05713', GetDate())
GO
