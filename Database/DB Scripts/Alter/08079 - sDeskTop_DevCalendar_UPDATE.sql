update sSystemButtons set en_US='Dev Calendar' Where DesignString='btn_Desk_TimeAction.gif'
update sDeskTop set DeskName=N'Development Calendar', DeskDescription=N'Development Calendar', DeskLabel1=N'Development Calendar', DeskIcon='icon_calendar.gif' where DeskTopID=84

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08079', GetDate())
GO