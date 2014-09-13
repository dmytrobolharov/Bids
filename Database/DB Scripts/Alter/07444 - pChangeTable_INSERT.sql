IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = '9CFFFB98-E4C1-40CA-B532-6A8BCDD3F7BD')
BEGIN
	INSERT INTO pChangeTable (ChangeTableID, ChangeTableName, ChangeTableFieldName, ChangeTablePKName, ChangeTableXML)
	VALUES ('9CFFFB98-E4C1-40CA-B532-6A8BCDD3F7BD', 'pLineFolderSKUHeader', 'LineFolderID', 'LineFolderSKUHeaderID', 'ChangeLogItem_Default.xml')
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07444', GetDate())
GO
