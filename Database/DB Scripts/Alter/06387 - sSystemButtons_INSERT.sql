IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_auto_allocate.gif')
BEGIN
	INSERT INTO sSystemButtons(ButtonIcon, DesignString, en_US)
	VALUES ('icon_materialMulti.gif', 'btn_auto_allocate.gif', 'auto allocate')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06387', GetDate())
GO
