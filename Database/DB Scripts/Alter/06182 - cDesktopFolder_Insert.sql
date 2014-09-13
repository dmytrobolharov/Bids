IF NOT EXISTS (SELECT * FROM cDesktopFolder WHERE DeskFolderId = 22)
BEGIN
	INSERT INTO cDesktopFolder (DeskFolderId, DeskFolderName, DeskFolderUrl, DeskSubFolder, DeskGroupFolderUrl)
	VALUES ('22', 'Planning', 'Control_User_PlanningFolder.aspx', 0, 'Control_Group_PlanningFolder.aspx')
END	

UPDATE sDeskTop SET DeskFolderID = 22 WHERE DeskName = 'Planning'

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06182', GetDate())
GO
