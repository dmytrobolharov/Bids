/****** Object:  StoredProcedure [dbo].[spx_MaterialNewTradePartnerColorSeasonYearLogic_INSERT]    Script Date: 01/09/2013 17:17:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialNewTradePartnerColorSeasonYearLogic_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialNewTradePartnerColorSeasonYearLogic_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialNewTradePartnerColorSeasonYearLogic_INSERT]    Script Date: 01/09/2013 17:17:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_MaterialNewTradePartnerColorSeasonYearLogic_INSERT] (
@MaterialColorSeasonYearID UNIQUEIDENTIFIER,
@MaterialTradePartnerID UNIQUEIDENTIFIER,
@MaterialSizeID UNIQUEIDENTIFIER,
@CUser NVARCHAR(200),
@CDate DATETIME 
)
AS


IF @MaterialSizeID IS NULL 
	SET @MaterialSizeID  = '00000000-0000-0000-0000-000000000000'


DECLARE @SeasonYearID UNIQUEIDENTIFIER 
DECLARE @ColorSeasonYearID UNIQUEIDENTIFIER 
DECLARE @TradePartnerID UNIQUEIDENTIFIER
DECLARE @MaterialID UNIQUEIDENTIFIER 
DECLARE @MaterialColorID  UNIQUEIDENTIFIER 
DECLARE @MaterialTradePartnerIDNew UNIQUEIDENTIFIER
DECLARE @MaterialTradePartnerColorIDNew UNIQUEIDENTIFIER 
DECLARE @ColorPaletteID UNIQUEIDENTIFIER 
DECLARE @ColorName NVARCHAR(200)
DECLARE @ColorCode NVARCHAR(200)


SELECT @ColorSeasonYearID = a.SeasonYearID, @MaterialColorID = a.MaterialColorID,
@ColorPaletteID = b.ColorPaletteID, @ColorName = ColorName, @ColorCode = ColorCode
FROM pMaterialColorSeasonYear a
INNER JOIN pMaterialColor b On a.MaterialColorID = b.MaterialColorID
WHERE a.MaterialColorSeasonYearID = @MaterialColorSeasonYearID

SELECT @TradePartnerID = TradePartnerID,
@MaterialID = MaterialID
FROM pMaterialTradePartner WHERE MaterialTradePartnerID = @MaterialTradePartnerID


/***
** Check if the relation material / tradepartner / seasonyear  Exists
**/
SELECT @MaterialTradePartnerIDNew = MaterialTradePartnerID  FROM pMaterialTradePartner  
WHERE MaterialID = @MaterialID 
AND TradePartnerID = @TradePartnerID  
AND SeasonYearID = @ColorSeasonYearID 

IF @MaterialTradePartnerIDNew IS NULL 
BEGIN 
	SET @MaterialTradePartnerIDNew =  NEWID()

	INSERT INTO  pMaterialTradePartner (MaterialTradepartnerID , MaterialID , TradePartnerID , 
	CUser, CDate, MUser, MDate, SeasonYearID ) 
	VALUES ( @MaterialTradePartnerIDNew , @MaterialID , @TradePartnerID , 
	@CUser, @CDate, @CUser, @CDate, @ColorSeasonYearID) 

END 



IF @MaterialSizeID  = '00000000-0000-0000-0000-000000000000'
	SELECT @MaterialTradePartnerColorIDNew = MaterialTradePartnerColorID FROM pMaterialTradePartnerColor
	WHERE MaterialColorID = @MaterialColorID 
	AND MaterialTradepartnerID = @MaterialTradePartnerIDNew
	AND ( MaterialSizeID =  @MaterialSizeID OR MaterialSizeID  IS NULL ) 
ELSE 
	SELECT @MaterialTradePartnerColorIDNew = MaterialTradePartnerColorID  FROM pMaterialTradePartnerColor
	WHERE MaterialColorID = @MaterialColorID 
	AND MaterialTradepartnerID = @MaterialTradePartnerIDNew
	AND MaterialSizeID = @MaterialSizeID 



IF @MaterialTradePartnerColorIDNew IS NULL 
BEGIN

	SET @MaterialTradePartnerColorIDNew = NEWID() 

	INSERT INTO  pMaterialTradePartnerColor ( MaterialTradePartnerColorID, MaterialTradePartnerID , MaterialColorID, MaterialID, 
	ColorFolderID , ColorPaletteID, ColorCode, ColorName, ColorSource, Hex, R, G, B, C, M , Y, K , H, S, L, LAB_L, LAB_A, LAB_B, 
	CDate, CUser, MDate, MUser, MaterialColorVersion, ColorVersion, MaterialSizeID )
	SELECT @MaterialTradePartnerColorIDNew, @MaterialTradePartnerIDNew, @MaterialColorID, @MaterialID, 
	ColorFolderID, ColorPaletteID , ColorCode, ColorName, ColorSource, Hex, R, G, B, C, M , Y, K, H, S, L, LAB_L, LAB_A, LAB_B,
	@CDate, @CUser, @CDate, @CUser, 1, 1, @MaterialSizeID
	FROM pColorPalette
	WHERE ColorPaletteID  = @ColorPaletteID 

END 


DECLARE @MaterialTradePartnerColorID UNIQUEIDENTIFIER 
DECLARE @LastSeasonMaterialtradePartnerID UNIQUEIDENTIFIER 

SELECT TOP 1 @MaterialTradePartnerColorID = MaterialTradePartnerColorID,
@LastSeasonMaterialtradePartnerID = MaterialtradePartnerID
FROM pMaterialTradePartnerColor a
INNER JOIN pColorPalette b ON a.ColorPaletteID =  b.ColorPaletteID 
WHERE MaterialTradepartnerID = @MaterialTradepartnerID
AND b.ColorCode = @ColorCode AND b.ColorName = @ColorName and a.MaterialSizeID = @MaterialSizeID  --Comment #01

IF @MaterialTradePartnerColorID  IS NOT NULL AND @LastSeasonMaterialtradePartnerID IS NOT NULL
BEGIN 

	DECLARE @MaterialTradePartnerCustom1 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom2 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom3 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom4 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom5 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom6 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom7 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom8 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom9 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom10 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom11 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom12 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom13 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom14 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom15 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom16 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom17 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom18 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom19 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom20 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom21 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom22 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom23 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom24 NVARCHAR(50)
	DECLARE @MaterialTradePartnerCustom25 NVARCHAR(50)

	SELECT 	@MaterialTradePartnerCustom1 = MaterialTradePartnerCustom1, @MaterialTradePartnerCustom2 = MaterialTradePartnerCustom2, 
	@MaterialTradePartnerCustom3 = MaterialTradePartnerCustom3, @MaterialTradePartnerCustom4 = MaterialTradePartnerCustom4, 
	@MaterialTradePartnerCustom5 = MaterialTradePartnerCustom5, @MaterialTradePartnerCustom6 = MaterialTradePartnerCustom6, 
	@MaterialTradePartnerCustom7 = MaterialTradePartnerCustom7, @MaterialTradePartnerCustom8 = MaterialTradePartnerCustom8, 
	@MaterialTradePartnerCustom9 = MaterialTradePartnerCustom9, @MaterialTradePartnerCustom10 = MaterialTradePartnerCustom10, 
	@MaterialTradePartnerCustom11 = MaterialTradePartnerCustom11, @MaterialTradePartnerCustom12 = MaterialTradePartnerCustom12, 
	@MaterialTradePartnerCustom13 = MaterialTradePartnerCustom13, @MaterialTradePartnerCustom14 = MaterialTradePartnerCustom14, 
	@MaterialTradePartnerCustom15 = MaterialTradePartnerCustom15, @MaterialTradePartnerCustom16 = MaterialTradePartnerCustom16, 
	@MaterialTradePartnerCustom17 = MaterialTradePartnerCustom17, @MaterialTradePartnerCustom18 = MaterialTradePartnerCustom18, 
	@MaterialTradePartnerCustom19 = MaterialTradePartnerCustom19, @MaterialTradePartnerCustom20 = MaterialTradePartnerCustom20, 	
	@MaterialTradePartnerCustom21 = MaterialTradePartnerCustom21, @MaterialTradePartnerCustom22 = MaterialTradePartnerCustom22, 
	@MaterialTradePartnerCustom23 = MaterialTradePartnerCustom23, @MaterialTradePartnerCustom24 = MaterialTradePartnerCustom24, 
	@MaterialTradePartnerCustom25 = MaterialTradePartnerCustom25	
	FROM pMaterialtradePartner WHERE MaterialtradePartnerID = @LastSeasonMaterialtradePartnerID

	DECLARE @MaterialPrice MONEY
	DECLARE @MaterialTradeColor1 NVARCHAR(200)
	DECLARE @MaterialTradeColor2 NVARCHAR(200)
	DECLARE @MaterialTradeColor3 NVARCHAR(200)
	DECLARE @MaterialTradeColor4 NVARCHAR(200)
	DECLARE @MaterialTradeColor5 NVARCHAR(200)
	DECLARE @MaterialTradeColor6 NVARCHAR(200)
	DECLARE @MaterialTradeColor7 NVARCHAR(200)
	DECLARE @MaterialTradeColor8 NVARCHAR(200)
	DECLARE @MaterialTradeColor9 DECIMAL(18,2)
	DECLARE @MaterialTradeColor10 DECIMAL(18,2)
	DECLARE @MaterialTradeColor11 DECIMAL(18,2)
	DECLARE @MaterialTradeColor12 DECIMAL(18,2)
	DECLARE @MaterialTradeColor13 DECIMAL(18,2)
	DECLARE @MaterialTradeColor14 NVARCHAR(200)
	DECLARE @MaterialTradeColor15 NVARCHAR(200)
	DECLARE @MaterialTradeColor16 NVARCHAR(200)
	DECLARE @MaterialTradeColor17 NVARCHAR(200)
	DECLARE @MaterialTradeColor18 NVARCHAR(200)
	DECLARE @MaterialTradeColor19 NVARCHAR(200)
	DECLARE @MaterialTradeColor20 NVARCHAR(200)
	DECLARE @MaterialTradeColor21 NVARCHAR(200)
	DECLARE @MaterialTradeColor22 NVARCHAR(200)
	DECLARE @MaterialTradeColor23 NVARCHAR(200)
	DECLARE @MaterialTradeColor24 NVARCHAR(200)
	DECLARE @MaterialTradeColor25 NVARCHAR(200)

	SELECT @MaterialPrice = MaterialPrice, 
	@MaterialTradeColor1 = MaterialTradeColor1, @MaterialTradeColor2 = MaterialTradeColor2,
	@MaterialTradeColor3 = MaterialTradeColor3, @MaterialTradeColor4 = MaterialTradeColor4,
	@MaterialTradeColor5 = MaterialTradeColor5, @MaterialTradeColor6 = MaterialTradeColor6,
	@MaterialTradeColor7 = MaterialTradeColor7, @MaterialTradeColor8 = MaterialTradeColor8,
	@MaterialTradeColor9 = MaterialTradeColor9, @MaterialTradeColor10 = MaterialTradeColor10,
	@MaterialTradeColor11 = MaterialTradeColor11, @MaterialTradeColor12 = MaterialTradeColor12,
	@MaterialTradeColor13 = MaterialTradeColor13, @MaterialTradeColor14 = MaterialTradeColor14,
	@MaterialTradeColor15 = MaterialTradeColor15, @MaterialTradeColor16 = MaterialTradeColor16,
	@MaterialTradeColor17 = MaterialTradeColor17, @MaterialTradeColor18 = MaterialTradeColor18,
	@MaterialTradeColor19 = MaterialTradeColor19, @MaterialTradeColor20 = MaterialTradeColor20,	
	@MaterialTradeColor21 = MaterialTradeColor21, @MaterialTradeColor22 = MaterialTradeColor22,
	@MaterialTradeColor23 = MaterialTradeColor23, @MaterialTradeColor24 = MaterialTradeColor24,
	@MaterialTradeColor25 = MaterialTradeColor25
	FROM pMaterialtradePartnerColor WHERE MaterialtradePartnerColorID = @MaterialTradePartnerColorID


	UPDATE pMaterialtradePartner SET 
	MaterialTradePartnerCustom1 = @MaterialTradePartnerCustom1, MaterialTradePartnerCustom2 = @MaterialTradePartnerCustom2, 
	MaterialTradePartnerCustom3 = @MaterialTradePartnerCustom3, MaterialTradePartnerCustom4 = @MaterialTradePartnerCustom4, 
	MaterialTradePartnerCustom5 = @MaterialTradePartnerCustom5, MaterialTradePartnerCustom6 = @MaterialTradePartnerCustom6, 
	MaterialTradePartnerCustom7 = @MaterialTradePartnerCustom7, MaterialTradePartnerCustom8 = @MaterialTradePartnerCustom8, 
	MaterialTradePartnerCustom9 = @MaterialTradePartnerCustom9, MaterialTradePartnerCustom10 = @MaterialTradePartnerCustom10, 
	MaterialTradePartnerCustom11 = @MaterialTradePartnerCustom11, MaterialTradePartnerCustom12 = @MaterialTradePartnerCustom12, 
	MaterialTradePartnerCustom13 = @MaterialTradePartnerCustom13, MaterialTradePartnerCustom14 = @MaterialTradePartnerCustom14, 
	MaterialTradePartnerCustom15 = @MaterialTradePartnerCustom15, MaterialTradePartnerCustom16 = @MaterialTradePartnerCustom16, 
	MaterialTradePartnerCustom17 = @MaterialTradePartnerCustom17, MaterialTradePartnerCustom18 = @MaterialTradePartnerCustom18, 
	MaterialTradePartnerCustom19 = @MaterialTradePartnerCustom19, MaterialTradePartnerCustom20 = @MaterialTradePartnerCustom20, 	
	MaterialTradePartnerCustom21 = @MaterialTradePartnerCustom21, MaterialTradePartnerCustom22 = @MaterialTradePartnerCustom22, 
	MaterialTradePartnerCustom23 = @MaterialTradePartnerCustom23, MaterialTradePartnerCustom24 = @MaterialTradePartnerCustom24, 
	MaterialTradePartnerCustom25 = @MaterialTradePartnerCustom25	
	WHERE MaterialtradePartnerID = @MaterialTradePartnerIDNew

	UPDATE pMaterialtradePartnerColor SET 
	MaterialPrice = @MaterialPrice,
	MaterialTradeColor1 = @MaterialTradeColor1, MaterialTradeColor2 = @MaterialTradeColor2,
	MaterialTradeColor3 = @MaterialTradeColor3, MaterialTradeColor4 = @MaterialTradeColor4,
	MaterialTradeColor5 = @MaterialTradeColor5, MaterialTradeColor6 = @MaterialTradeColor6,
	MaterialTradeColor7 = @MaterialTradeColor7, MaterialTradeColor8 = @MaterialTradeColor8,
	MaterialTradeColor9 = @MaterialTradeColor9, MaterialTradeColor10 = @MaterialTradeColor10,
	MaterialTradeColor11 = @MaterialTradeColor11, MaterialTradeColor12 = @MaterialTradeColor12,
	MaterialTradeColor13 = @MaterialTradeColor13, MaterialTradeColor14 = @MaterialTradeColor14,
	MaterialTradeColor15 = @MaterialTradeColor15, MaterialTradeColor16 = @MaterialTradeColor16,
	MaterialTradeColor17 = @MaterialTradeColor17, MaterialTradeColor18 = @MaterialTradeColor18,
	MaterialTradeColor19 = @MaterialTradeColor19, MaterialTradeColor20 = @MaterialTradeColor20,	
	MaterialTradeColor21 = @MaterialTradeColor21, MaterialTradeColor22 = @MaterialTradeColor22,
	MaterialTradeColor23 = @MaterialTradeColor23, MaterialTradeColor24 = @MaterialTradeColor24,
	MaterialTradeColor25 = @MaterialTradeColor25
	WHERE MaterialTradePartnerColorID = @MaterialTradePartnerColorIDNew


END 

SELECT @MaterialTradePartnerIDNew AS MaterialTradePartnerColorID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04728', GetDate())
GO
