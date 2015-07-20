UPDATE pChangeTable SET ChangeTableXML = 'ChangeLogItem_Default.xml' WHERE ChangeTableID = '10000000-CCCC-DFDF-AF06-005056C00008'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05084', GetDate())
GO
