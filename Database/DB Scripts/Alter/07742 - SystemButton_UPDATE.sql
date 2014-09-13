IF  EXISTS (SELECT * FROM sSystemButtons WHERE ButtonType = N'TopMenu' AND DesignString = N'btn_Desk_TimeAction.gif')
BEGIN
update sSystemButtons set ButtonIcon = 'icon_calendar.gif' WHERE ButtonType = N'TopMenu' AND DesignString = N'btn_Desk_TimeAction.gif'
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07742', GetDate())
GO