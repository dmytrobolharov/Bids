UPDATE pControlPanel
   SET ControlPanelName = 'Size Range'
WHERE ControlPanelName = 'Size Range Yunique'
go

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02486'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02486', GetDate())

END
GO