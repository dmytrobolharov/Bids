IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_send_to.gif')
BEGIN
	INSERT INTO sSystemButtons(ButtonIcon, DesignString, en_US)
	VALUES ('icon_mailsent.gif', 'btn_send_to.gif', 'Send To')
END
GO

IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_clear_sel.gif')
BEGIN
	INSERT INTO sSystemButtons(ButtonIcon, DesignString, en_US)
	VALUES ('Icon_minus.gif', 'btn_clear_sel.gif', 'Clear Selection')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03713', GetDate())
GO