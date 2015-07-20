UPDATE pControlPanel SET ControlPanelUrl = REPLACE (ControlPanelUrl, '380', CAST(ControlPanelID AS NVARCHAR(5)))WHERE ControlPanelName = 'Task'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07110', GetDate())
GO
