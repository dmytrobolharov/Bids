IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialTradePartnerByMaterial_New_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialTradePartnerByMaterial_New_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_MaterialTradePartnerByMaterial_New_SELECT] (
@MaterialID UNIQUEIDENTIFIER
)
AS

DECLARE @ROW_ID  INT 
DECLARE @TOTAL INT 
DECLARE @TradePartnerID UNIQUEIDENTIFIER
DECLARE @TradePartnerRelationshipLevelID UNIQUEIDENTIFIER
DECLARE @MaterialTradePartnerID UNIQUEIDENTIFIER

CREATE TABLE #vendor (
	ROW_ID INT IDENTITY (1,1),
	TradePartnerRelationshipLevelID UNIQUEIDENTIFIER,
	MaterialTradePartnerID UNIQUEIDENTIFIER
)


INSERT INTO  #vendor  (TradePartnerRelationshipLevelID )
SELECT tprl.TradePartnerRelationshipLevelID
FROM pMaterialTradePartner a
	INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON a.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
where  MaterialId = @MaterialID
GROUP BY tprl.TradePartnerRelationshipLevelID 


SELECT @TOTAL = COUNT(*) FROM  #vendor 
SET @ROW_ID = 1 

WHILE @ROW_ID <= @TOTAL
BEGIN

	SELECT  @TradePartnerRelationshipLevelID = TradePartnerRelationshipLevelID
	FROM #vendor WHERE ROW_ID = @ROW_ID
		
	SELECT TOP 1 @MaterialTradePartnerID = MaterialTradePartnerID
	FROM pMaterialTradePartner 
	WHERE TradePartnerRelationshipLevelID = @TradePartnerRelationshipLevelID
	AND MaterialID = @MaterialID
	ORDER BY CDate DESC
	
	IF @MaterialTradePartnerID IS NULL
		DELETE FROM #vendor WHERE ROW_ID = @ROW_ID	
	ELSE
	BEGIN
		UPDATE #vendor SET MaterialTradePartnerID = @MaterialTradePartnerID WHERE ROW_ID = @ROW_ID	
	END

	SET @ROW_ID = @ROW_ID + 1 
END 
 
SELECT a.*, b.TradepartnerId, 
	tprl.TradePartnerRelationshipLevelID,
	SUBSTRING(ISNULL('/' + tprl.AgentName, '') + ISNULL('/' + tprl.VendorName,'') + ISNULL ('/' + tprl.FactoryName, ''), 2,1000) AS TradePartnerName
FROM #vendor a
INNER JOIN pMaterialTradePartner b ON a.MaterialTradePartnerID  = b.MaterialTradePartnerID
INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON a.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
ORDER BY TradePartnerName

DROP TABLE #vendor

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06649', GetDate())
GO
