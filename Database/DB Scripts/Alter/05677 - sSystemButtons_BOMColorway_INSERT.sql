IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString='btn_sort_colorways.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonIcon, DesignString, en_US)
	VALUES ('Icon_sort.gif', 'btn_sort_colorways.gif', 'sort color')
END

IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString='btn_swap_colorways.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonIcon, DesignString, en_US)
	VALUES ('swap_color.png', 'btn_swap_colorways.gif', 'swap colorway')
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0.0000', '05677', GetDate())
GO
