IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorLibraryPending_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorLibraryPending_UPDATE]
GO
CREATE PROCEDURE [dbo].[spx_ColorLibraryPending_UPDATE]
(
	@ColorPaletteID UNIQUEIDENTIFIER,
	@ColorFolderID UNIQUEIDENTIFIER
)
AS
BEGIN
	DECLARE @ColorCode NVARCHAR(200) = (SELECT ColorCode FROM ColorLibraryPending WHERE ColorPaletteID = @ColorPaletteID) 
	DECLARE @ColorCodeCount INT
	EXEC @ColorCodeCount = spx_ColorFolder_CheckColorCodeUnique @ColorFolderID = @ColorFolderID, @ColorCode = @ColorCode

	IF @ColorCodeCount = 0
		UPDATE ColorLibraryPending
		SET isUpload = 0
		WHERE ColorPaletteID = @ColorPaletteID
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09339', GetDate())
GO
