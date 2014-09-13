IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_configure.gif')
BEGIN
	INSERT INTO sSystemButtons(ButtonIcon, DesignString, en_US)
	VALUES ('icon_options.gif', 'btn_configure.gif', 'configure')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06147', GetDate())
GO
