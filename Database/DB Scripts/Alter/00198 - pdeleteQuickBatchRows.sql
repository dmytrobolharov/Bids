
Delete FROM cDeskGroupFolderAccess WHERE DeskFolderId = (SELECT DeskFolderId FROM cDesktopFolder WHERE DeskFolderName = 'QuickBatchReplace Folder')
Delete FROM  cDeskUserFolderAccess WHERE DeskFolderId = (SELECT DeskFolderId FROM cDesktopFolder WHERE DeskFolderName = 'QuickBatchReplace Folder')

Delete FROM cDesktopFolder WHERE DeskFolderName = 'QuickBatchReplace Folder'
Delete FROM cDeskSide WHERE DeskSideName = 'QuickBatchReplace Folder'

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '3.0.0000', '198', GetDate())
GO