insert into pChangeTable(ChangeTableID,ChangeTableName,ChangeTableFieldName,ChangeTablePKName,ChangeTableXML)
values('8038A3FD-0580-422F-A3A6-895CA0223A81','pStyleQuoteItem','StyleQuoteItemID','StyleQuoteItemID','ChangeLogItem_Default.xml')
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04810', GetDate())
GO