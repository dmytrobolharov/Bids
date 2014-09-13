IF NOT EXISTS(SELECT DesignString FROM sSystemButtons WHERE DesignString='btn_select_colors.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonIcon, DesignString, en_US)
	VALUES('icon_colorway.gif','btn_select_colors.gif', 'select colors')
END


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04671', GetDate())
GO
