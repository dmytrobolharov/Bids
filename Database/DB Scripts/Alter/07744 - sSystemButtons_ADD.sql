IF NOT EXISTS (SELECT * FROM sSystemButtons WHERE DesignString = N'btn_attachfileMulti.gif')
BEGIN
	INSERT sSystemButtons(ButtonIcon,  DesignString, en_US)
	VALUES ('icon_add.gif',  'btn_attachfileMulti.gif', 'Add Multiple Files')
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07744', GetDate())
GO
