IF NOT EXISTS (SELECT * FROM sSystemButtons WHERE DesignString = 'btn_add_multiple_styles.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonIcon, DesignString, en_US)
	VALUES ('icon_add1.gif', 'btn_add_multiple_styles.gif', 'new style(s)')
END

IF NOT EXISTS (SELECT * FROM sSystemButtons WHERE DesignString = 'btn_create_multiple_styles.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonIcon, DesignString, en_US)
	VALUES ('icon_new.gif', 'btn_create_multiple_styles.gif', 'create style(s)')
END

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04403', GetDate())
GO
