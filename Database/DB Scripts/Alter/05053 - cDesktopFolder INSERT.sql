update cDesktopFolder set DeskFolderName='Resource' where DeskFolderName='Compliance Folder'

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05053', GetDate())
GO