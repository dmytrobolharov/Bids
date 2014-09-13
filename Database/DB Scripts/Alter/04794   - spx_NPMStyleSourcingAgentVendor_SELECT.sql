/****** Object:  StoredProcedure [dbo].[spx_NPMStyleSourcingAgentVendor_SELECT]    Script Date: 01/16/2013 11:28:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMStyleSourcingAgentVendor_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMStyleSourcingAgentVendor_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_NPMStyleSourcingAgentVendor_SELECT]    Script Date: 01/16/2013 11:28:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_NPMStyleSourcingAgentVendor_SELECT]  (
@StyleMaterialID UNIQUEIDENTIFIER ,
@StyleColorID UNIQUEIDENTIFIER ,
@StyleSourcingID UNIQUEIDENTIFIER ,
@ShowCount INT =  0  OUTPUT
)
AS


DECLARE @MaterialColorID UNIQUEIDENTIFIER 
DECLARE @MaterialID  UNIQUEIDENTIFIER 
DECLARE @MaterialSize NVARCHAR (100)
DECLARE @MaterialSizeID UNIQUEIDENTIFIER 
DECLARE @ColorWay as INT



SELECT @MaterialColorID  = a.MaterialColorID , @MaterialID  = a.MaterialID ,
@MaterialSizeID = b.MaterialSizeID , @MaterialSize = b.MaterialSize , @ColorWay = b.Colorway
FROM pStyleColorwayItem a  INNER JOIN pStyleMaterials b  ON a.StyleMaterialID =  b.StyleMaterialID 
WHERE a.StyleColorId = @StyleColorID 
AND a.StyleMaterialID = @StyleMaterialID


--SELECT MaterialColorID = @MaterialColorID  , MaterialID =@MaterialID   , MaterialSizeID = @MaterialSizeID  ,   MaterialSize = @MaterialSize 
--SELECT @MaterialSize


UPDATE pMaterialTradePartnerColor SET MaterialSizeID = '00000000-0000-0000-0000-000000000000'
WHERE  MaterialID = @MaterialID
AND MaterialSizeID  IS NULL



IF  LOWER ( @MaterialSize ) = '*na'  
BEGIN 
	
	IF @MaterialSizeID  IS NULL
		SET @MaterialSizeID  =  '00000000-0000-0000-0000-000000000000'

	UPDATE pStyleMaterials SET MaterialSizeID =  '00000000-0000-0000-0000-000000000000'   WHERE StyleMaterialID = @StyleMaterialID 

END
ELSE 
BEGIN 
	IF @MaterialSizeID  IS NULL 
	BEGIN 
		SELECT @MaterialSizeID = MaterialSizeID FROM pMaterialSize WHERE MaterialID = @MaterialID  AND MaterialSize = @MaterialSize
		IF @MaterialSizeID IS NOT NULL
		BEGIN
			UPDATE pStyleMaterials SET MaterialSizeID = @MaterialSizeID WHERE StyleMaterialID = @StyleMaterialID 
		END
	END 
END 


--SELECT @ColorWay AS COLORWAY 

DECLARE @COUNT AS INT 

set @COUNT = 0 


IF @ColorWay  = 1 
BEGIN 

		IF  @ShowCount = 1  
		BEGIN
			SELECT @COUNT  = COUNT(*) 
			FROM pMaterialTradePartnerColor a INNER JOIN pMaterialTradePartner b ON a.MaterialTradePartnerID =  b.MaterialTradePartnerID 
			-- INNER JOIN  uTradePartnerVendor c   ON  b.TradepartnerVendorId = c.TradePartnerVendorID 
			INNER JOIN  uTradePartner d ON  b.TradePartnerID =  d.TradePartnerID   
			WHERE a.MaterialID = @MaterialID
			AND a.MaterialColorID = @MaterialColorID  
			AND a.MaterialSizeID  = @MaterialSizeID 
			GROUP BY  d.TradePartnerName + ' - ' +  d.TradePartnerName   , d.TradePartnerID
		END 
		ELSE 
		BEGIN 

			SELECT d.TradePartnerName + ' - ' +  d.TradePartnerName   as TextValue ,  d.TradePartnerID 
			,a.MaterialtradeColor5 as ColorCode , a.MaterialTradeColor6 AS ColorName
			FROM pMaterialTradePartnerColor a INNER JOIN pMaterialTradePartner b ON a.MaterialTradePartnerID =  b.MaterialTradePartnerID 
			-- INNER JOIN  uTradePartnerVendor c   ON  b.TradepartnerVendorId = c.TradePartnerVendorID 
			INNER JOIN  uTradePartner d ON  b.TradePartnerID =  d.TradePartnerID   
			WHERE a.MaterialID = @MaterialID
			AND a.MaterialColorID = @MaterialColorID  
			AND a.MaterialSizeID  = @MaterialSizeID 
			GROUP BY  d.TradePartnerName + ' - ' +  d.TradePartnerName   , d.TradePartnerID
			,a.MaterialtradeColor5, a.MaterialTradeColor6

		END 

END



SET  @ShowCount  =  @COUNT

PRINT 'showcount = ' + CAST ( @ShowCount  AS NVARCHAR(50))


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04794', GetDate())
GO