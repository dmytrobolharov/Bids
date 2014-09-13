IF NOT EXISTS(SELECT ChangeTableID FROM pChangeTable WHERE ChangeTableID='ccc00010-c1cc-df11-af06-005056c00008')
BEGIN
	INSERT INTO	pChangeTable(
		ChangeTableID
		, ChangeTableName
		, ChangeTableFieldName
		, ChangeTablePKName
		, ChangeTableXML)
	VALUES
		('ccc00010-c1cc-df11-af06-005056c00008'
		, 'uTradePartner'
		, 'TradePartnerID'
		, 'TradePartnerID'
		, 'ChangeLogItem_Default.xml')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04712', GetDate())
GO
