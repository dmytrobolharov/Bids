IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorPaletteImage_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorPaletteImage_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_ColorPaletteImage_UPDATE] (
@ColorFolderID uniqueidentifier,
	@ColorPaletteID UNIQUEIDENTIFIER
	,@ImageID UNIQUEIDENTIFIER
	,@ImageVersion INt
	,@CUser NVARCHAR(200)
	,@CDate DATETIME
	)
AS
UPDATE pColorPalette
SET ImageID = @ImageID
	,ImageVersion = @ImageVersion
	,MUser = @CUser
	,MDate = @CDate
WHERE ColorPaletteID = @ColorPaletteID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09345', GetDate())
GO
