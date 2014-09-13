IF NOT EXISTS (SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'pStyleTeam' AND COLUMN_NAME='TradePartnerRelationshipLevelID')
BEGIN
	ALTER TABLE pStyleTeam ADD TradePartnerRelationshipLevelID UNIQUEIDENTIFIER NULL
END

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04919', GetDate())
GO
