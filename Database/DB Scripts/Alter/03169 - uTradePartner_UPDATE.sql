UPDATE uTradePartner SET TradePartnerClass = '1'  WHERE TradePartnerClass = '1' --Import
UPDATE uTradePartner SET TradePartnerClass = '4'  WHERE TradePartnerClass = '2' --Domestic
UPDATE uTradePartner SET TradePartnerClass = '8'  WHERE TradePartnerClass = '3' --Indirect
UPDATE uTradePartner SET TradePartnerClass = '12' WHERE TradePartnerClass = '4' --Both (Domestic + Indirect)

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03169'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03169', GetDate())
END
GO	