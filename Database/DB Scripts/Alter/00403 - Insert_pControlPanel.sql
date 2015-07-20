begin
   
	if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'CONSTRUCTION DETAILS')
	
	begin
		
		Insert into pControlPanel (ControlPanelID,ControlPanelName,ControlPanelDescription,ControlPanelOrder,ControlPanelTableName,ControlPanelUrl) 
		SELECT COALESCE(MAX(ControlPanelID),0) + 1,'Construction Details','Construction Details',COALESCE(MAX(ControlPanelOrder),0) + 1,'pConstructTree','Control_ConstructionDetails_List.aspx?CPID=' + convert(varchar(12),COALESCE(MAX(ControlPanelID),0) + 1)
		From pControlPanel
	end

end