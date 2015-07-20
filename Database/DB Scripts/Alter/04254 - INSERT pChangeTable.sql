IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = 'D612FAAE-ABCD-DF11-AF06-FF5056C00024')
BEGIN
	INSERT INTO pChangeTable (ChangeTableID, ChangeTableName, ChangeTableFieldName,ChangeTablePKName,ChangeTableXML)
	VALUES ('D612FAAE-ABCD-DF11-AF06-FF5056C00024','pImage','ImageID','ImageID','ChangeLogItem_Advanced.xml')
END

IF NOT EXISTS (SELECT * FROM pStyleWorkflowToChangeTable WHERE WorkflowID = '70000000-0000-0000-0000-000000000111')
BEGIN
	INSERT INTO pStyleWorkflowToChangeTable (WorkflowID, ChangeTableID)
	VALUES ('70000000-0000-0000-0000-000000000111','D612FAAE-ABCD-DF11-AF06-FF5056C00024')
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04254', GetDate())
GO

