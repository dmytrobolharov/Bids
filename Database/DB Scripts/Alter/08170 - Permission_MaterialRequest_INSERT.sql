DECLARE @MaterialRequestFolderTypeID INT = 24

-- Create new 'Material Request' Folder Type
IF NOT EXISTS(SELECT * FROM sPermissionFolderType WHERE PermissionFolderTypeId = @MaterialRequestFolderTypeID)
BEGIN
	INSERT INTO sPermissionFolderType (PermissionFolderTypeId, PermissionFolderTypeName, Active)
	VALUES(@MaterialRequestFolderTypeID, 'Material Request', 1)
END

-- Create new Material Request Folders for each group
INSERT INTO sPermissionFolder(PermissionFolderTypeId, GroupId, PermissionFolderNotLocked, CUser, CDate, MUser, MDate)
SELECT @MaterialRequestFolderTypeID, GroupID, 0, 'System', CURRENT_TIMESTAMP, 'System', CURRENT_TIMESTAMP
FROM uGroup gr
WHERE NOT EXISTS(SELECT * FROM sPermissionFolder 
					WHERE PermissionFolderTypeId = @MaterialRequestFolderTypeID AND GroupID = gr.GroupID)

-- Add product type mappings -- for Material Request it's Component Type
INSERT INTO sPermissionProductTypeMap(PermissionFolderTypeId, IntProductTypeId)
SELECT @MaterialRequestFolderTypeID, ComponentTypeID
FROM pComponentType ct
WHERE NOT EXISTS(SELECT * FROM sPermissionProductTypeMap 
					WHERE PermissionFolderTypeId = @MaterialRequestFolderTypeID AND IntProductTypeId = ct.ComponentTypeID)
					
-- Add Product Types for each Folder and each Component Type Map
INSERT INTO sPermissionProductType(PermissionFolderId, PermissionProductTypeMapId, PermissionProductTypeNotLocked, GroupId, 
			CUser, CDate, MUser, MDate, Active, PermissionProductTypeName)
SELECT pf.PermissionFolderId, ptm.PermissionProductTypeMapId, 1, pf.GroupId, 
		'System', CURRENT_TIMESTAMP, 'System', CURRENT_TIMESTAMP, 1, ct.ComponentDescription
FROM sPermissionFolder pf
CROSS JOIN sPermissionProductTypeMap ptm
INNER JOIN pComponentType ct ON ct.ComponentTypeID = ptm.IntProductTypeId
WHERE pf.PermissionFolderTypeId = @MaterialRequestFolderTypeID AND ptm.PermissionFolderTypeId = @MaterialRequestFolderTypeID
AND NOT EXISTS(SELECT * FROM sPermissionProductType 
				WHERE PermissionProductTypeMapId = ptm.PermissionProductTypeMapId AND PermissionFolderId = pf.PermissionFolderId)
				
-- Add Material Request Workflows for each Product Type
INSERT INTO sPermissionWorkflow (PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, GroupId, WorkflowId, 
									PermissionRoleId, PermissionView, PermissionCreate, PermissionRemove, PermissionModify, PermissionDelete, PermissionPrint,
									CUser, CDate, MUser, MDate, PermissionWorkflowName)
SELECT pf.PermissionFolderId, pt.PermissionProductTypeId, pt.PermissionProductTypeMapId, pf.GroupId, mrw.MaterialRequestWorkflowGUIDID,
		0, 0, 0, 0, 0, 0, 0,
		'System', CURRENT_TIMESTAMP, 'System', CURRENT_TIMESTAMP, mrw.MaterialRequestWorkflow
FROM sPermissionProductType pt 
INNER JOIN sPermissionProductTypeMap ptm ON pt.PermissionProductTypeMapId = ptm.PermissionProductTypeMapId
INNER JOIN sPermissionFolder pf ON pt.PermissionFolderId = pf.PermissionFolderId
CROSS JOIN pMaterialRequestWorkflow mrw
WHERE pf.PermissionFolderTypeId = @MaterialRequestFolderTypeID AND ptm.PermissionFolderTypeId = @MaterialRequestFolderTypeID
AND NOT EXISTS(SELECT * FROM sPermissionWorkflow 
				WHERE PermissionProductTypeId = pt.PermissionProductTypeId AND WorkflowID = mrw.MaterialRequestWorkflowGUIDID)


GO				
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08170', GetDate())
GO
