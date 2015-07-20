INSERT INTO pChangeTable(ChangeTableID, ChangeTableName, ChangeTableFieldName, ChangeTablePKName, ChangeTableXML) VALUES ('3219FD45-BECC-DF11-AF06-005056C00008', 'pMaterial', 'MaterialID', 'MaterialID', 'ChangeLogItem_Default.xml')
GO
INSERT INTO pChangeTable(ChangeTableID, ChangeTableName, ChangeTableFieldName, ChangeTablePKName, ChangeTableXML) VALUES ('036F8B4C-C1CC-DF11-AF06-005056C00008', 'pStyleMaterials', 'StyleMaterialID', 'StyleMaterialID', 'ChangeLog_StyleMaterial_Default.xml')
GO
INSERT INTO pChangeTable(ChangeTableID, ChangeTableName, ChangeTableFieldName, ChangeTablePKName, ChangeTableXML) VALUES ('D612FAAE-7ACD-DF11-AF06-005056C00008', 'pStyleHeader', 'StyleID', 'StyleID', 'ChangeLogItem_Default.xml')
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '586', GetDate())
GO
