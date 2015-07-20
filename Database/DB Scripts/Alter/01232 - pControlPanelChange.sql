update pControlPanel set ControlPanelDescription = 'Process Details' where ControlPanelDescription = 'Construction Details'
Go

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01232', GetDate())
GO