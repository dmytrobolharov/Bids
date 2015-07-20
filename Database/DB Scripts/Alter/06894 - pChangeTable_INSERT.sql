IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = '7F221996-7A96-4C07-BE05-9C7B4A5AED37')
BEGIN
	INSERT INTO pChangeTable (ChangeTableID, ChangeTableName, ChangeTableFieldName, ChangeTablePKName, ChangeTableXML)
	VALUES ('7F221996-7A96-4C07-BE05-9C7B4A5AED37', 'pPlanningMaterial', 'PlanningID', 'PlanningMaterialID', 'ChangeLogItem_Default.xml')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06894', GetDate())
GO
