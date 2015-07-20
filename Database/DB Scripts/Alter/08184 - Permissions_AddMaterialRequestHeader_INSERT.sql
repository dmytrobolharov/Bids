DECLARE @MaterialRequestFolderID INT = 24
DECLARE @WorkflowID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000001'
DECLARE @WorkflowName NVARCHAR(200) = 'Trade Partner Header'

INSERT INTO sPermissionWorkflow (PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, GroupId, WorkflowId,
	PermissionRoleId, PermissionView, PermissionCreate, PermissionRemove, PermissionModify, PermissionDelete, PermissionPrint,
	CUser, CDate, MUser, MDate, PermissionWorkflowName)
SELECT pf.PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, pf.GroupId, @WorkflowID,
	0, 0, 0, 0, 0, 0, 0,
	'System', CURRENT_TIMESTAMP, 'System', CURRENT_TIMESTAMP, @WorkflowName
FROM sPermissionProductType ppt 
INNER JOIN sPermissionFolder pf ON ppt.PermissionFolderId = pf.PermissionFolderId
WHERE pf.PermissionFolderTypeId = @MaterialRequestFolderID
AND NOT EXISTS(SELECT * FROM sPermissionWorkflow WHERE PermissionProductTypeId = ppt.PermissionProductTypeId AND WorkflowId = @WorkflowID)

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08184', GetDate())
GO
