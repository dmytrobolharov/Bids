-- Add random GUIDs to non-specified pSampleWorkflow records
UPDATE pSampleWorkflow SET SampleWorkflowGUID = NEWID() WHERE SampleWorkflowGUID IS NULL
GO

-- Filling the basic permission tables for the very unlikely case they're not filled yet
EXEC spx_FillTablesNewPermissions
GO

-- Deleting old permissions for Sample Folder
DELETE FROM sPermissionWorkflow WHERE PermissionProductTypeId IN
(
	SELECT pt.PermissionProductTypeId FROM sPermissionProductType pt 
	INNER JOIN sPermissionFolder pf ON pf.PermissionFolderId = pt.PermissionFolderId
	WHERE pf.PermissionFolderTypeId = 5
)

GO

DELETE FROM sPermissionProductType WHERE PermissionFolderId IN
(
	SELECT PermissionFolderId FROM sPermissionFolder WHERE PermissionFolderTypeId = 5
)

GO

DELETE FROM sPermissionProductTypeMap WHERE PermissionFolderTypeId = 5

GO

-- Inserting new permission product types, hich are 
INSERT INTO sPermissionProductTypeMap (PermissionFolderTypeId, IntProductTypeId)
SELECT 5, StyleTypeID
FROM pStyleType

GO

-- Inserting new Product Types for each Permission Folder
INSERT INTO sPermissionProductType (PermissionFolderId, PermissionProductTypeMapId, PermissionProductTypeNotLocked, 
GroupId, CUser, CDate, MUser, MDate, Active, PermissionProductTypeName)
SELECT pf.PermissionFolderId, ptm.PermissionProductTypeMapId, 1, pf.GroupId, 
'Administrator', CURRENT_TIMESTAMP, 'Administrator', CURRENT_TIMESTAMP, st.Active, st.StyleTypeDescription
FROM sPermissionProductTypeMap ptm
CROSS JOIN sPermissionFolder pf
INNER JOIN pStyleType st ON ptm.IntProductTypeId = st.StyleTypeID 
WHERE pf.PermissionFolderTypeId = 5 AND ptm.PermissionFolderTypeId = 5
AND NOT EXISTS (SELECT * FROM sPermissionProductType WHERE PermissionProductTypeMapId = ptm.PermissionProductTypeMapId AND PermissionFolderId = pf.PermissionFolderId)

GO

-- Inserting new Workflows for each Product Type
INSERT INTO sPermissionWorkflow 
(PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, GroupId, WorkflowId, 
PermissionRoleId, PermissionView, PermissionCreate, PermissionRemove, PermissionModify, PermissionDelete, PermissionPrint,
CUser, CDate, MUser, MDate, PermissionWorkflowName)
SELECT pf.PermissionFolderId, ppt.PermissionProductTypeId, ppt.PermissionProductTypeMapId, pf.GroupId, sw.SampleWorkflowGUID,
ISNULL(access.AccessRoleID, 0), ISNULL(access.AccessView, 0), ISNULL(access.AccessCreate, 0), ISNULL(access.AccessRemove, 0),
ISNULL(access.AccessModify, 0), ISNULL(access.AccessDelete, 0), ISNULL(access.AccessPrint, 0),
'Administrator', CURRENT_TIMESTAMP, 'Administrator', CURRENT_TIMESTAMP, sw.SampleWorkflow FROM sPermissionProductType ppt
CROSS JOIN pSampleWorkflow sw
INNER JOIN sPermissionFolder pf ON ppt.PermissionFolderId = pf.PermissionFolderId
LEFT OUTER JOIN sAccessGroupSampleFolder access ON access.SampleTypeId = sw.SampleWorkflowID AND ppt.GroupId = access.GroupID
WHERE pf.PermissionFolderTypeId = 5
AND NOT EXISTS(SELECT * FROM sPermissionWorkflow WHERE WorkflowID = sw.SampleWorkflowGUID AND PermissionProductTypeId = ppt.PermissionProductTypeId)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08006', GetDate())
GO
