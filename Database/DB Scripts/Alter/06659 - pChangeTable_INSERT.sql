IF NOT EXISTS (SELECT * FROM pChangeTable WHERE ChangeTableID = 'CCFFF2A1-7EB6-42FB-AE99-A7B2B9C86ABA')
BEGIN
	INSERT INTO pChangeTable (ChangeTableID, ChangeTableName, ChangeTableFieldName, ChangeTablePKName, ChangeTableXML)
	VALUES ('CCFFF2A1-7EB6-42FB-AE99-A7B2B9C86ABA', 'pPlanningColor', 'PlanningID', 'PlanningColorID', 'ChangeLogItem_Default.xml')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06659', GetDate())
GO
