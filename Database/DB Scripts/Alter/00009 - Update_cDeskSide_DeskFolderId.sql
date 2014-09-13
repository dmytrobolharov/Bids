UPDATE cDeskSide
   SET DeskFolderId = 14
WHERE  (DeskSideName = 'Body Folder')
GO

INSERT INTO sVersion (AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '2.6.9999', '009', GetDate())

GO