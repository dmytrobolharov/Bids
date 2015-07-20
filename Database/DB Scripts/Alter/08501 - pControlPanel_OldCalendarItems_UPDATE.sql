UPDATE pControlPanel SET ControlPanelTypeID = NULL WHERE ControlPanelName IN ('Milestone Templates', 'Calendar Event', 'Calendar Event Type', 'Task Library', 'Milestone Library')
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08501', GetDate())
GO
