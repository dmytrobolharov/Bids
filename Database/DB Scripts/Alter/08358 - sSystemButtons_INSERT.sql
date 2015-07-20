IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_bom_manager.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) 
	VALUES ('btn_bom_manager.gif', 'bom manager', 'icon_options.gif')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08358', GetDate())
GO