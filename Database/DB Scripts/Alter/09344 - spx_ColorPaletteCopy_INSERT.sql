IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorPaletteCopy_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorPaletteCopy_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_ColorPaletteCopy_INSERT]  ( 
@ColorPaletteNewID uniqueidentifier, 
@ColorPaletteCopyID uniqueidentifier, 
@ColorFolderID uniqueidentifier, 
@CUser nVarchar (200) , 
@CDate datetime 
) 
AS

DECLARE @ColorCode NVARCHAR(200)
DECLARE @ColorName NVARCHAR(200)

SELECT @ColorCode  = ColorCode, @ColorName = ColorName 
FROM pColorPalette WHERE ColorPaletteID =  @ColorPaletteCopyID

IF ( 
	SELECT COUNT(*) FROM pColorPalette WITH (NOLOCK) 
	WHERE ColorFolderID = @ColorFolderID  
	AND  (  CopyColorPaletteID = @ColorPaletteCopyID OR ColorCode = @ColorCode  )  -- #01
	)  = 0 
BEGIN 


	INSERT INTO pColorPalette ( ColorPaletteID , ColorFolderID , ColorCode, ColorName , ColorSource, ColorNotes, Hex, R, G, B,  C, M, Y, K, H, S, L, LAB_L, LAB_A, LAB_B, 
	CUser, CDate,  MUser, MDate, ColorID, Change, [Action], Active, Sort, ColorImage, CopyColorPaletteID, ColorPaletteCustom1, ColorPaletteCustom2, ColorPaletteCustom3, ColorPaletteCustom4,
	ColorPaletteCustom5, ColorPaletteCustom6, ColorPaletteCustom7, ColorPaletteCustom8, ColorPaletteCustom9, ColorPaletteCustom10, ImageID, ImageVersion)
	SELECT ColorPaletteID = @ColorPaletteNewID , ColorFolderID = @ColorFolderID , ColorCode, ColorName , ColorSource, ColorNotes, Hex, R, G, B,  C, M, Y, K, H, S, L, LAB_L, LAB_A, LAB_B, 
	CUser = @CUser, CDate = @CDate,  MUser = @CUser, MDate = @CDate, ColorID, Change, [Action], Active, Sort , ColorImage, CopyColorPaletteID = @ColorPaletteCopyID, ColorPaletteCustom1, ColorPaletteCustom2, ColorPaletteCustom3, ColorPaletteCustom4,
	ColorPaletteCustom5, ColorPaletteCustom6, ColorPaletteCustom7, ColorPaletteCustom8, ColorPaletteCustom9, ColorPaletteCustom10, ImageID, ImageVersion
	FROM pColorPalette WITH (NOLOCK) WHERE ColorPaletteID = @ColorPaletteCopyID
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09344', GetDate())
GO
