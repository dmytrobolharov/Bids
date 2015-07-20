IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_bomcolorway_active_clear.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonIcon, DesignString, en_US)
	VALUES('Icon_minus.gif', 'btn_bomcolorway_active_clear.gif', 'clear active')
END

IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_bomcolorway_replacematerial.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonIcon, DesignString, en_US)
	VALUES('icon_refresh.gif', 'btn_bomcolorway_replacematerial.gif', 'replace material')
END


IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_bomcolorway_replaceinstance.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonIcon, DesignString, en_US)
	VALUES('icon_refresh.gif', 'btn_bomcolorway_replaceinstance.gif', 'replace instance')
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05809', GetDate())
GO
