IF EXISTS (SELECT * FROM pStyleWorkflowToChangeTable WHERE ChangeTableID = 'D612FAAE-7ACD-DF11-AF06-005056C00026') AND NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = 'D612FAAE-7ACD-DF11-AF06-005056C00026')
BEGIN
	INSERT INTO pChangeTable (ChangeTableID, ChangeTableName, ChangeTableFieldName, ChangeTablePKName, ChangeTableXML)
	VALUES ('D612FAAE-7ACD-DF11-AF06-005056C00026', 'pStyleSpecTemp', 'StyleID', 'SpecID', 'ChangeLogItem_Advanced.xml')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06065', GetDate())
GO
