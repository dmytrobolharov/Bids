IF NOT EXISTS(SELECT DesignString FROM sSystemButtons WHERE DesignString='btn_select_materials.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonIcon, DesignString, en_US)
	VALUES('icon_puzzle.gif','btn_select_materials.gif', 'select materials')
END


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04700', GetDate())
GO
