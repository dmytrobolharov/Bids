update pControlPanel set ControlPanelName = 'Process Details' where ControlPanelName = 'Construction Details' 
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01165', GetDate())
GO