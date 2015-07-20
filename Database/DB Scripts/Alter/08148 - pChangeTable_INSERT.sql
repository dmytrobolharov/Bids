IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = '1ABEE81C-5BCC-401E-8FDC-54E88C9DD5C1')
BEGIN
	INSERT INTO pChangeTable (ChangeTableID, ChangeTableName, ChangeTableFieldName, ChangeTablePKName, ChangeTableXML)
	VALUES ('1ABEE81C-5BCC-401E-8FDC-54E88C9DD5C1', 'pPlanning', 'pPlanningID', 'ImageCatalogID', 'ChangeLogItem_Default.xml')
END

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08148', GetDate())
GO
