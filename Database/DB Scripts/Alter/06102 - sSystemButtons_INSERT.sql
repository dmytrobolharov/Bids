IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_seasonal_color.gif')
BEGIN
	INSERT INTO sSystemButtons(ButtonIcon, DesignString, en_US)
	VALUES ('Icon_season.gif', 'btn_seasonal_color.gif', 'seasonal color')
END

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06102', GetDate())
GO
