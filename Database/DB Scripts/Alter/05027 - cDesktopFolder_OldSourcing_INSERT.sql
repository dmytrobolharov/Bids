IF NOT EXISTS( SELECT * FROM  cDesktopFolder WHERE DeskFolderName = 'Old Sourcing' )
BEGIN
Declare @DeskFolderId int
SET @DeskFolderID = 20
	INSERT INTO cDesktopFolder
			( DeskFolderId ,
			  DeskFolderName ,
			  DeskFolderUrl ,
			  DeskSubFolder ,
			  DeskGroupFolderUrl
			)
	VALUES  ( @DeskFolderId , -- DeskFolderId - int
			  'Old Sourcing', -- DeskFolderName - nvarchar(100)
			  'Control_User_OldSourcing.aspx' , -- DeskFolderUrl - varchar(100)
			  0 , -- DeskSubFolder - int
			  'Control_Group_OldSourcing.aspx'  -- DeskGroupFolderUrl - varchar(100)
			)
	        
END 
GO        

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05027', GetDate())
GO
