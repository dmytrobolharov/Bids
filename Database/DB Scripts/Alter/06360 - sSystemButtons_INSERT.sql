IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_auto_generate.gif')
BEGIN
	INSERT INTO sSystemButtons(ButtonIcon, DesignString, en_US)
	VALUES ('icon_materialMulti.gif', 'btn_auto_generate.gif', 'auto generate')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06360', GetDate())
GO
