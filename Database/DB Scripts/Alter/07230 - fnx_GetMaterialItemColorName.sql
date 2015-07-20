IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetMaterialItemColorName]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetMaterialItemColorName]
GO

CREATE FUNCTION [dbo].[fnx_GetMaterialItemColorName]
(
    @MaterialColorID UNIQUEIDENTIFIER
)

RETURNS NVARCHAR(255)

AS

BEGIN
	DECLARE @MaterialItemColorName NVARCHAR (255)
	
	SELECT @MaterialItemColorName=C.ColorName
	FROM pMaterialColor S,  pColorPalette C 
	WHERE S.MaterialColorID=@MaterialColorID 
	AND C.ColorPaletteID = S.ColorPaletteID 
	
	RETURN @MaterialItemColorName
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07230', GetDate())
GO
