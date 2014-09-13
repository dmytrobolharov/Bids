DECLARE @StyleFolderTypeID INT = 2
DECLARE @WorkflowID UNIQUEIDENTIFIER = '70000000-0000-0000-0000-000000000001'
DECLARE @WorkflowName NVARCHAR(200) = 'Style Header'

INSERT INTO sPermissionWorkflow (PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, GroupId, WorkflowId,
 PermissionRoleId, PermissionView, PermissionCreate, PermissionRemove, PermissionModify, PermissionDelete, PermissionPrint,
 CUser, CDate, MUser, MDate, PermissionWorkflowName)
SELECT pf.PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, pf.GroupId, @WorkflowID,
 0, 0, 0, 0, 0, 0, 0,
 'System', CURRENT_TIMESTAMP, 'System', CURRENT_TIMESTAMP, @WorkflowName
FROM sPermissionProductType ppt 
INNER JOIN sPermissionFolder pf ON ppt.PermissionFolderId = pf.PermissionFolderId
WHERE pf.PermissionFolderTypeId = @StyleFolderTypeID
AND NOT EXISTS(SELECT * FROM sPermissionWorkflow WHERE PermissionProductTypeId = ppt.PermissionProductTypeId AND WorkflowId = @WorkflowID)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08944', GetDate())
GO
