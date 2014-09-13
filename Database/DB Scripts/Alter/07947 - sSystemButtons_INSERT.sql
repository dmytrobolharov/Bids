IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_mark_as_read.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_mark_as_read.gif', 'mark as read', 'icon_ok.gif')
END
IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_mark_as_new.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_mark_as_new.gif', 'mark as new', 'Icon_file.gif')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07947', GetDate())
GO
