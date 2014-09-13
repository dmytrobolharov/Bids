IF NOT EXISTS (SELECT * FROM sDeskTop WHERE DeskName = N'Silhouette')
BEGIN
	INSERT sDeskTop (DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2,
	DeskUrl, DeskMenu, DeskMain, DeskSort,	DeskActive, DeskFolderID, DESKBUTTONNAME, MenuWidth) 
	VALUES (82, N'Silhouette', N'Silhouette Folder', N'icon_body.gif', N'Silhouette', 'Folder', 
	N'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=82&TID=##TEAMID##'';',
	N'../Style/Style_List_Menu.aspx?Silho=1', N'../Style/Style_List_Search.aspx?TB=S&Silho=1', 
	N'22', 1, 21, N'btn_Desk_Silhouette.gif', 200)	
END

IF NOT EXISTS (SELECT * FROM sSystemButtons WHERE ButtonType = N'TopMenu' AND DesignString = N'btn_Desk_Silhouette.gif')
BEGIN
	INSERT sSystemButtons(ButtonIcon, ButtonType, DesignString, en_US)
	VALUES ('icon_body.gif', 'TopMenu', 'btn_Desk_Silhouette.gif', 'Silhouette')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05828', GetDate())
GO
