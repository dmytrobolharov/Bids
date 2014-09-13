IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_clear_all.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) 
	VALUES ('btn_clear_all.gif', 'clear all', 'icon_minus.gif')
END
GO

IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_clear_selected.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) 
	VALUES ('btn_clear_selected.gif', 'clear selected', 'icon_minus.gif')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08713', GetDate())
GO
