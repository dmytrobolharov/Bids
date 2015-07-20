IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_clear_image.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) 
	VALUES ('btn_clear_image.gif', 'clear image', 'icon_minus.gif')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '09029', GetDate())
GO