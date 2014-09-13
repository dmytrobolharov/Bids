IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = 'AA10ADCA-CD33-ACBA-11DC-CDCDAAC004AA')
BEGIN
	INSERT INTO pChangeTable (ChangeTableID,ChangeTableName,ChangeTableFieldName,ChangeTablePKName,ChangeTableXML)
	VALUES ('AA10ADCA-CD33-ACBA-11DC-CDCDAAC004AA','pMaterialTradePartnerColor','MaterialTradePartnerColorID','MaterialTradePartnerColorID','ChangeLogItem_Advanced.xml')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04458', GetDate())
GO
