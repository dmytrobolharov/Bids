IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_commit.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_commit.gif', 'commit', 'icon_next.gif')
END

IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_copy_quote.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_copy_quote.gif', 'copy quote', 'icon_globe.gif')
END

IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_add_option.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_add_option.gif', 'add option', 'icon_add.gif')
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06740', GetDate())
GO
