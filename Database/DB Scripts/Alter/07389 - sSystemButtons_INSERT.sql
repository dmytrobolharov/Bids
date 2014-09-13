IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_add_from_BF.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_add_from_BF.gif', 'add body', 'icon_add.gif')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07389', GetDate())
GO
