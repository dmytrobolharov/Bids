DECLARE @CalendarFolderID INT = 23

DELETE FROM sDeskTop WHERE DeskFolderID = @CalendarFolderID

DELETE FROM cDesktopFolder WHERE DeskFolderId = @CalendarFolderID

DELETE sPermissionWorkflow 
FROM sPermissionWorkflow
INNER JOIN sPermissionProductType ON sPermissionProductType.PermissionProductTypeId = sPermissionWorkflow.PermissionProductTypeId
INNER JOIN sPermissionFolder ON sPermissionFolder.PermissionFolderId = sPermissionProductType.PermissionFolderId
WHERE sPermissionFolder.PermissionFolderTypeId = @CalendarFolderID

DELETE sPermissionProductType
FROM sPermissionProductType
INNER JOIN sPermissionFolder ON sPermissionFolder.PermissionFolderId = sPermissionProductType.PermissionFolderId
WHERE sPermissionFolder.PermissionFolderTypeId = @CalendarFolderID

DELETE sPermissionFolder
FROM sPermissionFolder
WHERE PermissionFolderTypeId = @CalendarFolderID

DELETE FROM sPermissionProductTypeMap
WHERE PermissionFolderTypeId = @CalendarFolderID

DELETE FROM sPermissionFolderType 
WHERE PermissionFolderTypeId = @CalendarFolderID

-- delete dashboard record (report contains links to the Calendar folder)
DELETE rDashFolderItem 
WHERE DashFolderItemServerReportName = 'Dash_CalendarMilestoneSummary'


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10294', GetUTCDate())
GO
