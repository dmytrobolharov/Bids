DELETE FROM pControlPanel WHERE ControlPanelName = 'Factory Rates'

GO 

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01808'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01808', GetDate())
END

GO
