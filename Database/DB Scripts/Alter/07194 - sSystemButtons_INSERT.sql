IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_start.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_start.gif', 'start', 'icon_next.gif')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07194', GetDate())
GO
