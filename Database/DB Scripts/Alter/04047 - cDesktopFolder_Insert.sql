
IF NOT EXISTS( SELECT * FROM  cDesktopFolder WHERE DeskFolderName = 'Sourcing Folder' )
BEGIN
Declare @DeskFolderId int
set @DeskFolderId = 19
--select @DeskFolderId = COALESCE(MAX(DeskFolderId),0) + 1 From cDesktopFolder
	INSERT INTO cDesktopFolder
			( DeskFolderId ,
			  DeskFolderName ,
			  DeskFolderUrl ,
			  DeskSubFolder ,
			  DeskGroupFolderUrl
			)
	VALUES  ( @DeskFolderId , -- DeskFolderId - int
			  'Sourcing Folder', -- DeskFolderName - nvarchar(100)
			  'Control_User_Sourcing.aspx' , -- DeskFolderUrl - varchar(100)
			  0 , -- DeskSubFolder - int
			  'Control_Group_Sourcing.aspx'  -- DeskGroupFolderUrl - varchar(100)
			)
	        
END 
GO        

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04047', GetDate())

GO

