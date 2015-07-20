IF NOT EXISTS(SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS
				WHERE COLUMN_NAME='TradePartnerRelationshipLevelID' 
				AND TABLE_NAME='pComplianceTradePartnerSharedFiles')
BEGIN
	ALTER TABLE pComplianceTradePartnerSharedFiles ADD TradePartnerRelationshipLevelID UNIQUEIDENTIFIER NULL
END

GO

-- Setting TradePartnerRelationshipLevels for all old agents
UPDATE pComplianceTradePartnerSharedFiles
SET TradePartnerRelationshipLevelID = tpm.RelationshipLevelID
FROM pComplianceTradePartnerSharedFiles sf INNER JOIN
vwx_TradePartnerMgmt_SEL tpm ON sf.TradePartnerID = tpm.TradePartnerID
WHERE TradePartnerRelationshipID IS NULL

DECLARE @ComplianceShareFileID UNIQUEIDENTIFIER,
@TradePartnerRelationshipLevelID UNIQUEIDENTIFIER,
@TradePartnerIDChain VARCHAR(MAX),
@ComplianceShareFileCursor CURSOR

SET @ComplianceShareFileCursor = CURSOR SCROLL
FOR SELECT ComplianceShareFileID, CAST(TradePartnerID AS VARCHAR(40)) AS TradePartnerIDChain FROM pComplianceTradePartnerSharedFiles WHERE TradePartnerRelationshipLevelID IS NULL
OPEN @ComplianceShareFileCursor

FETCH NEXT FROM @ComplianceShareFileCursor INTO @ComplianceShareFileID, @TradePartnerIDChain
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC spx_TradePartnerRelationshipLevels_INSERT @TradePartnerIDChain,
	@TradePartnerRelationshipLevelID OUTPUT
	
	UPDATE pComplianceTradePartnerSharedFiles SET TradePartnerRelationshipLevelID = @TradePartnerRelationshipLevelID
	WHERE ComplianceShareFileID = @ComplianceShareFileID
	
	FETCH NEXT FROM @ComplianceShareFileCursor INTO @ComplianceShareFileID, @TradePartnerIDChain
END

CLOSE @ComplianceShareFileCursor
DEALLOCATE @ComplianceShareFileCursor

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04993', GetDate())
GO
