IF NOT EXISTS(SELECT * FROM pChangeTable WHERE ChangeTableID='CCC00014-C1CC-DF11-AF06-005056C00008')
BEGIN
	INSERT INTO pChangeTable (ChangeTableID, ChangeTableName, ChangeTableFieldName, ChangeTablePKName, ChangeTableXML)
	VALUES ('CCC00014-C1CC-DF11-AF06-005056C00008', 'uTradePartnerAddress', 'TradePartnerAddressID', 'TradePartnerAddressID', 'ChangeLogItem_Default.xml')
END
GO 

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05817', GetDate())
GO
