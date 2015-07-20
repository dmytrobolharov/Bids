if exists (select * from pControlPanel where ControlPanelName = 'Data Dictionary')
begin
	delete from pControlPanel where ControlPanelName = 'Data Dictionary'
end	
GO



	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03377', GetDate())


GO