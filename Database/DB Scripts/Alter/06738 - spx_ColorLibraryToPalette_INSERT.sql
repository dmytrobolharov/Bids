--WI # 21576 : Color Folder - Create New Unique ID for pColorPalette

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorLibraryToPalette_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorLibraryToPalette_INSERT]
GO

/************************************************************************************************
* Name  : spx_ColorLibraryToPalette_INSERT
* Description :	
*
*           
* Change History:                  
* 
* Comment#		Date				Author						Comment
* #01			12/09/2013			Constantine Volkov			Color Folder - Create New Unique ID for pColorPalette
*************************************************************************************************/

CREATE PROCEDURE [dbo].[spx_ColorLibraryToPalette_INSERT]  ( 
      @BookOrder int, 
      @ColorPaletteID uniqueidentifier, 
      @ColorFolderID uniqueidentifier, 
      @CUser nVarchar (200), 
      @CDate datetime,
      @MUser nVarchar (200), 
      @MDate datetime  
) 
AS

DECLARE @ColorCode nvarchar(50)

DECLARE @ColorSource nvarchar(50)
SELECT @ColorSource = ColorSource FROM ColorLibraryPending WHERE ID = @BookOrder

IF (SELECT COUNT(*) FROM pColorPalette WITH (NOLOCK) WHERE ColorFolderID = @ColorFolderID  AND  ColorCode = @ColorCode)  = 0 
BEGIN 
      IF (SELECT COUNT(*) FROM ColorLibraryPending WITH (NOLOCK) WHERE ColorFolderID = @ColorFolderID  AND  ColorCode = @ColorCode)  = 0 
      BEGIN
            DECLARE @SystemServerStorageID UNIQUEIDENTIFIER
            SELECT @SystemServerStorageID = SystemServerStorageID FROM pColorFolder WHERE ColorFolderID = @ColorFolderID
                  
            IF @ColorSource = 'CUSTOM'
                  BEGIN
                        INSERT INTO pColorPalette (ColorPaletteID, ColorFolderID, ColorCode, ColorName, ColorSource, ColorNotes, 
                              HEX, R, G, B, H, S, L, LAB_L, LAB_A, LAB_B, ColorImageType, 
                              CUser, CDate, MUser, MDate, [Action], ColorImage, SystemServerStorageID
                              --** Comment#01
                              ,ColorLibraryID, ColorPaletteCustom1, ColorPaletteCustom2                              
                              ,ColorPaletteCustom3, ColorPaletteCustom4, ColorPaletteCustom5, ColorPaletteCustom6, ColorPaletteCustom7
							  ,ColorPaletteCustom8, ColorPaletteCustom9, ColorPaletteCustom10) 
                        SELECT @ColorPaletteID, @ColorFolderID, ColorCode,  ColorName, ColorSource, ColorNotes, 
                              HEX, R, G, B, H, S, L, LAB_L, LAB_A, LAB_B, ColorImageType, 
                              @CUser, @CDate, @MUser, @MDate, 1, ColorImage, @SystemServerStorageID
                              --** Comment#01
                              ,ColorLibraryID, ColorPaletteCustom1, ColorPaletteCustom2                              
                              ,ColorPaletteCustom3, ColorPaletteCustom4, ColorPaletteCustom5, ColorPaletteCustom6, ColorPaletteCustom7
							  ,ColorPaletteCustom8, ColorPaletteCustom9, ColorPaletteCustom10
                        FROM ColorLibraryPending WHERE ID = @BookOrder
                  END
            ELSE
                  BEGIN
                        INSERT INTO pColorPalette (ColorPaletteID, ColorFolderID, ColorCode, ColorName, ColorSource, ColorNotes, 
                              HEX, R, G, B, H, S, L, LAB_L, LAB_A, LAB_B, ColorImageType, 
                              CUser, CDate, MUser, MDate, [Action], ColorImage, SystemServerStorageID
                              --** Comment#01
                              ,ColorLibraryID, ColorPaletteCustom1, ColorPaletteCustom2                              
                              ,ColorPaletteCustom3, ColorPaletteCustom4, ColorPaletteCustom5, ColorPaletteCustom6, ColorPaletteCustom7
							  ,ColorPaletteCustom8, ColorPaletteCustom9, ColorPaletteCustom10) 
                        SELECT @ColorPaletteID, @ColorFolderID, ColorCode,  ColorName, ColorSource, ColorNotes, 
                              HEX, R, G, B, H, S, L, LAB_L, LAB_A, LAB_B, ColorImageType, 
                              @CUser, @CDate, @MUser, @MDate, 1, ColorImage, @SystemServerStorageID
                              --** Comment#01
                              ,ColorLibraryID, ColorPaletteCustom1, ColorPaletteCustom2
                              ,ColorPaletteCustom3, ColorPaletteCustom4, ColorPaletteCustom5, ColorPaletteCustom6, ColorPaletteCustom7
							  ,ColorPaletteCustom8, ColorPaletteCustom9, ColorPaletteCustom10
                        FROM ColorLibraryPending WHERE ID = @BookOrder
                  END
			
			--** Comment#01
			EXEC spx_ColorLibraryLogic_INSERT @ColorPaletteID, @ColorFolderID

      END
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06738', GetDate())
GO
