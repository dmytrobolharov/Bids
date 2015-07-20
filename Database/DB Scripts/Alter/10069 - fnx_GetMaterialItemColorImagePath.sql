IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetMaterialItemColorImagePath]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetMaterialItemColorImagePath]
GO

CREATE FUNCTION [dbo].[fnx_GetMaterialItemColorImagePath]
(
    @MaterialColorID UNIQUEIDENTIFIER
)

RETURNS NVARCHAR(255)

AS

BEGIN
	DECLARE @MaterialItemColorImagePath NVARCHAR (255)
	
	SELECT @MaterialItemColorImagePath=dbo.fnx_GetStreamingColorImagePath(C.ColorFolderID,C.ColorPaletteID, '100')
	FROM pMaterialColor S,  pColorPalette C 
	WHERE S.MaterialColorID=@MaterialColorID 
	AND C.ColorPaletteID = S.ColorPaletteID 
	
	RETURN @MaterialItemColorImagePath
END




GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10069', GetUTCDate())
GO