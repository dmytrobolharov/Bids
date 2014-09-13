begin

	IF NOT EXISTS (SELECT * FROM pControlPanelType WHERE UPPER(ControlPanelTypeName) = 'BILL OF LABOR v.2')
	BEGIN
		INSERT [dbo].[pControlPanelType] ([ControlPanelTypeID], [ControlPanelTypeName], [ControlPanelTypeDescription], [CUser], [CDate], [MUser], [MDate],[Active], [Sort]) 
		VALUES (N'09773e42-5ab8-e011-9f63-544c92f24f0d', N'Bill Of Labor v.2', N'Bill Of Labor v.2', NULL, NULL, NULL, NULL, 1, NULL)
	END

	Declare @ControlPanelID int
	Declare @ControlPanelOrder int
	
	if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = UPPER('Operation Type'))
	begin
		select @ControlPanelID = COALESCE(MAX(ControlPanelID),0) + 1, @ControlPanelOrder = COALESCE(MAX(ControlPanelOrder),0) + 1  From pControlPanel
		Insert into pControlPanel (ControlPanelID,ControlPanelName,ControlPanelDescription,ControlPanelOrder,ControlPanelTableName,ControlPanelSchema,
				 ControlPanelSearchSchema, ControlPanelEditSchema, ControlPanelUrl, ControlPanelTypeID) values
		(@ControlPanelID,'Operation Type','Operation Type',@ControlPanelOrder,'pNBOLOperationType','Control_NBOL_OperationType_Default.xml',
				'Control_NBOL_OperationType_Search.xml', 'Control_NBOL_OperationType_Default.xml', 'Control_NBOL_OperationType_List.aspx?CPID=' + convert(varchar(12),@ControlPanelID), '09773e42-5ab8-e011-9f63-544c92f24f0d')
	end	


	if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = UPPER('Operation Library'))
	begin
		select @ControlPanelID = COALESCE(MAX(ControlPanelID),0) + 1, @ControlPanelOrder = COALESCE(MAX(ControlPanelOrder),0) + 1  From pControlPanel
		Insert into pControlPanel (ControlPanelID,ControlPanelName,ControlPanelDescription,ControlPanelOrder,ControlPanelTableName,ControlPanelSchema,
				 ControlPanelSearchSchema, ControlPanelEditSchema, ControlPanelUrl, ControlPanelTypeID) values
		(@ControlPanelID,'Operation Library','Operation Library',@ControlPanelOrder,'pNBOLOperation','Control_NBOL_Operation_Default.xml',
				'Control_NBOL_Operation_Search.xml', 'Control_NBOL_Operation_Edit_Default.xml', 'Control_NBOL_OperationLibrary.aspx?CPID=' + convert(varchar(12),@ControlPanelID), '09773e42-5ab8-e011-9f63-544c92f24f0d')
	end	

	
	if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = UPPER('Machine Class'))
	begin
		select @ControlPanelID = COALESCE(MAX(ControlPanelID),0) + 1, @ControlPanelOrder = COALESCE(MAX(ControlPanelOrder),0) + 1  From pControlPanel
		Insert into pControlPanel (ControlPanelID,ControlPanelName,ControlPanelDescription,ControlPanelOrder,ControlPanelTableName,ControlPanelSchema,
				 ControlPanelSearchSchema, ControlPanelEditSchema, ControlPanelUrl, ControlPanelTypeID) values
		(@ControlPanelID,'Machine Class','Machine Class',@ControlPanelOrder,'pNBOLMachineClass','Control_NBOL_MachineClass_Default.xml',
				'Control_NBOL_MachineClass_Search.xml', 'Control_NBOL_MachineClass_Default.xml', 'Control_NBOL_MachineClass_List.aspx?CPID=' + convert(varchar(12),@ControlPanelID), '09773e42-5ab8-e011-9f63-544c92f24f0d')
	end
	
	
	if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = UPPER('Machinery'))
	begin
		select @ControlPanelID = COALESCE(MAX(ControlPanelID),0) + 1, @ControlPanelOrder = COALESCE(MAX(ControlPanelOrder),0) + 1  From pControlPanel
		Insert into pControlPanel (ControlPanelID,ControlPanelName,ControlPanelDescription,ControlPanelOrder,ControlPanelTableName,ControlPanelSchema,
				 ControlPanelSearchSchema, ControlPanelEditSchema, ControlPanelUrl, ControlPanelTypeID) values
		(@ControlPanelID,'Machinery','Machinery',@ControlPanelOrder,'pNBOLMachinery','Control_NBOL_Machinery_Default.xml',
				'Control_NBOL_Machinery_Search.xml', 'Control_NBOL_Machinery_Edit_Default.xml', 'Control_NBOL_Machinery_List.aspx?CPID=' + convert(varchar(12),@ControlPanelID), '09773e42-5ab8-e011-9f63-544c92f24f0d')
	end	
	
	
	if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = UPPER('Macro Library'))
	begin
		select @ControlPanelID = COALESCE(MAX(ControlPanelID),0) + 1, @ControlPanelOrder = COALESCE(MAX(ControlPanelOrder),0) + 1  From pControlPanel
		Insert into pControlPanel (ControlPanelID,ControlPanelName,ControlPanelDescription,ControlPanelOrder,ControlPanelTableName,ControlPanelSchema,
				 ControlPanelSearchSchema, ControlPanelEditSchema, ControlPanelUrl, ControlPanelTypeID) values
		(@ControlPanelID,'Macro Library','Macro Library',@ControlPanelOrder,'pNBOLMacro','Control_NBOL_Macro_Default.xml',
				'Control_NBOL_Macro_Search.xml', 'Control_NBOL_Macro_Edit_Default.xml', 'Control_NBOL_Macro_List.aspx?CPID=' + convert(varchar(12),@ControlPanelID), '09773e42-5ab8-e011-9f63-544c92f24f0d')
	end	


	if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = UPPER('Template Library'))
	begin
		select @ControlPanelID = COALESCE(MAX(ControlPanelID),0) + 1, @ControlPanelOrder = COALESCE(MAX(ControlPanelOrder),0) + 1  From pControlPanel
		Insert into pControlPanel (ControlPanelID,ControlPanelName,ControlPanelDescription,ControlPanelOrder,ControlPanelTableName,ControlPanelSchema,
				 ControlPanelSearchSchema, ControlPanelEditSchema, ControlPanelUrl, ControlPanelTypeID) values
		(@ControlPanelID,'Template Library','Template Library',@ControlPanelOrder,'pNBOLTemplate','Control_NBOL_Template_Default.xml',
				'Control_NBOL_Template_Search.xml', 'Control_NBOL_Template_Default.xml', 'Control_NBOL_Template_List.aspx?CPID=' + convert(varchar(12),@ControlPanelID), '09773e42-5ab8-e011-9f63-544c92f24f0d')
	end		
	
end
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03551', GetDate())
GO