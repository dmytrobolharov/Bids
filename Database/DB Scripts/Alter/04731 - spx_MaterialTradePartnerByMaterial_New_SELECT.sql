/****** Object:  StoredProcedure [dbo].[spx_MaterialTradePartnerByMaterial_New_SELECT]    Script Date: 01/09/2013 17:03:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialTradePartnerByMaterial_New_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialTradePartnerByMaterial_New_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialTradePartnerByMaterial_New_SELECT]    Script Date: 01/09/2013 17:03:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_MaterialTradePartnerByMaterial_New_SELECT] (
@MaterialID UNIQUEIDENTIFIER
)
AS

DECLARE @ROW_ID  INT 
DECLARE @TOTAL INT 
DECLARE @TradePartnerID UNIQUEIDENTIFIER
DECLARE @MaterialTradePartnerID UNIQUEIDENTIFIER

CREATE TABLE #vendor (
	ROW_ID INT IDENTITY (1,1),
	TradePartnerID UNIQUEIDENTIFIER,
	MaterialTradePartnerID UNIQUEIDENTIFIER
)


INSERT INTO  #vendor  ( TradePartnerID )
SELECT a.TradePartnerID
FROM pMaterialTradePartner a
where  MaterialId = @MaterialID
GROUP BY a.TradePartnerID 


SELECT @TOTAL = COUNT(*) FROM  #vendor 
SET @ROW_ID = 1 

WHILE @ROW_ID <= @TOTAL
BEGIN

	SELECT  @TradepartnerID = TradepartnerID
	FROM #vendor WHERE ROW_ID = @ROW_ID
		
	SELECT TOP 1 @MaterialTradePartnerID = MaterialTradePartnerID
	FROM pMaterialTradePartner 
	WHERE TradePartnerID = @TradePartnerID
	AND MaterialID = @MaterialID
	
	IF @MaterialTradePartnerID IS NULL
		DELETE FROM #vendor WHERE ROW_ID = @ROW_ID	
	ELSE
	BEGIN
		UPDATE #vendor SET MaterialTradePartnerID = @MaterialTradePartnerID WHERE ROW_ID = @ROW_ID	
	END

	SET @ROW_ID = @ROW_ID + 1 
END 
 
SELECT a.*, b.TradepartnerId , c.TradePartnerName
FROM #vendor a
INNER JOIN pMaterialTradePartner b ON a.MaterialTradePartnerID  = b.MaterialTradePartnerID
INNER JOIN uTradePartner c ON c.TradePartnerID = b.TradePartnerID WHERE c.Active <> 0
ORDER BY c.TradePartnerName

DROP TABLE #vendor
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04731', GetDate())
GO
