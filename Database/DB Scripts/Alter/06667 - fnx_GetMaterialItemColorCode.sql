/****** Object:  UserDefinedFunction [dbo].[fnx_GetMaterialItemColorCode]    Script Date: 11/22/2013 13:48:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetMaterialItemColorCode]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetMaterialItemColorCode]
GO

/****** Object:  UserDefinedFunction [dbo].[fnx_GetMaterialItemColorCode]    Script Date: 11/22/2013 13:48:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE FUNCTION [dbo].[fnx_GetMaterialItemColorCode]
(
    @MaterialColorID UNIQUEIDENTIFIER
)

RETURNS NVARCHAR(255)

AS

BEGIN
	DECLARE @MaterialItemColorCode NVARCHAR (255)
	
	SELECT @MaterialItemColorCode=ISNULL('(' + C.ColorCode + ') ','')
	FROM pMaterialColor S,  pColorPalette C 
	WHERE S.MaterialColorID=@MaterialColorID 
	AND C.ColorPaletteID = S.ColorPaletteID
	 
	RETURN @MaterialItemColorCode
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06667', GetDate())
GO