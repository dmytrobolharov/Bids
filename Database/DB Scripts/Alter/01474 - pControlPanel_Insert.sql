begin
	if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'Body Workflow')
	begin
		Insert into pControlPanel (ControlPanelID,ControlPanelName,ControlPanelDescription,ControlPanelOrder,ControlPanelTableName,ControlPanelSchema,ControlPanelTypeID,ControlPanelUrl) 
		SELECT COALESCE(MAX(ControlPanelID),0) + 1,'Body Workflow','Body Workflow',COALESCE(MAX(ControlPanelOrder),0) + 1,'pWorkflowTemplate','Control_Workflow_Default.xml','0280d7a7-5c44-e011-b0b2-001e4fc593fc','Control_Workflow_List.aspx?ISBDY=1&CPID=' + convert(varchar(12),COALESCE(MAX(ControlPanelID),0) + 1)
		From pControlPanel
	end
end
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '01474', GetDate())
GO