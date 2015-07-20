if NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_quote_bom_update.gif')
begin
	INSERT INTO sSystemButtons(ButtonIcon, DesignString, en_US)
	VALUES ('icon_refresh.gif', 'btn_quote_bom_update.gif', 'Update')
end
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04940', GetDate())
GO