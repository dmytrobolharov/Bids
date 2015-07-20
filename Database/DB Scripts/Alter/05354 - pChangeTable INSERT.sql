IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = '00000005-CCCC-DF11-AF06-005056C00018')
BEGIN
insert into pChangeTable(ChangeTableID,ChangeTableName,ChangeTableFieldName,ChangeTablePKName,ChangeTableXML) values('00000005-CCCC-DF11-AF06-005056C00018','pStyleSourcing','StyleSourcingID','StyleSourcingID','ChangeLogItem_Default.xml')
end

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05354', GetDate())
GO