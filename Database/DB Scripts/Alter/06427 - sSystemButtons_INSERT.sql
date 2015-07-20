IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_planning_import.gif')
BEGIN
	INSERT INTO sSystemButtons(ButtonIcon, DesignString, en_US)
	VALUES ('icon_refresh.gif', 'btn_planning_import.gif', 'Import')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06427', GetDate())
GO
