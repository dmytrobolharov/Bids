IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_sync_status.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) 
	VALUES ('btn_sync_status.gif', 'sync status', 'icon_refresh.gif')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07986', GetDate())
GO
