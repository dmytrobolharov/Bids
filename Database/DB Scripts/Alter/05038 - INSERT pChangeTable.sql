IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = 'D612FAAE-ABCD-DF11-AF06-FF5056C00028')
BEGIN
	INSERT INTO pChangeTable (ChangeTableID, ChangeTableName, ChangeTableFieldName,ChangeTablePKName,ChangeTableXML)
	VALUES ('D612FAAE-ABCD-DF11-AF06-FF5056C00028','pStyleColorway','StyleColorID','StyleID','ChangeLogItem_Advanced.xml')
END

IF NOT EXISTS (SELECT * FROM pStyleWorkflowToChangeTable WHERE WorkflowID = '40000000-0000-0000-0000-000000000021')
BEGIN
	INSERT INTO pStyleWorkflowToChangeTable (WorkflowID, ChangeTableID)
	VALUES ('40000000-0000-0000-0000-000000000021','D612FAAE-ABCD-DF11-AF06-FF5056C00028')
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '05038', GetDate())
GO

