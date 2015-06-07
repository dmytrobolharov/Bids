DECLARE @DivisionFolderTypeID INT = 26

IF NOT EXISTS(SELECT 1 FROM sPermissionFolderType WHERE PermissionFolderTypeName = 'Division')
BEGIN
	INSERT INTO sPermissionFolderType(PermissionFolderTypeId, PermissionFolderTypeName, Active)
	VALUES(@DivisionFolderTypeID, 'Division', 1)
END

INSERT INTO sPermissionFolder(PermissionFolderId, PermissionFolderTypeId, GroupId, PermissionFolderNotLocked, CUser, CDate, MUser, MDate)
SELECT NEWID(), @DivisionFolderTypeID, GroupID, 1, 'System', CURRENT_TIMESTAMP, 'System', CURRENT_TIMESTAMP 
FROM uGroup gr
WHERE NOT EXISTS(SELECT 1 FROM sPermissionFolder pf WHERE pf.GroupId = gr.GroupId AND pf.PermissionFolderTypeId = @DivisionFolderTypeID)

INSERT INTO sPermissionProductTypeMap (PermissionFolderTypeId, GuidProductTypeId)
SELECT @DivisionFolderTypeID, CustomID
FROM iCustom1 divisions
WHERE NOT EXISTS(SELECT 1 FROM sPermissionProductTypeMap pptm WHERE pptm.PermissionFolderTypeId = @DivisionFolderTypeID AND pptm.GuidProductTypeId = divisions.CustomID)

INSERT INTO sPermissionProductType(PermissionProductTypeId, PermissionFolderId, PermissionProductTypeMapId, PermissionProductTypeNotLocked, GroupId, 
CUser, CDate, MUser, MDate, Active, PermissionProductTypeName)
SELECT NEWID(), fol.PermissionFolderId, ptm.PermissionProductTypeMapId, 1, fol.GroupId,
'System', CURRENT_TIMESTAMP, 'System', CURRENT_TIMESTAMP, division.Active, division.Custom
FROM sPermissionFolder fol
INNER JOIN sPermissionProductTypeMap ptm ON ptm.PermissionFolderTypeId = @DivisionFolderTypeID AND fol.PermissionFolderTypeId = @DivisionFolderTypeID
INNER JOIN iCustom1 division ON ptm.GuidProductTypeId = division.CustomID
WHERE NOT EXISTS(SELECT 1 FROM sPermissionProductType ppt WHERE ppt.PermissionFolderId = fol.PermissionFolderId AND ppt.PermissionProductTypeMapId = ptm.PermissionProductTypeMapId)

INSERT INTO sPermissionWorkflow (PermissionWorkflowId, PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, GroupId,
WorkflowID, PermissionRoleId, PermissionView, PermissionCreate, PermissionRemove, PermissionModify, PermissionDelete, PermissionPrint,
CUser, CDate, MUser, MDate, PermissionWorkflowName, ParentWorkflowID, Active)
SELECT NEWID(), pf.PermissionFolderId, ppt.PermissionProductTypeId, ppt.PermissionProductTypeMapId, pf.GroupId,
'00000000-0000-0000-0000-000000000000', 0, 0, 0, 0, 0, 0, 0,
'System', CURRENT_TIMESTAMP, 'System', CURRENT_TIMESTAMP, '', NULL, 1
FROM sPermissionProductType ppt
INNER JOIN sPermissionFolder pf ON ppt.PermissionFolderId = pf.PermissionFolderId AND pf.PermissionFolderTypeId = @DivisionFolderTypeID
WHERE NOT EXISTS(SELECT 1 FROM sPermissionWorkflow pw WHERE pw.PermissionProductTypeId = ppt.PermissionProductTypeId AND pw.WorkflowID='00000000-0000-0000-0000-000000000000')

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09357', GetDate())
GO