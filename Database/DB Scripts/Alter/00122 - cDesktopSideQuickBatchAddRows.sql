
IF  NOT EXISTS (SELECT * FROM dbo.cDesktopFolder WHERE DeskFolderName = 'QuickBatchReplace Folder' )

BEGIN	
INSERT INTO dbo.cDesktopFolder VALUES(15,'QuickBatchReplace Folder','Control_User_QuickBatchReplaceFolder.aspx',0,'Control_Group_QuickBatchReplaceFolder.aspx')
END
GO

IF  NOT EXISTS (SELECT * FROM dbo.cDeskSide WHERE DeskSideName = 'QuickBatchReplace Folder' )

BEGIN	
INSERT INTO dbo.cDeskSide (DeskFolderId, DeskSideName, DeskSideDescription, DeskSideWindow, DeskSideURL, DeskSideIcon, DeskSideSort, DeskSideActive ) VALUES (15,'QuickBatchReplace Folder',null,'QuickBatchReplaceFolder','../QuickBatchReplace/QuickBatchReplace_Folder.aspx','../System/Icons/icon_folder.gif','009',1)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '3.0.0000', '122', GetDate())
GO