UPDATE pChangeTable SET ChangeTableXML = 'ChangeLogItem_Default.xml' 
WHERE ChangeTableID = '00000010-AAAA-BBBB-CCCC-005056C00008'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05599', GetDate())
GO
