IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = 'EEE3BEB9-026F-4260-9B0E-B25F3560D778')
BEGIN
	INSERT INTO pChangeTable (ChangeTableID, ChangeTableName, ChangeTableFieldName, ChangeTablePKName, ChangeTableXML)
	VALUES ('EEE3BEB9-026F-4260-9B0E-B25F3560D778', 'pStyleSKUItems', 'LineFolderSKUHeaderID', 'pStyleSKUItemsID', 'ChangeLogItem_Default.xml')
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07445', GetDate())
GO
