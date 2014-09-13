IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = '00000010-AAAA-BBBB-CCCC-005056C00008')
BEGIN
	INSERT INTO pChangeTable (ChangeTableID,ChangeTableName,ChangeTableFieldName,ChangeTablePKName,ChangeTableXML)
	VALUES ('00000010-AAAA-BBBB-CCCC-005056C00008','pImage','ImageID','ImageID','ChangeLogItem_Advanced.xml')
END

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04368', GetDate())
GO
