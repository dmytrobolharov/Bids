IF NOT EXISTS (SELECT * FROM sDeskTop WHERE DeskName = N'Calendar')
BEGIN
	INSERT sDeskTop (DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2,
	DeskUrl, DeskMenu, DeskMain, DeskSort,	DeskActive, DeskFolderID, DESKBUTTONNAME, MenuWidth) 
	VALUES (81, N'Calendar', N'Calendar Folder', N'icon_calendar.gif', N'Calendar', 'Folder', 
	N'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=81&TID=##TEAMID##'';',
	N'../Calendar/Calendar_Page_Menu.aspx', N'../Calendar/Calendar_Page_List_Search.aspx?', 
	N'21', 1, 20, N'btn_Desk_Calendar.gif', 200)	
END

IF NOT EXISTS (SELECT * FROM sSystemButtons WHERE ButtonType = N'TopMenu' AND DesignString = N'btn_Desk_Calendar.gif')
BEGIN
	INSERT sSystemButtons(ButtonIcon, ButtonType, DesignString, en_US)
	VALUES ('icon_calendar.gif', 'TopMenu', 'btn_Desk_Calendar.gif', 'Calendar')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05458', GetDate())
GO
