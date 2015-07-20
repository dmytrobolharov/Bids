IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSourcingLogic_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSourcingLogic_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleSourcingLogic_INSERT]   (
@StyleSourcingID uniqueidentifier ,
@StyleColorID uniqueidentifier ,
@MDate datetime , 
@MUser nvarchar (200) 
)
AS 


DECLARE @StyleID uniqueidentifier 
DECLARE @StyleSet INT 
DECLARE @Cont INT 


DECLARE @TradePartnerVendorID UNIQUEIDENTIFIER
DECLARE @MaterialSizeID UNIQUEIDENTIFIER
DECLARE @MaterialColorID UNIQUEIDENTIFIER
DECLARE @StyleSourcingItemID UNIQUEIDENTIFIER
DECLARE @ROW_ID INT
DECLARE @TOTAL INT 

SELECT  @StyleID =  a.StyleID ,  @StyleSet = a.StyleSet 
FROM pStyleHeader  a,  pStyleSourcing  b 
WHERE  StyleSourcingID = @StyleSourcingID 
AND a.StyleID =  b.StyleID 


IF  @StyleID IS NOT NULL  
BEGIN 

	IF @StyleSet  IS NULL   
		SET  @StyleSet = 1 	

	SET  @Cont = 1 

	WHILE  @Cont <= @StyleSet  
	BEGIN 

		-- Qty, MaterialPrice 
		INSERT INTO pStyleSourcingItem ( StyleSourcingItemID , StyleSourcingID , CDate, CUSer, MDate, MUser , StyleMaterialID , UOM,  Sort  , StyleColorID  , StyleSet  )
		SELECT   NEWID() as  StyleSourcingItemID ,   @StyleSourcingID as  StyleSourcingID , @MDate as CDate , @MUser as CUser,  @MDate as MDate , @MUser as MUser,   
		StyleMaterialID , UOM,  MaterialSort , @StyleColorID as  StyleColorID , @Cont  as StyleSet 
		FROM pStyleMaterials 
		WHERE StyleID = @StyleID
		AND StyleSet  = @Cont


		--ASSIGN Vendors to SourcingItems 
		
		CREATE TABLE #item (
			ROW_ID INT IDENTITY (1,1),
			TradePartnerVendorID UNIQUEIDENTIFIER,
			MaterialSizeID		 UNIQUEIDENTIFIER,
			MaterialColorID		 UNIQUEIDENTIFIER,
			StyleSourcingItemID  UNIQUEIDENTIFIER
		)
		

		INSERT INTO  #item ( TradePartnerVendorID , MaterialSizeID, MaterialColorID , StyleSourcingItemID ) 
		SELECT  b.TradePartnerVendorID , b.MaterialSizeID, c.MaterialColorID, a.StyleSourcingItemID
		FROM pStyleSourcingItem a
		INNER JOIN pStyleMaterials b ON a.StyleMaterialID = b.StyleMaterialID 
		INNER JOIN pStyleColorwayItem c ON ( c.StyleColorID =  a.StyleColorID AND c.StyleMaterialID = a.StyleMaterialID ) 
		WHERE a.StyleSourcingID = @StyleSourcingID
		AND a.StyleColorID = @StyleColorID
		AND a.StyleSet = @Cont

		SELECT @TOTAL = COUNT(*) FROM #item 
		SET @ROW_ID = 1 

		WHILE @ROW_ID <= @TOTAL
		BEGIN

			SELECT @TradePartnerVendorID = TradePartnerVendorID, @MaterialSizeID = MaterialSizeID, 
			@MaterialColorID = MaterialColorID, @StyleSourcingItemID = StyleSourcingItemID
			FROM #item WHERE ROW_ID = @ROW_ID 		
		
			IF( SELECT  COUNT(*) 
				FROM pMaterialTradePartnerColor a 
				INNER JOIN pMaterialTradePartner b ON  a.MaterialTradePartnerID = b.MaterialTradePartnerID
				WHERE b.TradePartnerVendorID = @TradePartnerVendorID
				AND a.MaterialSizeId = @MaterialSizeID
				AND a.MaterialColorID = @MaterialColorID
			) > 0 
			BEGIN
				UPDATE pStyleSourcingItem SET TradePartnerVendorID = @TradePartnerVendorID
				WHERE StyleSourcingItemID = @StyleSourcingItemID
			END 
			

			SET @ROW_ID = @ROW_ID + 1 
		END 


		DROP TABLE #item 
		
		
		SET @Cont  = @Cont + 1 

	END 

	
	-- ADD COLORWAY to pStyleSourcingColor --
	INSERT INTO pStyleSourcingColor(StyleSourcingColorID, StyleSourcingID, StyleColorID, MUser, MDate)
	SELECT NEWID(), @StyleSourcingID, @StyleColorID, @MUser, @MDate
	------------------


END

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03084'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03084', GetDate())

END
GO