IF NOT EXISTS (SELECT * FROM sSystemButtons WHERE DesignString = 'btn_bomcolorway_clear.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonIcon, DesignString, en_US)
	VALUES ('Icon_minus.gif', 'btn_bomcolorway_clear.gif', 'clear')
END

GO

IF NOT EXISTS (SELECT * FROM sSystemButtons WHERE DesignString = 'btn_addpalette.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonIcon, DesignString, en_US)
	VALUES ('icon_colorway.gif', 'btn_addpalette.gif', 'add palette')
END

GO

IF NOT EXISTS (SELECT * FROM sSystemButtons WHERE DesignString = 'btn_bomcolorway_make.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonIcon, DesignString, en_US)
	VALUES ('Icon_file.gif', 'btn_bomcolorway_make.gif', 'make colorway')
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0.0000', '05650', GetDate())
GO
