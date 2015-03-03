UPDATE sPermissionProductType SET PermissionProductTypeName = 'Line List Default'	
FROM sPermissionProductType a INNER JOIN sPermissionFolder b 
	ON a.PermissionFolderId = b.PermissionFolderId and b.PermissionFolderTypeId = 3

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '6.0.0001', '09150', GetDate())
GO
