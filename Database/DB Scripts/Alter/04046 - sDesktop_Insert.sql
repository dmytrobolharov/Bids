

IF NOT EXISTS (SELECT * FROM sDeskTop WHERE DeskName = N'Sourcing')
BEGIN
	INSERT sDeskTop (DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2,
	DeskUrl, DeskMenu, DeskMain, DeskSort,	DeskActive, DeskFolderID, DESKBUTTONNAME) 
	VALUES (80, N'Sourcing', N'Sourcing Folder', N'icon_folder_globe.gif', N'Sourcing', 'Folder', 
	N'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=80&TID=##TEAMID##'';',
	N'../Sourcing/Sourcing_Page_Menu.aspx', N'../Sourcing/Sourcing_Page_Folder.aspx?', 
	N'80', 1, 19, N'btn_Desk_Sourcing.gif')	
END

IF NOT EXISTS (SELECT * FROM sSystemButtons WHERE ButtonType = N'TopMenu' AND DesignString = N'btn_Desk_Sourcing.gif')
BEGIN
	INSERT sSystemButtons(ButtonIcon, ButtonType, DesignString, en_US)
	VALUES ('icon_folder_globe.gif', 'TopMenu', 'btn_Desk_Sourcing.gif', 'Sourcing')
END

UPDATE sDeskTop SET DeskActive = 1
WHERE DeskName IN ('Control', 'Administrator')

UPDATE sDeskTop SET DeskName = 'Admin' WHERE DeskName = 'Administrator'

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04046', GetDate())

GO