UPDATE sPermissionFolderType
SET Sort = PermissionFolderTypeId
WHERE Sort IS NULL
GO

UPDATE sPermissionFolderType 
SET Sort = Sort + 1 
WHERE Sort > 1 AND Sort = PermissionFolderTypeID
GO

UPDATE sPermissionFolderType 
SET Sort = 2 
WHERE PermissionFolderTypeID = 26
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09369', GetDate())
GO