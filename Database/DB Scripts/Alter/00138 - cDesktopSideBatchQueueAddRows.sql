IF NOT EXISTS (SELECT * FROM dbo.cDesktopFolder WHERE DeskFolderName = 'Batch Queue')

BEGIN	
INSERT INTO dbo.cDesktopFolder VALUES (16, 'Batch Queue', 'Control_User_BatchQueue.aspx', 0, 'Control_Group_BatchQueue.aspx')
END
GO

IF NOT EXISTS (SELECT * FROM dbo.cDeskSide WHERE DeskSideName = 'Batch Queue')

BEGIN	
INSERT INTO dbo.cDeskSide (DeskFolderId, DeskSideName, DeskSideDescription, DeskSideWindow, DeskSideURL, DeskSideIcon, DeskSideSort, DeskSideActive) 
VALUES (16, 'Batch Queue', null, 'BatchQueue', '../BatchQueue/BatchQueue_Folder.aspx', '../System/Icons/icon_folder.gif', '010', 1)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '138', GetDate())
GO
