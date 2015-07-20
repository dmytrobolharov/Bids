IF NOT EXISTS (SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'pMaterialTradePartner'
AND COLUMN_NAME = 'TradePartnerRelationshipLevelID')
BEGIN
	ALTER TABLE pMaterialTradePartner ADD TradePartnerRelationshipLevelID UNIQUEIDENTIFIER NULL
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04781', GetDate())
GO
