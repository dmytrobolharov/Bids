INSERT INTO sSystemButtons (ButtonIcon, DesignString, en_US)
	VALUES ('Icon_save.gif', 'btn_make_measurement.gif', 'make measurement')
	
	GO
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05995', GetDate())
GO
