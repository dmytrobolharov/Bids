IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialSeasonYear_Multiple_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_MaterialSeasonYear_Multiple_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_MaterialSeasonYear_Multiple_INSERT](
	@MaterialID UNIQUEIDENTIFIER,
	@TransactionID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200), 
	@CDate DATETIME 
)
AS

DECLARE
	@ROWID INT,
	@TOTAL INT,
	@ROWID2 INT,
	@TOTAL2 INT,
	@SeasonYearID UNIQUEIDENTIFIER, 
	@MaterialSeasonYearID UNIQUEIDENTIFIER,
	@PreviousSeasonYearID UNIQUEIDENTIFIER,
	@Sort INT,
	@TradepartnerVendorID UNIQUEIDENTIFIER, 
	@TradePartnerID UNIQUEIDENTIFIER,
	@PrevMaterialTradePartner UNIQUEIDENTIFIER

CREATE TABLE #sy(
	ROWID INT IDENTITY(1,1),
	SeasonYearID UNIQUEIDENTIFIER
)

INSERT INTO #sy	(SeasonYearID )
SELECT  SeasonYearID FROM pMaterialSeasonYearTemp WITH(NOLOCK)
WHERE TeamID = @TeamID AND TransactionID = @TransactionID 


CREATE TABLE #tp(
	ROWID INT IDENTITY(1,1),
	TradepartnerVendorID UNIQUEIDENTIFIER,
	TradePartnerID UNIQUEIDENTIFIER
)

INSERT INTO  #tp ( TradepartnerVendorID, TradePartnerID )
SELECT DISTINCT TradepartnerVendorID, TradePartnerID
FROM dbo.pMaterialTradePartner
WHERE MaterialId = @MaterialID


SET @ROWID = 1 
SELECT @TOTAL = COUNT(*) FROM #sy 
SELECT @TOTAL2= COUNT(*)  FROM #tp


WHILE @ROWID <= @TOTAL
BEGIN 
	SELECT @SeasonYearID = SeasonYearID FROM #sy  WHERE ROWID = @ROWID

	IF NOT EXISTS( SELECT * FROM dbo.pMaterialSeasonYear WHERE SeasonYearID = @SeasonYearID  AND MaterialID = @MaterialID )
	BEGIN
		SET @MaterialSeasonYearID = NEWID() 
		INSERT INTO  pMaterialSeasonYear ( MaterialSeasonYearID , SeasonYearID, MaterialID, CUser, CDate )
		VALUES(@MaterialSeasonYearID, @SeasonYearID, @MaterialID, @CUser, @CDate)

		EXECUTE dbo.spx_MaterialSeasonYear_Logic_INSERT
			@MaterialSeasonYearID = @MaterialSeasonYearID,
			@CUser = @CUser, 
			@CDate = @CDate
	END 



	SET @ROWID2 = 1 
	WHILE @ROWID2 <= @TOTAL2 
	BEGIN
		
		SELECT @TradepartnerVendorID = TradepartnerVendorID, @TradePartnerID = @TradePartnerID
		FROM #tp WHERE ROWID = @ROWID2
		
		SET @PrevMaterialTradePartner =  NULL
	
		SELECT @PrevMaterialTradePartner = MaterialTradePartnerId
		FROM dbo.pMaterialTradePartner WHERE MaterialId = @MaterialID
		AND TradepartnerVendorId = @TradepartnerVendorID
		AND SeasonYearID <> @SeasonYearID 
		
		IF @PrevMaterialTradePartner IS NOT NULL 
		BEGIN
		
			
			IF NOT EXISTS ( SELECT * FROM dbo.pMaterialTradePartner WHERE MaterialId = @MaterialID 
				AND TradepartnerVendorId = @TradePartnerVendorID AND SeasonYearID = @SeasonYearID  )
			BEGIN

				INSERT INTO  pMaterialTradePartner (
					MaterialTradePartnerId,MaterialId, TradepartnerId, TradepartnerVendorId,SeasonYearID,  
					CDate, CUser, MDate, MUser,
					MaterialTradePartnerCustom1, MaterialTradePartnerCustom2, MaterialTradePartnerCustom3, MaterialTradePartnerCustom4,MaterialTradePartnerCustom5, 
					MaterialTradePartnerCustom6, MaterialTradePartnerCustom7, MaterialTradePartnerCustom8, MaterialTradePartnerCustom9, MaterialTradePartnerCustom10, 
					MaterialTradePartnerCustom11, MaterialTradePartnerCustom12, MaterialTradePartnerCustom13, MaterialTradePartnerCustom14,MaterialTradePartnerCustom15, 
					MaterialTradePartnerCustom16, MaterialTradePartnerCustom17, MaterialTradePartnerCustom18, MaterialTradePartnerCustom19, MaterialTradePartnerCustom20, 
					MaterialTradePartnerCustom21, MaterialTradePartnerCustom22, MaterialTradePartnerCustom23, MaterialTradePartnerCustom24, MaterialTradePartnerCustom25)
				SELECT 
					NEWID() AS MaterialTradePartnerId, @MaterialId, @TradepartnerId, @TradepartnerVendorId,@SeasonYearID,  
					@CDate, @CUser, @CDate, @CUser,
					MaterialTradePartnerCustom1, MaterialTradePartnerCustom2, MaterialTradePartnerCustom3, MaterialTradePartnerCustom4,MaterialTradePartnerCustom5, 
					MaterialTradePartnerCustom6, MaterialTradePartnerCustom7, MaterialTradePartnerCustom8, MaterialTradePartnerCustom9, MaterialTradePartnerCustom10, 
					MaterialTradePartnerCustom11, MaterialTradePartnerCustom12, MaterialTradePartnerCustom13, MaterialTradePartnerCustom14,MaterialTradePartnerCustom15, 
					MaterialTradePartnerCustom16, MaterialTradePartnerCustom17, MaterialTradePartnerCustom18, MaterialTradePartnerCustom19, MaterialTradePartnerCustom20, 
					MaterialTradePartnerCustom21, MaterialTradePartnerCustom22, MaterialTradePartnerCustom23, MaterialTradePartnerCustom24, MaterialTradePartnerCustom25
				FROM dbo.pMaterialTradePartner 
				WHERE MaterialTradePartnerId = @PrevMaterialTradePartner
				
			END 
		END 
	
		SET @ROWID2 = @ROWID2 + 1 
	END 
	
	
	
	
	SET @ROWID = @ROWID + 1 
	
END 

DROP TABLE #sy
DROP TABLE #tp

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01026', GetDate())
GO







