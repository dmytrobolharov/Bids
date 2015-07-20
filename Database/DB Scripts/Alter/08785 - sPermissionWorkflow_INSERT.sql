DELETE FROM sPermissionWorkflow WHERE workflowid = '00000000-0000-0000-0000-000000000012' AND PermissionProductTypeId IN
(SELECT PermissionProductTypeId FROM sPermissionProductType ppt
INNER JOIN sPermissionFolder pf ON ppt.PermissionFolderId = pf.PermissionFolderId
WHERE pf.PermissionFolderTypeId = 22)
GO

INSERT INTO sPermissionWorkflow ( 
	PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, GroupId, 
	WorkflowId, PermissionRoleId, PermissionView, PermissionCreate,	PermissionRemove, PermissionModify, 
	PermissionDelete, PermissionPrint, CUser, CDate, MUser, MDate, PermissionWorkflowName) 
SELECT 
	pf.PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, pf.GroupId, 
	'00000000-0000-0000-0000-000000000012', 0, 0, 0, 0, 0, 0, 0, 
	'System', CURRENT_TIMESTAMP, 'System', CURRENT_TIMESTAMP, 'Calendars' 
FROM sPermissionProductType ppt 
	INNER JOIN sPermissionFolder pf ON ppt.PermissionFolderId = pf.PermissionFolderId 
WHERE pf.PermissionFolderTypeId = 22

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08785', GetDate())
GO
