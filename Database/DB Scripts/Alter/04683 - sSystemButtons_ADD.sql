if NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_copy_quote.gif')
begin
	INSERT INTO sSystemButtons(ButtonIcon, DesignString, en_US)
	VALUES ('icon_trade.gif', 'btn_copy_quote.gif', 'copy quote')
end

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04683', GetDate())
GO