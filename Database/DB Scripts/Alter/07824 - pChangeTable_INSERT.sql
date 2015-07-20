IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = 'DDD3BEB9-026F-4260-9B0E-B25F3560D776')
BEGIN
	INSERT INTO pChangeTable (ChangeTableID, ChangeTableName, ChangeTableFieldName, ChangeTablePKName, ChangeTableXML)
	VALUES ('DDD3BEB9-026F-4260-9B0E-B25F3560D776', 'pMaterialCore', 'MaterialCoreID', 'MaterialCoreID', 'ChangeLogItem_Default.xml')
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07824', GetDate())
GO
