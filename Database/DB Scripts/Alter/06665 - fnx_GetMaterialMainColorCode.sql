/****** Object:  UserDefinedFunction [dbo].[fnx_GetMaterialMainColorCode]    Script Date: 11/22/2013 12:27:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetMaterialMainColorCode]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetMaterialMainColorCode]
GO

/****** Object:  UserDefinedFunction [dbo].[fnx_GetMaterialMainColorCode]    Script Date: 11/22/2013 12:27:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE FUNCTION [dbo].[fnx_GetMaterialMainColorCode]
(
    @ColorPaletteID UNIQUEIDENTIFIER
)

RETURNS NVARCHAR(255)

AS

BEGIN
	DECLARE @MaterialMainColorCode NVARCHAR (255)
	
	SELECT @MaterialMainColorCode=ISNULL('(' + C.ColorCode + ') ','')
	FROM   pColorPalette C WHERE C.ColorPaletteID=@ColorPaletteID
	
	RETURN @MaterialMainColorCode
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06665', GetDate())
GO
