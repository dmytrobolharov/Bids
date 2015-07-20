UPDATE pChangeTable SET ChangeTableXML = 'ChangeLogItem_Default.xml'
WHERE ChangeTableID = '10000000-caca-afaf-af06-005056c00008'

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08881', GetDate())
GO