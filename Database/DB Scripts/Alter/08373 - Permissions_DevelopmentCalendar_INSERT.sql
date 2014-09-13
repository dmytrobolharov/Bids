DECLARE @DevCalFolderType INT = 25
-- Setting the desk folder ID for "Development Calendar"
UPDATE sDeskTop SET DeskFolderID = @DevCalFolderType WHERE DeskTopID = 84
-- Adding a new sPermissionFolderType
IF NOT EXISTS(SELECT * FROM sPermissionFolderType WHERE PermissionFolderTypeId = @DevCalFolderType)
BEGIN
	INSERT INTO sPermissionFolderType (PermissionFolderTypeId, PermissionFolderTypeName)
	VALUES(@DevCalFolderType, 'Development Calendar')
END
-- Adding a Folders for this folder type
INSERT INTO sPermissionFolder (PermissionFolderTypeId, GroupId, PermissionFolderNotLocked, CUser, CDate, MUser, MDate)
SELECT @DevCalFolderType, GroupID, 0, 'System', CURRENT_TIMESTAMP, 'System', CURRENT_TIMESTAMP
FROM uGroup gr
WHERE NOT EXISTS(SELECT * FROM sPermissionFolder WHERE PermissionFolderTypeId = @DevCalFolderType AND GroupID = gr.GroupID)
-- Adding a fictive product type map for the whole "Development Calendar"
IF NOT EXISTS(SELECT * FROM sPermissionProductTypeMap WHERE PermissionFolderTypeId = @DevCalFolderType AND IntProductTypeId = 1)
BEGIN
	INSERT INTO sPermissionProductTypeMap (PermissionFolderTypeId, IntProductTypeId)
	VALUES(@DevCalFolderType, 1)
END
-- Adding a product types for each folder
INSERT INTO sPermissionProductType(PermissionFolderId, PermissionProductTypeMapId, PermissionProductTypeNotLocked, GroupId, 
					CUser, CDate, MUser, MDate, Active, PermissionProductTypeName)
SELECT pf.PermissionFolderId, ppt.PermissionProductTypeMapId, 1, pf.GroupId,
'System', CURRENT_TIMESTAMP, 'System', CURRENT_TIMESTAMP, 1, 'Development Calendar' FROM sPermissionFolder pf
CROSS JOIN sPermissionProductTypeMap ppt
WHERE pf.PermissionFolderTypeId = @DevCalFolderType
AND ppt.PermissionFolderTypeId = @DevCalFolderType
AND NOT EXISTS (SELECT * FROM sPermissionProductType WHERE PermissionFolderId = pf.PermissionFolderId AND PermissionProductTypeMapId = ppt.PermissionProductTypeMapId)
-- Adding a fictional bubble for each product type
INSERT INTO sPermissionWorkflow (PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, GroupId, WorkflowId,
	PermissionRoleId, PermissionView, PermissionCreate, PermissionRemove, PermissionModify, PermissionPrint, PermissionDelete, CUser, CDate, MUser, MDate,
	PermissionWorkflowName)
SELECT pf.PermissionFolderId, ppt.PermissionProductTypeId, ppt.PermissionProductTypeMapId, pf.GroupId, '00000000-0000-0000-0000-000000000000',
0, 0, 0, 0, 0, 0, 0, 'System', CURRENT_TIMESTAMP, 'System', CURRENT_TIMESTAMP, ''
FROM sPermissionProductType ppt
INNER JOIN sPermissionFolder pf ON pf.PermissionFolderId = ppt.PermissionFolderId
WHERE pf.PermissionFolderTypeId = @DevCalFolderType
AND NOT EXISTS(SELECT * FROM sPermissionWorkflow WHERE PermissionFolderId = pf.PermissionFolderId AND WorkflowId = '00000000-0000-0000-0000-000000000000')

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08373', GetDate())
GO
