IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = '0DAC88B0-8567-4BC5-87F4-E687277D42D2')
BEGIN
	INSERT INTO pChangeTable (ChangeTableID, ChangeTableName, ChangeTableFieldName, ChangeTablePKName, ChangeTableXML)
	VALUES ('0DAC88B0-8567-4BC5-87F4-E687277D42D2', 'pPlanningTACalendar', 'PlanningTACalendarID', 'PlanningID', 'ChangeLogItem_Default.xml')
END
GO

IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = 'B2CC2239-1406-47F2-B66C-A14D0ABBC537')
BEGIN
	INSERT INTO pChangeTable (ChangeTableID, ChangeTableName, ChangeTableFieldName, ChangeTablePKName, ChangeTableXML)
	VALUES ('B2CC2239-1406-47F2-B66C-A14D0ABBC537', 'pPlanningTACalendar', 'PlanningTACalendarID', 'PlanningTACalendarID', 'ChangeLogItem_Default.xml')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08799', GetDate())
GO
