IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_partner_add.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonIcon, DesignString, en_US)
	VALUES ('icon_add.gif', 'btn_partner_add.gif', 'add partner')
END

IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_partner_remove.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonIcon, DesignString, en_US)
	VALUES ('icon_minus.gif', 'btn_partner_remove.gif', 'remove partner')
END

IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_template_remove_item.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonIcon, DesignString, en_US)
	VALUES ('icon_minus.gif', 'btn_template_remove_item.gif', 'remove template item')
END

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04140', GetDate())
GO
