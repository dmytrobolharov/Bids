UPDATE pControlPanel SET ControlPanelName='Bleaching' WHERE ControlPanelName='Bleach'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03685', GetDate())
GO