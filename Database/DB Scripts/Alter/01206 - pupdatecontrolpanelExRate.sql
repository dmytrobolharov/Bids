update pControlPanel set ControlPanelEditSchema='Control_Custom_ExchangeRateEdit_Default.xml' where 
ControlPanelName='Exchange Rate' and ControlPanelID=325

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01206', GetDate())
GO