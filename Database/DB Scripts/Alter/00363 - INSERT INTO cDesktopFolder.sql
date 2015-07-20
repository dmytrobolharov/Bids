INSERT INTO cDesktopFolder
                      (DeskFolderId, DeskFolderName, DeskFolderUrl, DeskSubFolder, DeskGroupFolderUrl)
VALUES     (17, 'BI Folder', 'Control_User_BI.aspx', 0, 'Control_Group_BI.aspx')

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '363', GetDate())

GO 