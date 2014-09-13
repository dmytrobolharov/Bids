if NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_markup.gif')
begin
	INSERT INTO sSystemButtons(ButtonIcon, DesignString, en_US)
	VALUES ('icon_edit.gif', 'btn_markup.gif', 'markup')
end

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03926', GetDate())
GO