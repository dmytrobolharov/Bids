IF NOT EXISTS(SELECT * FROM pChangeTable WHERE ChangeTableID = '036F8B4C-C1CC-DF11-AF06-005056C00118')
BEGIN
	INSERT INTO pChangeTable (ChangeTableID, ChangeTableName, ChangeTableFieldName, ChangeTablePKName, ChangeTableXML)
	VALUES('036F8B4C-C1CC-DF11-AF06-005056C00118', 'pStyleLicensee', 'StyleID', 'StyleID', 'ChangeLogItem_Advanced.xml')
END

GO

IF NOT EXISTS(SELECT * FROM pStyleWorkflowToChangeTable WHERE WorkflowID='40000000-0000-0000-0000-000000000009')
BEGIN
	INSERT INTO pStyleWorkflowToChangeTable(WorkflowID, ChangeTableID)
	VALUES ('40000000-0000-0000-0000-000000000009', '036F8B4C-C1CC-DF11-AF06-005056C00118')
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06063', GetDate())
GO
