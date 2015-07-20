begin
   
	if not exists (select * from mapping WHERE Map = '40000000-0000-0000-0000-000000000080')
	
		begin
		
			INSERT INTO [dbo].[Mapping]
			   ([Map]
			   ,[MapDetail]
			   ,[MapUrl]
			   ,[MapEditUrl]
			   ,[MapEmlUrl]
			   ,[MapFolder]           
			   ,[MapPageUrl])
			VALUES
			   ('40000000-0000-0000-0000-000000000080'
			   ,'Dimensional BOM'
			   ,'Style_WorkFlowItems.aspx'
			   ,'Style_DimensionalBOM.aspx'
			   ,'Style_DimensionalBOM_Eml.aspx'
			   ,'StyleFolder'           
			   ,'Style_DimensionalBOM.aspx')
		end
	
	if not exists (select * from pWorkflowItemType WHERE MapId = '40000000-0000-0000-0000-000000000080')
	
		begin
		
			INSERT INTO [dbo].[pWorkflowItemType]
			   ([MapId]
			   ,[SchemaFileName]
			   ,[ItemTypeLabel]
			   ,[SchemaFileEditName])
			VALUES
			   ('40000000-0000-0000-0000-000000000080'
			   ,'Style_DimensionalBOM_Default.xml'
			   ,'Dimensional BOM'
			   ,'Style_DimensionalBOMRead_Default.xml')
		end
	
	if not exists (select * from pWorkflow WHERE WorkflowID = '40000000-0000-0000-0000-000000000080')
	
		begin
	
			INSERT INTO [dbo].[pWorkflow]
				   ([WorkflowID]
				   ,[Workflow]
				   ,[WorkDays]
				   ,[WorkAlert]
				   ,[WorkflowSort]				   
				   ,[Active]
				   ,[Body]
				   ,[WorkflowTypeID])
			 VALUES
				   ('40000000-0000-0000-0000-000000000080'
				   ,'Dimensional BOM'
				   ,3
				   ,10
				   ,3				   
				   ,'True'
				   ,0
				   ,'D')
		end
end

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01849'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '4.1.0000', '01849', GetDate())
	END

	GO