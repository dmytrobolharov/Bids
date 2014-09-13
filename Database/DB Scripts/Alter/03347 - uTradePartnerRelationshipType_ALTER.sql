
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='TradePartnerLevel' AND TABLE_NAME='uTradePartnerRelationshipType')
BEGIN
	ALTER TABLE uTradePartnerRelationshipType ADD TradePartnerLevel int NULL DEFAULT 0
	
END 

GO
Update uTradePartnerRelationshipType set TradePartnerLevel = 0 where  TradePartnerLevel is null

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03347'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03347', GetDate())

END

GO