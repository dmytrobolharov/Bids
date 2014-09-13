IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = 'D612FAAE-ABCD-DF11-BBCF-FF5056C00024')
BEGIN
	INSERT INTO pChangeTable (ChangeTableID, ChangeTableName, ChangeTableFieldName, ChangeTablePKName, ChangeTableXML)
	VALUES ('D612FAAE-ABCD-DF11-BBCF-FF5056C00024', 'pImageWorkflowPage', 'ImageWorkflowPageID', 'ImageID', 'ChangeLogItem_Default.xml')
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08437', GetDate())
GO
