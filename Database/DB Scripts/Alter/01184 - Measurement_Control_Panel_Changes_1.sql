UPDATE pControlPanel
   SET ControlPanelName =         'Measurements Size Class'
      ,ControlPanelDescription =  'Measurements Size Class'
Where ControlPanelId = 17
AND ControlPanelName = 'Size Class'
go


UPDATE  pControlPanel
   SET  ControlPanelName =         'Measurements Size Range'
       ,ControlPanelDescription =  'Measurements Size Range'
Where ControlPanelId = 20
AND ControlPanelName = 'Size Range'
go


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01184', GetDate())
GO