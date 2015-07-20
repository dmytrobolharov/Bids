 Update pControlPanel set ControlPanelName = 'Gender', ControlPanelDescription = 'Gender' Where ControlPanelName = 'Garment Treatment'

GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01786'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '4.1.0000', '01786', GetDate())
	END
GO
 