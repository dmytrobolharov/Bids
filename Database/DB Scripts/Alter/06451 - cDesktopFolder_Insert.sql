IF NOT EXISTS (SELECT * FROM cDesktopFolder WHERE DeskFolderId = 23)
BEGIN
	INSERT INTO cDesktopFolder (DeskFolderId, DeskFolderName, DeskFolderUrl, DeskSubFolder, DeskGroupFolderUrl)
	VALUES ('23', 'Calendar Folder', 'Control_User_CalendarFolder.aspx', 0, 'Control_Group_CalendarFolder.aspx')
END	

UPDATE sDeskTop SET DeskFolderID = 23 WHERE DeskName = 'Calendar'

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06451', GetDate())
GO
