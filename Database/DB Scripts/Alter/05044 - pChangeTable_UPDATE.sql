UPDATE pChangeTable SET ChangeTableXML = 'ChangeLogItem_Default.xml' 
WHERE ChangeTableID IN (SELECT ChangeTableID FROM pMaterialRequestToChangeTable)
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05044', GetDate())
GO
