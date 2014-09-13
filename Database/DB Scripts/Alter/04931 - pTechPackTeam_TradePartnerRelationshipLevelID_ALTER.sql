IF NOT EXISTS (SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'pTechPackTeam' AND COLUMN_NAME='TradePartnerRelationshipLevelID')
BEGIN
	ALTER TABLE pTechPackTeam ADD TradePartnerRelationshipLevelID UNIQUEIDENTIFIER NULL
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04931', GetDate())
GO
