delete
from pControlPanel
where ControlPanelName = 'Measurements Size Class'
 or   ControlPanelName = 'Measurements Size Range'
 or   ControlPanelName = 'Measurements'
 go

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02488'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02488', GetDate())

END
GO