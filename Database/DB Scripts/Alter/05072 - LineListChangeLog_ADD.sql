IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = '3219FD45-BECC-2311-AF06-005056C00987')
	INSERT INTO pChangeTable (ChangeTableID, ChangeTableName, ChangeTableFieldName, ChangeTablePKName, ChangeTableXML)
	VALUES ('3219FD45-BECC-2311-AF06-005056C00987', 'pLineFolder', 'LineFolderID', 'LineFolderID', 'ChangeLogItem_Default.xml'		)

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05072', GetDate())
GO
