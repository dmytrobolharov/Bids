
IF NOT EXISTS( SELECT * FROM  cDesktopFolder WHERE DeskFolderId = 18 )
BEGIN
	INSERT INTO dbo.cDesktopFolder
			( DeskFolderId ,
			  DeskFolderName ,
			  DeskFolderUrl ,
			  DeskSubFolder ,
			  DeskGroupFolderUrl
			)
	VALUES  ( 18 , -- DeskFolderId - int
			  'BatchQ Folder', -- DeskFolderName - nvarchar(100)
			  'Control_User_BatchQ.aspx' , -- DeskFolderUrl - varchar(100)
			  0 , -- DeskSubFolder - int
			  'Control_Group_BatchQ.aspx'  -- DeskGroupFolderUrl - varchar(100)
			)
	        
END 
GO        


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01550'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01550', GetDate())
END	

GO

