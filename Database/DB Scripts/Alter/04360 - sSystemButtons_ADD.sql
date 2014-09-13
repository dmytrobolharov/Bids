if NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'quick_quote.gif')
begin
	INSERT INTO sSystemButtons(ButtonIcon, DesignString, en_US)
	VALUES ('Icon_new.gif', 'quick_quote.gif', 'Quick Quote')
end

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04360', GetDate())
GO
