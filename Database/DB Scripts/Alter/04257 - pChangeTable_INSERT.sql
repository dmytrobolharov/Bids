IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = 'BC046C90-216E-4B97-8D9A-3D30191285CC')
INSERT INTO pChangeTable(ChangeTableID, ChangeTableName, ChangeTableFieldName, ChangeTablePKName, ChangeTableXML) 
VALUES ('BC046C90-216E-4B97-8D9A-3D30191285CC', 'pColorFolder', 'ColorFolderID', 'ColorFolderID', 'ChangeLogItem_ColorFolder.xml')
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04257', GetDate())
GO