
if NOT EXISTS (SELECT * FROM sSystemButtons WHERE DesignString = 'btn_add_new_image.gif')
begin
	INSERT INTO sSystemButtons(ButtonIcon, DesignString, en_US)
	VALUES ('icon_new.gif', 'btn_add_new_image.gif', 'new image')
end
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04606', GetDate())
GO