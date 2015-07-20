DECLARE @MaterialTradePartnerId UNIQUEIDENTIFIER
DECLARE @TradePartnerRelationshipLevelID UNIQUEIDENTIFIER
DECLARE @TradePartnerIDChain VARCHAR(MAX)

/** Updating records from old trade partner management **/

DECLARE @OldMaterialCursor CURSOR
-- Selecting all records with TradePartnerID and TradePartnerVendorID, and without TradePartnerRelationshipLevelID
SET @OldMaterialCursor = CURSOR SCROLL
FOR SELECT MaterialTradePartnerId, CAST(TradepartnerId AS VARCHAR(40)) + ',' + CAST(TradepartnerVendorId AS VARCHAR(40)) AS ChainID
FROM pMaterialTradePartner
WHERE TradepartnerId IS NOT NULL AND TradepartnerVendorId IS NOT NULL
AND TradePartnerRelationshipLevelID IS NULL
-- For each record creating a TradePartnerRelationshipLevelID and writing it to database
OPEN @OldMaterialCursor
FETCH NEXT FROM @OldMaterialCursor INTO @MaterialTradePartnerID, @TradePartnerIDChain
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC spx_TradePartnerRelationshipLevels_INSERT @TradePartnerIDChain,
	@TradePartnerRelationshipLevelID OUTPUT

	UPDATE pMaterialTradePartner SET TradePartnerRelationshipLevelID = @TradePartnerRelationshipLevelID
	WHERE MaterialTradePartnerId = @MaterialTradePartnerId

	FETCH NEXT FROM @OldMaterialCursor INTO @MaterialTradePartnerID, @TradePartnerIDChain
END
CLOSE @OldMaterialCursor
DEALLOCATE @OldMaterialCursor

/** Updating recrods from new trade partner management, but without levels **/

DECLARE @TradePartnerID UNIQUEIDENTIFIER
DECLARE @NewMaterialCursor CURSOR
-- Selecting all the records with TradePartnerID, and without TradePartnerVendorID and TradePartnerRelationshipLevelID
SET @NewMaterialCursor = CURSOR SCROLL
FOR SELECT MaterialTradePartnerId, TradePartnerId
FROM pMaterialTradePartner
WHERE TradepartnerId IS NOT NULL AND TradepartnerVendorId IS NULL
AND TradePartnerRelationshipLevelID IS NULL
-- For each record getting RelationshipLevelID from view (or creating it via spx, if there's no records in view) and writing it to database 
OPEN @NewMaterialCursor
FETCH NEXT FROM @NewMaterialCursor 
INTO @MaterialTradePartnerID, @TradePartnerID

WHILE @@FETCH_STATUS = 0
BEGIN

	SELECT TOP 1 @TradePartnerRelationshipLevelID = RelationshipLevelID, @TradePartnerIDChain = TradePartnerIDChain
	FROM vwx_TradePartnerMgmt_SEL
	WHERE TradePartnerID = @TradePartnerID

	IF @TradePartnerRelationshipLevelID IS NULL
	BEGIN
		EXEC spx_TradePartnerRelationshipLevels_INSERT @TradePartnerIDChain,
		@TradePartnerRelationshipLevelID OUTPUT
	END

	UPDATE pMaterialTradePartner SET TradePartnerRelationshipLevelID = @TradePartnerRelationshipLevelID
	WHERE MaterialTradePartnerId = @MaterialTradePartnerId

	FETCH NEXT FROM @NewMaterialCursor INTO @MaterialTradePartnerID, @TradePartnerID
END

CLOSE @NewMaterialCursor
DEALLOCATE @NewMaterialCursor

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04815', GetDate())
GO
