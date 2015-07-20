IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_add_relationship.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon) 
	VALUES ('btn_add_relationship.gif', 'add relationship', 'icon_add.gif')
END
GO

IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_remove.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon) 
	VALUES ('btn_remove.gif', 'remove', 'icon_minus.gif')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06556', GetDate())
GO
