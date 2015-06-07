DECLARE @BodyFolderID INT = 14

DELETE FROM sDeskTop WHERE DeskFolderID = @BodyFolderID

DELETE FROM cDesktopFolder WHERE DeskFolderId = @BodyFolderID

DELETE sPermissionWorkflow 
FROM sPermissionWorkflow
INNER JOIN sPermissionProductType ON sPermissionProductType.PermissionProductTypeId = sPermissionWorkflow.PermissionProductTypeId
INNER JOIN sPermissionFolder ON sPermissionFolder.PermissionFolderId = sPermissionProductType.PermissionFolderId
WHERE sPermissionFolder.PermissionFolderTypeId = @BodyFolderID

DELETE sPermissionProductType
FROM sPermissionProductType
INNER JOIN sPermissionFolder ON sPermissionFolder.PermissionFolderId = sPermissionProductType.PermissionFolderId
WHERE sPermissionFolder.PermissionFolderTypeId = @BodyFolderID

DELETE sPermissionFolder
FROM sPermissionFolder
WHERE PermissionFolderTypeId = @BodyFolderID

DELETE FROM sPermissionProductTypeMap
WHERE PermissionFolderTypeId = @BodyFolderID

DELETE FROM sPermissionFolderType 
WHERE PermissionFolderTypeId = @BodyFolderID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10397', GetUTCDate())
GO
