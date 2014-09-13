IF NOT EXISTS (SELECT * FROM sSystemButtons WHERE ButtonType = N'TopMenu' AND DesignString = N'btn_Desk_TimeAction.gif')
BEGIN
	INSERT sSystemButtons(ButtonIcon, ButtonType, DesignString, en_US)
	VALUES ('icon_colorway.gif', 'TopMenu', 'btn_Desk_TimeAction.gif', 'Time and Action')
END

IF NOT EXISTS (SELECT * FROM sDeskTop WHERE DeskName = N'Time and Action')
BEGIN
	INSERT sDeskTop (DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2,
	DeskUrl, DeskMenu, DeskMain, DeskSort,	DeskActive, DeskFolderID, DESKBUTTONNAME, MenuWidth) 
	VALUES (84, N'Time and Action', N'Time and Action', N'icon_image_catalog.gif', N'Time and Action', 'Folder', 
	N'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=84&TID=##TEAMID##'';',
	N'../TimeAction/TimeAction_Menu.aspx', N'../TimeAction/TimeAction_Grid.aspx?', 
	N'12', 1, 23, N'btn_Desk_TimeAction.gif', 200)	
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07709', GetDate())
GO
