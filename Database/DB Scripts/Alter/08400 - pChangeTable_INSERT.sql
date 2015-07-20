IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = 'CCC0490A-44C8-47D3-AD63-3021DAA13142')
BEGIN
	INSERT INTO pChangeTable (ChangeTableID, ChangeTableName, ChangeTableFieldName, ChangeTablePKName, ChangeTableXML)
	VALUES ('CCC0490A-44C8-47D3-AD63-3021DAA13142', 'pPlanningItem', 'StyleBOMDimensionID', 'PlanningID', 'ChangeLogItem_Default.xml')
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08400', GetDate())
GO
