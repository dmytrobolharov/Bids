DECLARE @LinePlanningFolderID INT = 13

DELETE FROM sDeskTop WHERE DeskFolderID = @LinePlanningFolderID

DELETE FROM cDesktopFolder WHERE DeskFolderId = @LinePlanningFolderID

DELETE sPermissionWorkflow 
FROM sPermissionWorkflow
INNER JOIN sPermissionProductType ON sPermissionProductType.PermissionProductTypeId = sPermissionWorkflow.PermissionProductTypeId
INNER JOIN sPermissionFolder ON sPermissionFolder.PermissionFolderId = sPermissionProductType.PermissionFolderId
WHERE sPermissionFolder.PermissionFolderTypeId = @LinePlanningFolderID

DELETE sPermissionProductType
FROM sPermissionProductType
INNER JOIN sPermissionFolder ON sPermissionFolder.PermissionFolderId = sPermissionProductType.PermissionFolderId
WHERE sPermissionFolder.PermissionFolderTypeId = @LinePlanningFolderID

DELETE sPermissionFolder
FROM sPermissionFolder
WHERE PermissionFolderTypeId = @LinePlanningFolderID

DELETE FROM sPermissionProductTypeMap
WHERE PermissionFolderTypeId = @LinePlanningFolderID

DELETE FROM sPermissionFolderType 
WHERE PermissionFolderTypeId = @LinePlanningFolderID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10393', GetUTCDate())
GO
