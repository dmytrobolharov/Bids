/****** Object:  UserDefinedFunction [dbo].[fnx_GetMaterialMainColorImagePath]    Script Date: 11/22/2013 12:33:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetMaterialMainColorImagePath]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetMaterialMainColorImagePath]
GO

/****** Object:  UserDefinedFunction [dbo].[fnx_GetMaterialMainColorImagePath]    Script Date: 11/22/2013 12:33:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE FUNCTION [dbo].[fnx_GetMaterialMainColorImagePath]
(
    @ColorPaletteID UNIQUEIDENTIFIER
)

RETURNS NVARCHAR(255)

AS

BEGIN
	DECLARE @MaterialMainColorImagePath NVARCHAR (255)
	
	SELECT @MaterialMainColorImagePath=dbo.fnx_GetStreamingColorImagePath(C.ColorFolderID,C.ColorPaletteID)
	FROM   pColorPalette C WHERE C.ColorPaletteID=@ColorPaletteID
	
	RETURN @MaterialMainColorImagePath
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06666', GetDate())
GO