IF NOT EXISTS(SELECT * FROM pChangeTable WHERE ChangeTableID='10000001-1001-1010-AF06-00101FF00019')
BEGIN
	INSERT INTO pChangeTable (ChangeTableID, ChangeTableName, ChangeTableFieldName, ChangeTablePKName, ChangeTableXML)
	VALUES ('10000001-1001-1010-AF06-00101FF00019', 'pLineFolderBusiness', 'LineFolderPlanningCh', 'LineFolderID', 'ChangeLogItem_Default.xml')
END

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05582', GetDate())
GO
