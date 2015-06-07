IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorPalette_ImageVersion_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorPalette_ImageVersion_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_ColorPalette_ImageVersion_UPDATE]
	@ColorPaletteID UNIQUEIDENTIFIER,
	@ImageVersion NVARCHAR(10)
AS
BEGIN
	UPDATE pColorPalette SET ImageVersion = @ImageVersion WHERE ColorPaletteID = @ColorPaletteID
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09342', GetDate())
GO
