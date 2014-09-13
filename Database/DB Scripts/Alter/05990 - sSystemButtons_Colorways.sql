UPDATE sSystemButtons SET en_US = 'sort colorway' WHERE DesignString = 'btn_sort_colorways.gif'
GO

IF NOT EXISTS (SELECT * FROM sSystemButtons WHERE DesignString='btn_remove_colorways.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonIcon, DesignString, en_US)
	VALUES ('icon_minus.gif', 'btn_remove_colorways.gif', 'remove colorway')
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05990', GetDate())
GO
