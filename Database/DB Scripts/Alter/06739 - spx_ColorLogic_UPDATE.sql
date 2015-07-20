--WI # 21576 : Color Folder - Create New Unique ID for pColorPalette

IF OBJECT_ID(N'spx_ColorLogic_UPDATE', N'P') IS NOT NULL
DROP PROCEDURE [dbo].[spx_ColorLogic_UPDATE]
GO

/************************************************************************************************
* Name  : spx_ColorLogic_UPDATE
* Description :	
*
*           
* Change History:                  
* 
* Comment#		Date				Author						Comment
* #01			12/09/2013			Constantine Volkov			Color Folder - Create New Unique ID for pColorPalette
*************************************************************************************************/

CREATE PROCEDURE [dbo].[spx_ColorLogic_UPDATE](
@ColorPaletteID UNIQUEIDENTIFIER ,
@MUser NVARCHAR (200),
@MDate DATETIME 
)
AS 

DECLARE @ColorCode NVARCHAR (200) 
DECLARE @ColorName NVARCHAR (200) 
DECLARE @Sort NVARCHAR(10) 
DECLARE @ColorFolderID UNIQUEIDENTIFIER
DECLARE @R int, @G int, @B int
DECLARE @ColorPaletteCustom1 nvarchar(50),
@ColorPaletteCustom2 nvarchar(50),
@ColorPaletteCustom3 nvarchar(50),
@ColorPaletteCustom4 nvarchar(50),
@ColorPaletteCustom5 nvarchar(50),
@ColorPaletteCustom6 nvarchar(50),
@ColorPaletteCustom7 nvarchar(50),
@ColorPaletteCustom8 nvarchar(50),
@ColorPaletteCustom9 nvarchar(50),
@ColorPaletteCustom10 nvarchar(50),
@ColorLibraryID UNIQUEIDENTIFIER,
@ColorImage int,
@ColorNotes nvarchar(max),
@ColorSource NVARCHAR(150)

--	July 17, 2012 - Added by Valentino Strappato
Declare @cColorType	nvarchar(50)	--	ColorType from ColorType SQL table. NOTE: this works if there is only 1 Corporate Color palette
Select top 1 @cColorType=ColorType from ColorType where CorpColor=1
--Select @cColorType

SELECT 	@ColorCode = ColorCode, @ColorName = ColorName , @Sort = Sort,
	@ColorFolderID = ColorFolderID, @R = R, @G = G, @B = B, @ColorLibraryID = ColorLibraryID, @ColorSource = ColorSource,
	--** Comment#01
	@ColorPaletteCustom1=ColorPaletteCustom1, @ColorPaletteCustom2=ColorPaletteCustom2,
	@ColorPaletteCustom3=ColorPaletteCustom3, @ColorPaletteCustom4=ColorPaletteCustom4, @ColorPaletteCustom5=ColorPaletteCustom5,
	@ColorPaletteCustom6=ColorPaletteCustom6, @ColorPaletteCustom7=ColorPaletteCustom7, @ColorPaletteCustom8=ColorPaletteCustom8,
	@ColorPaletteCustom9=ColorPaletteCustom9, @ColorPaletteCustom10=ColorPaletteCustom10, @ColorImage = ColorImage, @ColorNotes = ColorNotes
FROM pColorPalette 
WHERE ColorPaletteID = @ColorPaletteID

--** Comment#01 - Begin
--** For Color Library update all ColorPalettes copied from current ColorPalette
IF @ColorFolderID = '00000000-0000-0000-0000-000000000001'
BEGIN
	IF @ColorImage = 1 AND @R IS NULL AND @G IS NULL AND @B IS NULL
	BEGIN
		UPDATE pColorPalette SET ColorName = @ColorName, ColorPaletteCustom1=@ColorPaletteCustom1, ColorPaletteCustom2=@ColorPaletteCustom2,
		ColorPaletteCustom3=@ColorPaletteCustom3, ColorPaletteCustom4=@ColorPaletteCustom4, ColorPaletteCustom5=@ColorPaletteCustom5,
		ColorPaletteCustom6=@ColorPaletteCustom6, ColorPaletteCustom7=@ColorPaletteCustom7, ColorPaletteCustom8=@ColorPaletteCustom8,
		ColorPaletteCustom9=@ColorPaletteCustom9, ColorPaletteCustom10=@ColorPaletteCustom10, ColorNotes = @ColorNotes, ColorCode = @ColorCode,
		ColorSource = @ColorSource

			WHERE ColorPaletteID IN (
				SELECT ColorPaletteID FROM pColorPalette WHERE ColorLibraryID = @ColorLibraryID AND R IS NULL AND G IS NULL AND B IS NULL
			) AND ColorFolderID <> '00000000-0000-0000-0000-000000000001'
	END
	ELSE
	BEGIN
		UPDATE pColorPalette SET ColorName = @ColorName, ColorPaletteCustom1=@ColorPaletteCustom1, ColorPaletteCustom2=@ColorPaletteCustom2,
		ColorPaletteCustom3=@ColorPaletteCustom3, ColorPaletteCustom4=@ColorPaletteCustom4, ColorPaletteCustom5=@ColorPaletteCustom5,
		ColorPaletteCustom6=@ColorPaletteCustom6, ColorPaletteCustom7=@ColorPaletteCustom7, ColorPaletteCustom8=@ColorPaletteCustom8,
		ColorPaletteCustom9=@ColorPaletteCustom9, ColorPaletteCustom10=@ColorPaletteCustom10, ColorNotes = @ColorNotes, ColorCode = @ColorCode,
		ColorSource = @ColorSource

			WHERE ColorPaletteID IN (
				SELECT ColorPaletteID FROM pColorPalette WHERE ColorLibraryID = @ColorLibraryID AND R = @R AND G = @G AND B = @B
			) AND ColorFolderID <> '00000000-0000-0000-0000-000000000001'	
	END
END

--** Update ColorLibrary record
UPDATE ColorLibrary SET PantoneNumber = @ColorCode, PantoneName = @ColorName WHERE ColorLibraryID = @ColorLibraryID
	AND ColorLibraryTypeID = '00000000-0000-0000-0000-000000000001'

--** Comment#01 - End

DECLARE @nSort INT 


BEGIN TRY
	SET @nSort  =  CAST ( @Sort AS INT ) 
END TRY
BEGIN CATCH
	SET @nSort = 0 
END CATCH 

DECLARE @SortTmp NVARCHAR(15) 

SET @SortTmp = '0000' + CAST(@nSort as NVARCHAR(10))
SET @SortTmp = RIGHT( @SortTmp , 4) 


UPDATE pColorPalette SET Sort = @SortTmp WHERE ColorPaletteID = @ColorPaletteID

UPDATE pMaterialColor SET   ColorCode  = @ColorCode, 
ColorName = @ColorName, 	MUser = @MUser, MDate = @MDate 
WHERE ColorPaletteID = @ColorPaletteID 

-- UPDATE Style Colorway -- #01

UPDATE pStyleColorway Set StyleColorNo = @ColorCode,
StyleColorName = @ColorName, MainColor = @ColorName, MUser = @MUser, MDate = @MDate 
WHERE ColorPaletteID = @ColorPaletteID 

-- UPDATE COLOR LIBRARY

IF (SELECT COUNT(*) FROM ColorLibrary WHERE ColorPaletteID = @ColorPaletteID) = 0
BEGIN

		--	July 17, 2012 - INSERT modified by Valentino Strappato
		--	Use @cColorType instead of "Burberry Default"
		INSERT INTO ColorLibrary(PantoneType, PantoneNumber, PantoneName, Hex, R, G, B, C, M, Y, K, H, S, L, 
			LAB_L, LAB_A, LAB_B, CUser, CDate, MUser, MDate, ColorPaletteID, ColorSource)
		SELECT @cColorType AS ColorType, ColorCode, ColorName, Hex, R, G, B, C, M, Y, K, H, S, L, 
			LAB_L, LAB_A, LAB_B, CUser, CDate, MUser, MDate, ColorPaletteId, ColorSource 
		FROM pColorPalette WHERE ColorPaletteID = @ColorPaletteId

END
ELSE
BEGIN

		--	July 17, 2012 - Update modified by Valentino Strappato
		UPDATE ColorLibrary SET 
			PantoneNumber = b.ColorCode, PantoneName = b.ColorName, ColorSource = b.ColorSource, 
			Hex = RIGHT(b.Hex,6), 
			R = b.R, G = b.G, B = b.B, C = b.C, M = b.M, 
			Y = b.Y, K = b.K, H = b.H, S = b.S, L = b.L, 
			LAB_L = b.Lab_L, LAB_A = b.LAB_A, LAB_B = b.LAB_B, 
			MUser = b.MUser, MDate = b.MDate 
		FROM ColorLibrary a
			INNER JOIN pColorPalette b ON b.ColorPaletteID = a.ColorPaletteID
		WHERE b.ColorPaletteID = @ColorPaletteId 
		--	July 17, 2012 - Not only for Burberry Default
		--AND  a.PantoneType = 'Burberry Default'

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06739', GetDate())
GO
