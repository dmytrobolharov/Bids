INSERT INTO pChangeTable (ChangeTableID, ChangeTableName, ChangeTableFieldName, ChangeTablePKName, ChangeTableXML)
VALUES('D612AAAA-BBBB-DF11-AFCC-FF5056C111DD', 'pMaterialSize', 'MaterialID', 'MaterialSizeID', 'ChangeLogItem_Default.xml')
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08393', GetDate())
GO
