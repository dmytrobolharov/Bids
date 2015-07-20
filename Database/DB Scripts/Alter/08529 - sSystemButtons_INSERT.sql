IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_addpage.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) 
	VALUES ('btn_addpage.gif', 'add page', 'icon_add.gif')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08529', GetDate())
GO
