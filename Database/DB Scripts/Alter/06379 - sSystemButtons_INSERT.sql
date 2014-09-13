IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_set_active.gif')
BEGIN
	INSERT INTO sSystemButtons(ButtonIcon, DesignString, en_US)
	VALUES ('icon_ok.gif', 'btn_set_active.gif', 'set active')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06379', GetDate())
GO
