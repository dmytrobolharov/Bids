if NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_save_search.gif')
begin
	INSERT INTO sSystemButtons(ButtonIcon, DesignString, en_US)
	VALUES ('Icon_save.gif', 'btn_save_search.gif', 'save search')
end

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03941', GetDate())
GO
