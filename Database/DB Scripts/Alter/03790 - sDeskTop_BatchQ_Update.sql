IF EXISTS (SELECT * FROM cDesktopFolder WHERE DeskFolderId = 18 AND DeskFolderName = 'BatchQ Folder')
BEGIN
	IF NOT EXISTS (SELECT * FROM sDeskTop WHERE DeskFolderID = 18)
	BEGIN
		UPDATE sDeskTop SET DeskFolderID = 18 WHERE DeskName = 'Batch Queue' AND DeskFolderID = 16
	END
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03790', GetDate())
GO
