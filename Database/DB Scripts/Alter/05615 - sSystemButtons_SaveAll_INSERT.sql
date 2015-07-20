IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString='btn_select_all.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonIcon, DesignString, en_US) VALUES ('icon_select.gif', 'btn_select_all.gif', 'Select All')
END

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05615', GetDate())
GO
