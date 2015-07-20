IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialTradePartnerVendor_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialTradePartnerVendor_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[spx_MaterialTradePartnerVendor_SELECT] (
@MaterialID UNIQUEIDENTIFIER,
@TradePartnerID UNIQUEIDENTIFIER
)
AS

DECLARE @ROW_ID  INT 
DECLARE @TOTAL INT 
DECLARE @TradepartnerVendorID UNIQUEIDENTIFIER
DECLARE @MaterialTradePartnerID UNIQUEIDENTIFIER

CREATE TABLE #vendor (
	ROW_ID INT IDENTITY (1,1),
	TradePartnerID UNIQUEIDENTIFIER,
	TradepartnerVendorID UNIQUEIDENTIFIER,
	MaterialTradePartnerID UNIQUEIDENTIFIER
)


INSERT INTO  #vendor  ( TradePartnerID , TradepartnerVendorID  )
SELECT a.TradePartnerID , a.TradepartnerVendorID 
from pMaterialTradePartner a
where  MaterialId = @MaterialID
AND TradePartnerID = @TradePartnerID
GROUP BY a.TradePartnerID , a.TradepartnerVendorID 


SELECT @TOTAL = COUNT(*) FROM  #vendor 
SET @ROW_ID = 1 

WHILE @ROW_ID <= @TOTAL
BEGIN

	SELECT  @TradepartnerVendorID = TradepartnerVendorID
	FROM #vendor WHERE ROW_ID = @ROW_ID
		
	SELECT TOP 1 @MaterialTradePartnerID = MaterialTradePartnerID
	FROM pMaterialTradePartner 
	WHERE TradePartnerID = @TradePartnerID 
	AND TradepartnerVendorID = @TradepartnerVendorID
	AND MaterialID = @MaterialID
	
	IF @MaterialTradePartnerID IS NULL
		DELETE FROM #vendor WHERE ROW_ID = @ROW_ID	
	ELSE
	BEGIN
			UPDATE #vendor SET MaterialTradePartnerID = @MaterialTradePartnerID WHERE ROW_ID = @ROW_ID	
	END

	SET @ROW_ID = @ROW_ID + 1 
END 
 
SELECT a.*, b.TradePartnerVendorID , c.VendorName
FROM #vendor a
INNER JOIN pMaterialTradePartner b ON a.MaterialTradePartnerID  = b.MaterialTradePartnerID
INNER JOIN uTradePartnerVendor c ON c.TradePartnerVendorID = b.TradePartnerVendorID WHERE c.Active <> 0

DROP TABLE #vendor
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01958'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01958', GetDate())
END	
GO
