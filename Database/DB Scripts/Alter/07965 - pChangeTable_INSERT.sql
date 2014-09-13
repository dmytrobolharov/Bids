IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = '72121996-7A96-4C27-BE25-9C7B4A5AED37')
BEGIN
	INSERT INTO pChangeTable (ChangeTableID, ChangeTableName, ChangeTableFieldName, ChangeTablePKName, ChangeTableXML)
	VALUES ('72121996-7A96-4C27-BE25-9C7B4A5AED37', 'pPlanningItem', 'PlanningID', 'StyleID', 'ChangeLogItem_Default.xml')
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07965', GetDate())
GO
