begin
	Declare @ControlPanelID int
	Declare @ControlPanelOrder int
	
	if not exists (select * from pControlPanel WHERE UPPER(ControlPanelName) = 'EXCHANGE RATE')
	begin
		select @ControlPanelID = COALESCE(MAX(ControlPanelID),0) + 1, @ControlPanelOrder = COALESCE(MAX(ControlPanelOrder),0) + 1  From pControlPanel
		Insert into pControlPanel (ControlPanelID,ControlPanelName,ControlPanelDescription,ControlPanelOrder,ControlPanelTableName,ControlPanelSchema,
				 ControlPanelSearchSchema, ControlPanelUrl, ControlPanelEditSchema) values
		(@ControlPanelID,'Exchange Rate','Exchange Rate',@ControlPanelOrder,'sExchangeRate','Control_Custom_ExchangeRate_Default.xml',
				'Control_Custom_ExchangeRate_Search.xml', 'Control_ExchangeRate_List.aspx?CPID=' + convert(varchar(12),@ControlPanelID), 'Control_Custom_ExchangeRateEdit_Default.xml')
	end	
	
end
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04009', GetDate())


GO