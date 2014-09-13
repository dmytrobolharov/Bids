IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pSampleRequestStyleSourcingTemp' AND COLUMN_NAME = 'TradePartnerRelationshipLevelID')
BEGIN
	ALTER TABLE pSampleRequestStyleSourcingTemp ADD TradePartnerRelationshipLevelID UNIQUEIDENTIFIER NULL
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pSampleRequestStyleSourcingBOMTemp' AND COLUMN_NAME = 'TradePartnerRelationshipLevelID')
BEGIN
	ALTER TABLE pSampleRequestStyleSourcingBOMTemp ADD TradePartnerRelationshipLevelID UNIQUEIDENTIFIER NULL
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pSampleRequestTrade' AND COLUMN_NAME = 'TradePartnerRelationshipLevelID')
BEGIN
	ALTER TABLE pSampleRequestTrade ADD TradePartnerRelationshipLevelID UNIQUEIDENTIFIER NULL
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pSampleRequestBOMTrade' AND COLUMN_NAME = 'TradePartnerRelationshipLevelID')
BEGIN
	ALTER TABLE pSampleRequestBOMTrade ADD TradePartnerRelationshipLevelID UNIQUEIDENTIFIER NULL
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04824', GetDate())
GO
