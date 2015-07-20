IF NOT EXISTS( SELECT * FROM  cDesktopFolder WHERE DeskFolderName = 'Partner Folder' )
BEGIN
	INSERT INTO cDesktopFolder
			( DeskFolderId ,
			  DeskFolderName ,
			  DeskFolderUrl ,
			  DeskSubFolder ,
			  DeskGroupFolderUrl
			)
	VALUES  ( 21 , 
			  'Partner Folder', 
			  'Control_User_Partner.aspx' , 
			  0 , 
			  'Control_Group_Partner.aspx'  
			)
	        
END 
GO  



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05245', GetDate())
GO
