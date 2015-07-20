IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_sync_with_linelist.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) 
	VALUES ('btn_sync_with_linelist.gif', 'sync with line list', 'icon_refresh.gif')
END
GO

IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_sync_with_planning.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) 
	VALUES ('btn_sync_with_planning.gif', 'sync with planning', 'icon_refresh.gif')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08465', GetDate())
GO
