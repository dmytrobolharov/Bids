UPDATE pControlPanel SET ControlPanelName = 'BOL ' + ControlPanelName, ControlPanelDescription = 'BOL ' + ControlPanelDescription WHERE ControlPanelName = 'Operation Type'
UPDATE pControlPanel SET ControlPanelName = 'BOL ' + ControlPanelName, ControlPanelDescription = 'BOL ' + ControlPanelDescription WHERE ControlPanelName = 'Operation Library'
UPDATE pControlPanel SET ControlPanelName = 'BOL ' + ControlPanelName, ControlPanelDescription = 'BOL ' + ControlPanelDescription WHERE ControlPanelName = 'Machine Class'
UPDATE pControlPanel SET ControlPanelName = 'BOL ' + ControlPanelName, ControlPanelDescription = 'BOL ' + ControlPanelDescription WHERE ControlPanelName = 'Machinery'
UPDATE pControlPanel SET ControlPanelName = 'BOL ' + ControlPanelName, ControlPanelDescription = 'BOL ' + ControlPanelDescription WHERE ControlPanelName = 'Macro Library'
UPDATE pControlPanel SET ControlPanelName = 'BOL ' + ControlPanelName, ControlPanelDescription = 'BOL ' + ControlPanelDescription WHERE ControlPanelName = 'Template Library'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04590', GetDate())
GO
