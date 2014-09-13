/****** Object:  StoredProcedure [dbo].[spx_ColorPaletteCopy_INSERT]    Script Date: 06/22/2012 17:52:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorPaletteCopy_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorPaletteCopy_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_ColorPaletteCopy_INSERT]    Script Date: 06/22/2012 17:52:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* Comment #1  - Clayton Parker Oct 29 2009 .
	Burberry wants to be able to copy a chip into a palette even if the names are the same. 
	This is because they will create chips with the same name but with a different ColorCode. 
		I removed from the statement:
			OR ColorName = @ColorName   
*/


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
	ColorPaletteCustom5, ColorPaletteCustom6, ColorPaletteCustom7, ColorPaletteCustom8, ColorPaletteCustom9, ColorPaletteCustom10)
	SELECT ColorPaletteID = @ColorPaletteNewID , ColorFolderID = @ColorFolderID , ColorCode, ColorName , ColorSource, ColorNotes, Hex, R, G, B,  C, M, Y, K, H, S, L, LAB_L, LAB_A, LAB_B, 
	CUser = @CUser, CDate = @CDate,  MUser = @CUser, MDate = @CDate, ColorID, Change, [Action], Active, Sort , ColorImage, CopyColorPaletteID = @ColorPaletteCopyID, ColorPaletteCustom1, ColorPaletteCustom2, ColorPaletteCustom3, ColorPaletteCustom4,
	ColorPaletteCustom5, ColorPaletteCustom6, ColorPaletteCustom7, ColorPaletteCustom8, ColorPaletteCustom9, ColorPaletteCustom10
	FROM pColorPalette WITH (NOLOCK) WHERE ColorPaletteID = @ColorPaletteCopyID
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03669', GetDate())
GO