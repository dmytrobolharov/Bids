IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = '9C79E7A4-B799-4186-9A21-4EA6DB908498')
INSERT INTO pChangeTable(ChangeTableID, ChangeTableName, ChangeTableFieldName, ChangeTablePKName, ChangeTableXML) 
VALUES ('9C79E7A4-B799-4186-9A21-4EA6DB908498', 'pColorPalette', 'ColorPaletteID', 'ColorPaletteID', 'ChangeLogItem_Advanced.xml')
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04256', GetDate())
GO