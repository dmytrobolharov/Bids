if NOT EXISTS(SELECT DesignString FROM sSystemButtons WHERE DesignString='btn_link_line_lists.gif')
begin
	INSERT INTO sSystemButtons (ButtonIcon, DesignString, en_US)
	VALUES ('Icon_link.gif', 'btn_link_line_lists.gif', 'Link Line Lists')
end
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05345', GetDate())
GO
