IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = '71D01077-30CC-4A4B-837A-51CD597075FB')
BEGIN
	INSERT INTO pChangeTable (ChangeTableID, ChangeTableName, ChangeTableFieldName, ChangeTablePKName, ChangeTableXML)
	VALUES ('71D01077-30CC-4A4B-837A-51CD597075FB', 'pPlanningSKUHeader', 'PlanningID', 'PlanningSKUHeaderID', 'ChangeLogItem_Default.xml')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07370', GetDate())
GO
