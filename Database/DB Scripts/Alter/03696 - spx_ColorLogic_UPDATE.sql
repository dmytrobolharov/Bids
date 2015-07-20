
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorLogic_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_ColorLogic_UPDATE](
@ColorPaletteID UNIQUEIDENTIFIER ,
@MUser NVARCHAR (200),
@MDate DATETIME 
)
AS 

DECLARE @ColorCode NVARCHAR (200) 
DECLARE @ColorName NVARCHAR (200) 
DECLARE @Sort NVARCHAR(10) 

--	July 17, 2012 - Added by Valentino Strappato
Declare @cColorType	nvarchar(50)	--	ColorType from ColorType SQL table. NOTE: this works if there is only 1 Corporate Color palette
Select top 1 @cColorType=ColorType from ColorType where CorpColor=1
--Select @cColorType

SELECT 	@ColorCode = ColorCode, @ColorName = ColorName , @Sort = Sort
FROM pColorPalette 
WHERE ColorPaletteID = @ColorPaletteID

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
VALUES     ('DB_Version', '5.0.0000', '03696', GetDate())
GO