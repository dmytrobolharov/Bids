IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetMaterialMainColorImagePath]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetMaterialMainColorImagePath]
GO

CREATE FUNCTION [dbo].[fnx_GetMaterialMainColorImagePath]
(
    @ColorPaletteID UNIQUEIDENTIFIER
)

RETURNS NVARCHAR(255)

AS

BEGIN
	DECLARE @MaterialMainColorImagePath NVARCHAR (255)
	
	SELECT @MaterialMainColorImagePath=dbo.fnx_GetStreamingColorImagePath(C.ColorFolderID,C.ColorPaletteID, '100')
	FROM   pColorPalette C WHERE C.ColorPaletteID=@ColorPaletteID
	
	RETURN @MaterialMainColorImagePath
END

GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10070', GetUTCDate())
GO