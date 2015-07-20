IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString='btn_quote_editor.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonIcon, DesignString, en_US)
	VALUES ('Icon_edit_file.gif', 'btn_quote_editor.gif', 'Quote Editor')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05692', GetDate())
GO
