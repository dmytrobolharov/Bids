UPDATE pControlPanel SET ControlPanelName = 'Task Library', ControlPanelDescription = 'Task Library'
WHERE ControlPanelName = 'Task'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07395', GetDate())
GO
