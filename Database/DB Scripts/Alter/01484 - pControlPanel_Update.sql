update pControlPanel set ControlPanelTypeID = NULL where ControlPanelName = 'Body Workflow'
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '01484', GetDate())
GO