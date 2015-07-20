if NOT EXISTS (SELECT * FROM sSystemButtons WHERE DesignString = 'btn_add_option.gif')
begin
	INSERT INTO sSystemButtons(ButtonIcon, DesignString, en_US)
	VALUES ('icon_add.gif', 'btn_add_option.gif', 'add option')
end
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04390', GetDate())
GO