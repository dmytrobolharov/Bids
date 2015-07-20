if NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_update_all.gif')
begin
	INSERT INTO sSystemButtons(ButtonIcon, DesignString, en_US)
	VALUES ('Icon_save.gif', 'btn_update_all.gif', 'Update All')
end

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04280', GetDate())
GO
