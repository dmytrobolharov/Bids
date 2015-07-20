IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Material_Color_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_Material_Color_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_Material_Color_INSERT]  (
@MaterialColorID UNIQUEIDENTIFIER,
@MaterialID UNIQUEIDENTIFIER,
@ColorPaletteID UNIQUEIDENTIFIER,
@CUser VARCHAR(200),
@CDate DATETIME 
)
AS
BEGIN 

	DECLARE @ColorCode NVARCHAR(200)
	DECLARE @ColorName NVARCHAR(200)
	SELECT @ColorCode = ColorCode,  @ColorName = ColorName FROM pColorPalette WITH (NOLOCK) WHERE ColorPaletteID = @ColorPaletteID

	IF NOT EXISTS (SELECT * FROM pMaterialColor WITH (NOLOCK) WHERE ColorCode = @ColorCode)
	BEGIN
		 INSERT INTO dbo.pMaterialColor 
			 (MaterialColorID, MaterialID, ColorFolderID, ColorPaletteID, ColorCode, ColorName, ColorSource, 
			 Hex, R, G, B, C, M, Y, K, H, S, L, LAB_L, LAB_A, LAB_B, MaterialColorVersion, 
		 CDate, CUser , MDate, MUser, Sort, VendorColorCode, VendorColorName) 
		 SELECT @MaterialColorID  AS  MaterialColorID ,  @MaterialID  as MaterialID  , ColorFolderID, ColorPaletteID, ColorCode, ColorName, ColorSource,  
			 Hex, R, G, B, C, M, Y, K, H, S, L, LAB_L, LAB_A, LAB_B, Change,  
			 @CDate as CDate,  @CUser as CUSer, @CDate as MDate,  @CUser as MUSer,  Sort, ColorCode, ColorName 
		 FROM  dbo.pColorPalette  WITH (NOLOCK) WHERE ColorPaletteID = @ColorPaletteID  
	END 

END 


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '726', GetDate())
GO
