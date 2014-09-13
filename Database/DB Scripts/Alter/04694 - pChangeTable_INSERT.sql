if NOT EXISTS(SELECT * FROM pChangeTable WHERE ChangeTableID = 'D52E57A5-8B41-42BA-826B-1327A08CA725')
begin
	INSERT INTO pChangeTable(ChangeTableID, ChangeTableName, ChangeTableFieldName, ChangeTablePKName, ChangeTableXML)
	VALUES ('D52E57A5-8B41-42BA-826B-1327A08CA725', 'pSourcingStyle', 'StyleID', 'SourcingStyleID', 'ChangeLogItem_Default.xml')
end
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04694', GetDate())
GO