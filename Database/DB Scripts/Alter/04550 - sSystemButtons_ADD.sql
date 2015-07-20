if NOT EXISTS (SELECT * FROM sSystemButtons WHERE DesignString = 'btn_add_existing.gif')
begin
	INSERT INTO sSystemButtons(ButtonIcon, DesignString, en_US)
	VALUES ('icon_add.gif', 'btn_add_existing.gif', 'add Existing')
end
GO

if NOT EXISTS (SELECT * FROM sSystemButtons WHERE DesignString = 'btn_add_new.gif')
begin
	INSERT INTO sSystemButtons(ButtonIcon, DesignString, en_US)
	VALUES ('icon_add.gif', 'btn_add_new.gif', 'add New')
end
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04550', GetDate())
GO