UPDATE pChangeTable SET ChangeTableXML = 'ChangeLogItem_Default.xml' 
WHERE ChangeTableName LIKE 'pMaterial%' AND ChangeTableXML = 'ChangeLogItem_Advanced.xml'

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05607', GetDate())
GO
