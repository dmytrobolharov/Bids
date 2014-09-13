if NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_calendar_add.gif')
begin
	INSERT INTO sSystemButtons(ButtonIcon, DesignString, en_US)
	VALUES ('icon_add.gif', 'btn_calendar_add.gif', 'Add Calendar')
end
GO

if NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_TAcalendar_delete.gif')
begin
	INSERT INTO sSystemButtons(ButtonIcon, DesignString, en_US)
	VALUES ('Icon_minus.gif', 'btn_TAcalendar_delete.gif', 'Remove Calendar')
end
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08481', GetDate())
GO
