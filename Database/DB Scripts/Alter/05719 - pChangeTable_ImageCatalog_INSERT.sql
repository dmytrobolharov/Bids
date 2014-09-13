IF NOT EXISTS(SELECT * FROM pChangeTable WHERE ChangeTableID='F000000F-1F01-F0F0-AF06-00F0FFF00019')
BEGIN
	INSERT INTO pChangeTable (ChangeTableID, ChangeTableName, ChangeTableFieldName, ChangeTablePKName, ChangeTableXML)
	VALUES ('F000000F-1F01-F0F0-AF06-00F0FFF00019', 'pImageCatalogItem', 'ImageCatalogItemID', 'ImageCatalogItemID', 'ChangeLogItem_Default.xml')
END
GO 

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05719', GetDate())
GO



