UPDATE pChangeTable SET ChangeTableXML = 'ChangeLogItem_StyleHeader.xml' 
WHERE ChangeTableID = 'd612faae-7acd-df11-af06-005056c00008'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0.0000', '05642', GetDate())
GO
