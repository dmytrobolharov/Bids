IF NOT EXISTS (SELECT * FROM sDeskTop WHERE DeskName = N'Profile')
BEGIN
	INSERT sDeskTop (DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2,
	DeskUrl, DeskMenu, DeskMain, DeskSort,	DeskActive, DeskTopRepId, DeskFolderID, DESKBUTTONNAME) 
	VALUES (60, N'Profile', N'User Profile Folder', N'Team16.gif', N'Profile', NULL, 
	N'parent.dbody.location = ''../Desk/Desk_Folder.aspx?DTID=60&TID=##TEAMID##'';', N'../Control/Control_UserProfileMenu.aspx', N'../Control/Control_UserProfile_Profile.aspx?', N'60', 1, N'd318f46b-243b-4a17-bc14-93cc5e99c945', 60, N'btn_Desk_UserProfile.gif')	
END

IF NOT EXISTS (SELECT * FROM sSystemButtons WHERE ButtonType = N'TopMenu' AND DesignString = N'btn_Desk_UserProfile.gif')
BEGIN
	INSERT sSystemButtons(ButtonIcon, ButtonType, DesignString, en_US)
	VALUES ('Team16.gif', 'TopMenu', 'btn_Desk_UserProfile.gif', 'User Profile')
END

UPDATE sDeskTop SET DeskActive = 1
WHERE DeskName IN ('Control', 'Administrator')

UPDATE sDeskTop SET DeskName = 'Admin' WHERE DeskName = 'Administrator'

GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03277'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03277', GetDate())

END
GO 