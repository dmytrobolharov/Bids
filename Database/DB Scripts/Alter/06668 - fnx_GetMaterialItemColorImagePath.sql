/****** Object:  UserDefinedFunction [dbo].[fnx_GetMaterialItemColorImagePath]    Script Date: 11/22/2013 13:54:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetMaterialItemColorImagePath]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetMaterialItemColorImagePath]
GO

/****** Object:  UserDefinedFunction [dbo].[fnx_GetMaterialItemColorImagePath]    Script Date: 11/22/2013 13:54:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE FUNCTION [dbo].[fnx_GetMaterialItemColorImagePath]
(
    @MaterialColorID UNIQUEIDENTIFIER
)

RETURNS NVARCHAR(255)

AS

BEGIN
	DECLARE @MaterialItemColorImagePath NVARCHAR (255)
	
	SELECT @MaterialItemColorImagePath=dbo.fnx_GetStreamingColorImagePath(C.ColorFolderID,C.ColorPaletteID)
	FROM pMaterialColor S,  pColorPalette C 
	WHERE S.MaterialColorID=@MaterialColorID 
	AND C.ColorPaletteID = S.ColorPaletteID 
	
	RETURN @MaterialItemColorImagePath
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06668', GetDate())
GO