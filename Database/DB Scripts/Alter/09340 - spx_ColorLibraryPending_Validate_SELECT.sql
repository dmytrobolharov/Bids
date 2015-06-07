IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorLibraryPending_Validate_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorLibraryPending_Validate_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_ColorLibraryPending_Validate_SELECT] (
	@ColorPaletteID UNIQUEIDENTIFIER
	,@ColorFolderID UNIQUEIDENTIFIER
	,@CUser NVARCHAR(500)
	,@RequiredFields NVARCHAR(500)
	)
AS
DECLARE @sqlCommand NVARCHAR(2000)

SET @sqlCommand = 'SELECT * FROM ColorLibraryPending WHERE ' + @RequiredFields + 
	' AND CUser = @CUser AND ColorFolderID = @ColorFolderID AND ColorPaletteID = @ColorPaletteID'

EXECUTE sp_executesql @sqlCommand
	,
	N'@CUser nvarchar(500), @ColorFolderID UNIQUEIDENTIFIER, @ColorPaletteID UNIQUEIDENTIFIER'
	,@CUser
	,@ColorFolderID
	,@ColorPaletteID
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09340', GetDate())
GO
