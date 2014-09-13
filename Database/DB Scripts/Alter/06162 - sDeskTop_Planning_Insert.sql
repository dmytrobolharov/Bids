IF NOT EXISTS (SELECT * FROM sSystemButtons WHERE ButtonType = N'TopMenu' AND DesignString = N'btn_Desk_Planning.gif')
BEGIN
	INSERT sSystemButtons(ButtonIcon, ButtonType, DesignString, en_US)
	VALUES ('icon_image_catalog.gif', 'TopMenu', 'btn_Desk_Planning.gif', 'Planning')
END

IF NOT EXISTS (SELECT * FROM sDeskTop WHERE DeskName = N'Planning')
BEGIN
	INSERT sDeskTop (DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2,
	DeskUrl, DeskMenu, DeskMain, DeskSort,	DeskActive, DeskFolderID, DESKBUTTONNAME, MenuWidth) 
	VALUES (83, N'Planning', N'Planning Folder', N'icon_image_catalog.gif', N'Planning', 'Folder', 
	N'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=83&TID=##TEAMID##'';',
	N'../Planning/Planning_Menu.aspx', N'../Planning/Planning_Grid.aspx?', 
	N'11', 1, 21, N'btn_Desk_Planning.gif', 200)	
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06162', GetDate())
GO
