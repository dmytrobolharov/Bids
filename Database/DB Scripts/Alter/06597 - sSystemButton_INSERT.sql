IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_DimView.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_DimView.gif', 'view dimensions', 'icon_new.gif')
END
GO

IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_hidegrid.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_hidegrid.gif', 'hide grid', 'Icon_autoFormat.gif')
END
GO

IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_colorway_auto.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_colorway_auto.gif', 'auto color', 'icon_colorway.gif')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06597', GetDate())
GO
