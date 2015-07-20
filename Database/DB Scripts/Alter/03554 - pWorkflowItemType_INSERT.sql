IF NOT EXISTS (SELECT * FROM pWorkflowItemType WHERE UPPER(ItemTypeLabel) = 'BILL OF LABOR')
BEGIN
	INSERT INTO [pWorkflowItemType]
			   ([WorkflowItemTypeId]
			   ,[MapId]
			   ,[SchemaFileName]
			   ,[ItemTypeLabel]
			   ,[SchemaFileEditName])
		 VALUES
			   ('40000000-0000-0000-0000-000000000078'
			   ,'40000000-0000-0000-0000-000000000078'
			   ,'Style_NBOL_Summary_Read_Default.xml'
			   ,'Bill Of Labor'
			   ,'Style_NBOL_Summary_Edit_Default.xml')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03554', GetDate())
GO