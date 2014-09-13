IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialColor_FromPending_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialColor_FromPending_INSERT]
GO


CREATE PROCEDURE  [dbo].[spx_MaterialColor_FromPending_INSERT] (
@ColorPaletteID UNIQUEIDENTIFIER,
@MaterialID UNIQUEIDENTIFIER,
@SeasonYearID UNIQUEIDENTIFIER,
@CUser NVARCHAR(200) ,
@CDate DATETIME
)
AS 

DECLARE @MaterialColorID UNIQUEIDENTIFIER 
DECLARE @ColorCode NVARCHAR(200)
DECLARE @ColorName NVARCHAR(200)

SELECT  @ColorCode = ColorCode, @ColorName = ColorName FROM pColorPalette WHERE ColorPaletteID = @ColorPaletteID 

SELECT TOP 1 @MaterialColorID = MaterialColorID  
FROM pMaterialColor	a 
INNER JOIN pColorPalette b ON a.ColorPaletteID =  b.ColorPaletteID 
WHERE a.MaterialID = @MaterialID
AND b.ColorCode = @ColorCode 


IF @MaterialColorID IS NULL 
BEGIN 
	SET @MaterialColorID =  NEWID() 

	INSERT INTO pMaterialColor ( MaterialColorID , MaterialID,  ColorFolderID , ColorPaletteID ,ColorCode, ColorName, ColorSource, Hex, R, G, B, C, M,Y,K, H, S, L ,LAB_L, LAB_A, LAB_B, CDate , CUser, MDate, MUser, MaterialColorVersion, ColorVersion )  
	SELECT  @MaterialColorID , @MaterialID , ColorFolderID , ColorPaletteID, ColorCode, ColorName, ColorSource, Hex, R, G, B, C, M, Y, K, H, S, L ,LAB_L, LAB_A, LAB_B, @CDate, @CUser, @CDate, @CUser, 1,  0 
	FROM pColorPalette
	WHERE ColorPaletteID = @ColorPaletteID
END 

-- Materialcolor / SeasonYear
IF @SeasonYearID IS NOT NULL 
BEGIN
	IF ( SELECT COUNT (*)  FROM pMaterialColorSeasonYear WHERE MaterialColorID = @MaterialColorID AND SeasonYearID  = @SeasonYearID ) = 0
	BEGIN
		INSERT INTO pMaterialColorSeasonYear (MaterialColorSeasonYearID , MaterialColorID , MaterialID , SeasonYearID , MaterialSeason, MaterialYear, CUser, CDate, MUser, MDate ) 
		SELECT NEWID() , @MaterialColorID,  @MaterialID, @SeasonYearID , Season, Year, @CUser, @CDate, @CUser, @CDate
		FROM pSeasonYear WHERE SeasonYearID = @SeasonYearID

		EXEC spx_MaterialColorSeasonYear_Logic_INSERT 
		@SeasonYearID = @SeasonYearID,
		@MaterialColorID = @MaterialColorID,
		@MaterialID = @MaterialID,
		@CUser = @CUser ,
		@CDate = @CDate 		

	END 
END 

DELETE FROM pMaterialColorPending  WHERE ColorPaletteID = @ColorPaletteID AND MaterialID = @MaterialID AND CUser = @CUser 




GO