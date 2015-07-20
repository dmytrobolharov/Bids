UPDATE sPermissionProductType SET Active = 1
GO

UPDATE sPermissionWorkflow SET Active = 1
GO

-- Updating inactive color types
UPDATE ppt
SET Active = ct.Active
FROM sPermissionProductType ppt
INNER JOIN sPermissionProductTypeMap ptm ON ptm.PermissionProductTypeMapId = ppt.PermissionProductTypeMapId
INNER JOIN sPermissionFolder pf ON pf.PermissionFolderId = ppt.PermissionFolderId
INNER JOIN pColorType ct ON ct.ColorTypeID = ptm.IntProductTypeId
WHERE pf.PermissionFolderTypeId = 7
GO

-- Updating inactive material types
UPDATE ppt
SET Active = ct.Active
FROM sPermissionProductType ppt
INNER JOIN sPermissionProductTypeMap ptm ON ptm.PermissionProductTypeMapId = ppt.PermissionProductTypeMapId
INNER JOIN sPermissionFolder pf ON pf.PermissionFolderId = ppt.PermissionFolderId
INNER JOIN pComponentType ct ON ct.ComponentTypeID = ptm.IntProductTypeId
WHERE pf.PermissionFolderTypeId IN (8, 24)
GO

-- Updating inactive image types
UPDATE ppt
SET Active = it.Active
FROM sPermissionProductType ppt
INNER JOIN sPermissionProductTypeMap ptm ON ptm.PermissionProductTypeMapId = ppt.PermissionProductTypeMapId
INNER JOIN sPermissionFolder pf ON pf.PermissionFolderId = ppt.PermissionFolderId
INNER JOIN pImageType it ON it.ImageTypeID = ptm.GuidProductTypeId
WHERE pf.PermissionFolderTypeId = 6
GO

-- Updating inactive material request workflows
UPDATE pw
SET Active = w.Active
FROM sPermissionWorkflow pw
INNER JOIN sPermissionProductType ppt ON ppt.PermissionProductTypeId = pw.PermissionProductTypeId
INNER JOIN sPermissionFolder pf ON pf.PermissionFolderId = ppt.PermissionFolderId
INNER JOIN pMaterialRequestWorkflow w ON pw.WorkflowId = w.MaterialRequestWorkflowGUIDID
WHERE pf.PermissionFolderTypeId = 24
GO

-- Updating inactive sample request workflows
UPDATE pw
SET Active = CASE WHEN UPPER(RTRIM(LTRIM(ISNULL(w.Active, '')))) = 'YES' THEN 1 ELSE 0 END
FROM sPermissionWorkflow pw
INNER JOIN sPermissionProductType ppt ON ppt.PermissionProductTypeId = pw.PermissionProductTypeId
INNER JOIN sPermissionFolder pf ON pf.PermissionFolderId = ppt.PermissionFolderId
INNER JOIN pSampleWorkflow w ON pw.WorkflowId = w.SampleWorkflowGUID
WHERE pf.PermissionFolderTypeId = 5
GO

-- Updating inactive style types
UPDATE ppt
SET Active = st.Active
FROM sPermissionProductType ppt
INNER JOIN sPermissionProductTypeMap ptm ON ptm.PermissionProductTypeMapId = ppt.PermissionProductTypeMapId
INNER JOIN sPermissionFolder pf ON pf.PermissionFolderId = ppt.PermissionFolderId
INNER JOIN pStyleType st ON st.StyleTypeID = ptm.IntProductTypeId
WHERE pf.PermissionFolderTypeId IN (2, 4, 5, 12, 20)
GO

-- Updating inactive style workflows
UPDATE pw
SET Active = w.Active
FROM sPermissionWorkflow pw
INNER JOIN sPermissionProductType ppt ON ppt.PermissionProductTypeId = pw.PermissionProductTypeId
INNER JOIN sPermissionFolder pf ON pf.PermissionFolderId = ppt.PermissionFolderId
INNER JOIN pWorkflow w ON pw.WorkflowId = w.WorkflowID
WHERE pf.PermissionFolderTypeId = 2
GO

UPDATE sPermissionWorkflow
SET Active = 1
WHERE ParentWorkflowID IS NOT NULL
GO

UPDATE sPermissionWorkflow SET Active = 1 WHERE WorkflowID = '70000000-0000-0000-0000-000000000001'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09275', GetDate())
GO
