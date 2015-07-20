if NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_quotation_palette.gif')
begin
	INSERT INTO sSystemButtons(ButtonIcon, DesignString, en_US)
	VALUES ('Icon_new.gif', 'btn_quotation_palette.gif', 'Quotation Palette')
end

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04299', GetDate())
GO
