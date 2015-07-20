UPDATE pChangeTable SET ChangeTableXML = 'ChangeLogItem_Default.xml' 
WHERE ChangeTableID = '9C79E7A4-B799-4186-9A21-4EA6DB908498'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0.0000', '05643', GetDate())
GO
