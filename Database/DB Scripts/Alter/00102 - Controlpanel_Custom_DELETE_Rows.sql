DELETE FROM pControlPanel
WHERE ControlPanelName like 'Custom___'
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '102', GetDate())
GO