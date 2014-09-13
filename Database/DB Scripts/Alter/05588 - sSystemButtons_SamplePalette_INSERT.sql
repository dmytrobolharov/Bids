IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString='btn_sample_palette.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonIcon, DesignString, en_US) VALUES ('icon_new.gif', 'btn_sample_palette.gif', 'Sample Palette')
END

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05588', GetDate())
GO
