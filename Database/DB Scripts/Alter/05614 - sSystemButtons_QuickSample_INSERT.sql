IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString='btn_sample_quickpalette.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonIcon, DesignString, en_US) VALUES ('icon_new.gif', 'btn_sample_quickpalette.gif', 'Quick Sample')
END
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05614', GetDate())
GO