IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Color_ImageData_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Color_ImageData_Select]
GO

CREATE PROCEDURE [dbo].[spx_Color_ImageData_Select]
(
	@ColorFolderID UNIQUEIDENTIFIER
	,@ColorPaletteID UNIQUEIDENTIFIER
	,@PendingColor INT = 0
)
AS
IF @PendingColor = 0
BEGIN
	SELECT ImageID, ImageVersion
	FROM pColorPalette
	WHERE ColorFolderID = @ColorFolderID
		AND ColorPaletteID = @ColorPaletteID
END
ELSE
BEGIN
	SELECT ImageID, ImageVersion
	FROM ColorLibraryPending
	WHERE ColorFolderID = @ColorFolderID
		AND ColorPaletteID = @ColorPaletteID
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09337', GetDate())
GO
