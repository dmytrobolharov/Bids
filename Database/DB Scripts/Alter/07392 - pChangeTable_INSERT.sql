IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = '7D33005D-6007-4381-A7F1-E0E1D10BF7A8')
BEGIN
	INSERT INTO pChangeTable (ChangeTableID, ChangeTableName, ChangeTableFieldName, ChangeTablePKName, ChangeTableXML)
	VALUES ('7D33005D-6007-4381-A7F1-E0E1D10BF7A8', 'pStyleSKUItems', 'PlanningSKUHeaderID', 'pStyleSKUItemsID', 'ChangeLogItem_Default.xml')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07392', GetDate())
GO
