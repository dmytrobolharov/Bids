IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = '3219FD45-BECC-DF11-AF06-005056C00987')
	INSERT INTO pChangeTable (ChangeTableID, ChangeTableName, ChangeTableFieldName, ChangeTablePKName, ChangeTableXML)
	VALUES ('3219FD45-BECC-DF11-AF06-005056C00987', 'pStyleColorway', 'StyleColorID', 'StyleColorID', 'ChangeLogItem_Default.xml')

IF NOT EXISTS (SELECT * FROM pStyleWorkflowToChangeTable WHERE WorkflowID = '40000000-0000-0000-0000-000000000021')
	INSERT INTO pStyleWorkflowToChangeTable (WorkflowID, ChangeTableID)
	VALUES ('40000000-0000-0000-0000-000000000021', '3219FD45-BECC-DF11-AF06-005056C00987')
GO
	
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05045', GetDate())
GO
