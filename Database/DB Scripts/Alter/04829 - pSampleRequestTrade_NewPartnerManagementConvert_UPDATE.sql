DECLARE @SampleRequestTradeID UNIQUEIDENTIFIER
DECLARE @TradePartnerRelationshipLevelID UNIQUEIDENTIFIER
DECLARE @TradePartnerIDChain VARCHAR(MAX)

/** UPDATING BOM TRADES **/
/** Updating records from old trade partner management **/

DECLARE @OldSampleCursor CURSOR
-- Selecting all records with TradePartnerID and TradePartnerVendorID, and without TradePartnerRelationshipLevelID
SET @OldSampleCursor = CURSOR SCROLL
FOR SELECT SampleRequestTradeID, CAST(TradepartnerId AS VARCHAR(40)) + ',' + CAST(TradepartnerVendorId AS VARCHAR(40)) AS ChainID
FROM pSampleRequestBOMTrade
WHERE TradepartnerId IS NOT NULL AND TradepartnerVendorId IS NOT NULL
AND TradePartnerRelationshipLevelID IS NULL
-- For each record creating a TradePartnerRelationshipLevelID and writing it to database
OPEN @OldSampleCursor
FETCH NEXT FROM @OldSampleCursor INTO @SampleRequestTradeID, @TradePartnerIDChain
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC spx_TradePartnerRelationshipLevels_INSERT @TradePartnerIDChain,
	@TradePartnerRelationshipLevelID OUTPUT

	UPDATE pSampleRequestBOMTrade SET TradePartnerRelationshipLevelID = @TradePartnerRelationshipLevelID
	WHERE SampleRequestTradeID = @SampleRequestTradeID

	FETCH NEXT FROM @OldSampleCursor INTO @SampleRequestTradeID, @TradePartnerIDChain
END

/** Updating recrods from new trade partner management, but without levels **/

DECLARE @TradePartnerID UNIQUEIDENTIFIER
DECLARE @NewSampleCursor CURSOR
-- Selecting all the records with TradePartnerID, and without TradePartnerVendorID and TradePartnerRelationshipLevelID
SET @NewSampleCursor = CURSOR SCROLL
FOR SELECT SampleRequestTradeID, TradePartnerId
FROM pSampleRequestBOMTrade
WHERE TradepartnerId IS NOT NULL AND TradepartnerVendorId IS NULL
AND TradePartnerRelationshipLevelID IS NULL
-- For each record getting RelationshipLevelID from view (or creating it via spx, if there's no records in view) and writing it to database 
OPEN @NewSampleCursor
FETCH NEXT FROM @NewSampleCursor 
INTO @SampleRequestTradeID, @TradePartnerID

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

	UPDATE pSampleRequestBOMTrade SET TradePartnerRelationshipLevelID = @TradePartnerRelationshipLevelID
	WHERE SampleRequestTradeID = @SampleRequestTradeID

	FETCH NEXT FROM @NewSampleCursor INTO @SampleRequestTradeID, @TradePartnerID
END


/** UPDATING NON-BOM TRADES **/
/** Updating records from old trade partner management **/

-- Selecting all records with TradePartnerID and TradePartnerVendorID, and without TradePartnerRelationshipLevelID
SET @OldSampleCursor = CURSOR SCROLL
FOR SELECT SampleRequestTradeID, CAST(TradepartnerId AS VARCHAR(40)) + ',' + CAST(TradepartnerVendorId AS VARCHAR(40)) AS ChainID
FROM pSampleRequestTrade
WHERE TradepartnerId IS NOT NULL AND TradepartnerVendorId IS NOT NULL
AND TradePartnerRelationshipLevelID IS NULL
-- For each record creating a TradePartnerRelationshipLevelID and writing it to database
OPEN @OldSampleCursor
FETCH NEXT FROM @OldSampleCursor INTO @SampleRequestTradeID, @TradePartnerIDChain
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC spx_TradePartnerRelationshipLevels_INSERT @TradePartnerIDChain,
	@TradePartnerRelationshipLevelID OUTPUT

	UPDATE pSampleRequestTrade SET TradePartnerRelationshipLevelID = @TradePartnerRelationshipLevelID
	WHERE SampleRequestTradeID = @SampleRequestTradeID

	FETCH NEXT FROM @OldSampleCursor INTO @SampleRequestTradeID, @TradePartnerIDChain
END
CLOSE @OldSampleCursor
DEALLOCATE @OldSampleCursor

/** Updating recrods from new trade partner management, but without levels **/

-- Selecting all the records with TradePartnerID, and without TradePartnerVendorID and TradePartnerRelationshipLevelID
SET @NewSampleCursor = CURSOR SCROLL
FOR SELECT SampleRequestTradeID, TradePartnerId
FROM pSampleRequestTrade
WHERE TradepartnerId IS NOT NULL AND TradepartnerVendorId IS NULL
AND TradePartnerRelationshipLevelID IS NULL
-- For each record getting RelationshipLevelID from view (or creating it via spx, if there's no records in view) and writing it to database 
OPEN @NewSampleCursor
FETCH NEXT FROM @NewSampleCursor 
INTO @SampleRequestTradeID, @TradePartnerID

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

	UPDATE pSampleRequestTrade SET TradePartnerRelationshipLevelID = @TradePartnerRelationshipLevelID
	WHERE SampleRequestTradeID = @SampleRequestTradeID

	FETCH NEXT FROM @NewSampleCursor INTO @SampleRequestTradeID, @TradePartnerID
END

CLOSE @NewSampleCursor
DEALLOCATE @NewSampleCursor

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04829', GetDate())
GO
