--WI # 21576 : Color Folder - Create New Unique ID for pColorPalette

IF OBJECT_ID ( 'spx_ColorLibraryLogic_INSERT', 'P' ) IS NOT NULL 
    DROP PROCEDURE spx_ColorLibraryLogic_INSERT;
GO

CREATE PROCEDURE [dbo].[spx_ColorLibraryLogic_INSERT]  
( 
	@ColorPaletteID uniqueidentifier, 
	@ColorFolderID uniqueidentifier
) 
AS
BEGIN

	/*For Color Library add new Palette to ColorLibrary table*/
	IF @ColorFolderID = '00000000-0000-0000-0000-000000000001'
	BEGIN
		DECLARE @ColorLibraryID uniqueidentifier
		SELECT @ColorLibraryID = ColorLibraryID FROM pColorPalette WHERE ColorPaletteID = @ColorPaletteID
		
		-- For newly created color chips
		IF @ColorLibraryID IS NULL
		BEGIN
			SET @ColorLibraryID = NEWID()
		
			INSERT INTO ColorLibrary (
				ColorLibraryID, PantoneType, PantoneNumber, PantoneName, R, G, B, H, S, L, LAB_L, LAB_A, LAB_B, Hex, Active, CUser, CDate, MUser, MDate, ColorPaletteID, ColorSource, ColorLibraryTypeID
			)
			SELECT @ColorLibraryID, 'Color Library', ColorCode, ColorName, R, G, B, H, S, L, LAB_L, LAB_A, LAB_B, Hex, Active, CUser, CDate, MUser, MDate, ColorPaletteID, ColorSource, ColorFolderID FROM pColorPalette
				WHERE ColorPaletteID = @ColorPaletteID
			
			UPDATE pColorPalette SET ColorLibraryID = @ColorLibraryID WHERE ColorPaletteID = @ColorPaletteID
		END
		
	END
	
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06736', GetDate())
GO
