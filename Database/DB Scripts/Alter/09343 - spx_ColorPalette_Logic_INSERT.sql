IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorPalette_Logic_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorPalette_Logic_INSERT]
GO

CREATE PROCEDURE  [dbo].[spx_ColorPalette_Logic_INSERT](
@ColorPaletteID UNIQUEIDENTIFIER, 
@CUser NVARCHAR(200), 
@CDate DATETIME 
)
AS

DECLARE @CorpColor INT 
DECLARE @ColorLibraryTypeID UNIQUEIDENTIFIER
DECLARE @ColorType NVARCHAR(200)

SELECT @CorpColor = c.CorpColor, @ColorLibraryTypeID = c.ColorLibraryTypeID
FROM pColorPalette a 
INNER JOIN pColorFolder b ON a.ColorFolderID = b.ColorFolderID 
INNER JOIN pColorType c ON b.ColorTypeID = c.ColorTypeID 
WHERE ColorPaletteID = @ColorPaletteID


SELECT * FROM ColorLibrary

--IF ( SELECT a.ColorFolderID FROM pColorPalette a WHERE ColorPaletteID = @ColorPaletteID ) = '00000000-0000-0000-0000-000000000001' 
IF @CorpColor = 1  AND @ColorLibraryTypeID IS NOT NULL 
BEGIN
 
	SELECT @ColorType = ColorType FROM ColorType WHERE ColorLibraryTypeID =  @ColorLibraryTypeID 

	IF ( SELECT COUNT(*) FROM ColorLibrary WHERE PantoneType = @ColorType AND  ColorPaletteID = @ColorPaletteID ) = 0
	BEGIN 		
		INSERT INTO ColorLibrary ( PantoneType, PantoneNumber, PantoneName, R, G, B, 
		H, S , L, LAB_L, LAB_B, LAB_A , Hex, Active, CUser, CDate, MUser, MDate, ColorPaletteID , ColorSource, ColorLibraryTypeID, ImageID, ImageVersion  )
		SELECT @ColorType, ColorCode, Colorname, R, G, B,  
		H, S, L, LAB_L, LAB_B, LAB_A, RIGHT(HEX ,6), 1, @CUser, @CDate, @CUser, @CDate, @ColorPaletteID, ColorSource, @ColorLibraryTypeID as ColorLibraryTypeID, ImageID, ImageVersion
		FROM pColorPalette 
		WHERE ColorPaletteID  = @ColorPaletteID

	END 
	ELSE
	BEGIN

		DECLARE @PantoneType NVARCHAR(50)
		DECLARE @PantoneNumber NVARCHAR(50)
		DECLARE @PantoneName NVARCHAR(50)
		DECLARE @R INT
		DECLARE @G INT 
		DECLARE @B INT
		DECLARE @H INT
		DECLARE @S INT
		DECLARE @L INT 
		DECLARE @LAB_L NVARCHAR(10)
		DECLARE @LAB_B NVARCHAR(10)
		DECLARE @LAB_A NVARCHAR(10)
		DECLARE @Hex NVARCHAR(50)
		DECLARE @ColorSource NVARCHAR(50)


		SELECT @PantoneType = @ColorType, @PantoneNumber = ColorCode, 
		@PantoneName = Colorname, @R = R, @G = G, @B = B,  
		@H = H, @S = S, @L = L, @LAB_L = LAB_L, @LAB_A = LAB_A, @LAB_B = LAB_B, 
		@Hex = RIGHT(HEX ,6), @ColorSource = ColorSource
		FROM pColorPalette 
		WHERE ColorPaletteID  = @ColorPaletteID


		UPDATE ColorLibrary 
		SET PantoneNumber = @PantoneNumber, PantoneName = @PantoneName, R = @R, G = @G, B = @B,  
		H = @H, S = @S, L = @L, 
		LAB_L = @LAB_L, LAB_A = @LAB_A, LAB_B = @LAB_B, 
		Hex = RIGHT(@HEX ,6), ColorSource = @ColorSource
		WHERE PantoneType = @ColorType
		AND ColorPaletteID = @ColorPaletteID

	END

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09343', GetDate())
GO
