UPDATE pLineFolderType SET LineFolderSchemaItem  = 'LineFolderItem_List.xml'
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '100', GetDate())
GO
