DECLARE @BIFolderType INT = 17
DECLARE @DashboardProductType INT = 1
DECLARE @ReportProductType INT = 2

INSERT INTO sPermissionFolder (PermissionFolderTypeId, GroupId, PermissionFolderNotLocked, CUser, CDate, MUser, MDate)
SELECT @BIFolderType, GroupID, 1, 'System', CURRENT_TIMESTAMP, 'System', CURRENT_TIMESTAMP
FROM uGroup gr
WHERE NOT EXISTS (SELECT 1 FROM sPermissionFolder pf WHERE pf.PermissionFolderTypeId = @BIFolderType AND pf.GroupId = gr.GroupID)

-- Inserting Dashboards
DECLARE @DashboardProductTypeMapID INT
IF NOT EXISTS(SELECT 1 FROM sPermissionProductTypeMap WHERE PermissionFolderTypeId = @BIFolderType AND IntProductTypeId = @DashboardProductType)
BEGIN
	INSERT INTO sPermissionProductTypeMap (PermissionFolderTypeId, IntProductTypeId)
	VALUES (@BIFolderType, @DashboardProductType)
END
SELECT @DashboardProductTypeMapID = PermissionProductTypeMapId FROM sPermissionProductTypeMap 
WHERE PermissionFolderTypeId = @BIFolderType AND IntProductTypeId = @DashboardProductType

INSERT INTO sPermissionProductType (PermissionFolderId, PermissionProductTypeMapId, PermissionProductTypeNotLocked, GroupId, 
CUser, CDate, MUser, MDate, Active, PermissionProductTypeName)
SELECT PermissionFolderId, @DashboardProductTypeMapID, 1, GroupId, 'System', CURRENT_TIMESTAMP, 'System', CURRENT_TIMESTAMP, 1, 'Dashboard'
FROM sPermissionFolder pf
WHERE pf.PermissionFolderTypeId = @BIFolderType
AND NOT EXISTS(SELECT 1 FROM sPermissionProductType ppt 
	WHERE ppt.PermissionFolderId = pf.PermissionFolderId AND ppt.PermissionProductTypeMapId = @DashboardProductTypeMapID)

INSERT INTO sPermissionWorkflow (PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, GroupId, WorkflowId,
PermissionRoleId, PermissionView, PermissionCreate, PermissionRemove, PermissionModify, PermissionDelete, PermissionPrint,
CUser, CDate, MUser, MDate, PermissionWorkflowName, ParentWorkflowID, Active)
SELECT pf.PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, pf.GroupId, dfi.DashFolderItemID,
				0, 0, 0, 0, 0, 0, 0,
				'System', CURRENT_TIMESTAMP, 'System', CURRENT_TIMESTAMP, dfi.DashFolderItemName, NULL, 1
FROM rDashFolderItem dfi 
CROSS JOIN sPermissionProductType ppt
INNER JOIN sPermissionFolder pf ON ppt.PermissionFolderId = pf.PermissionFolderId
WHERE pf.PermissionFolderTypeId = @BIFolderType AND PermissionProductTypeMapId = @DashboardProductTypeMapID 
AND NOT EXISTS(SELECT 1 FROM sPermissionWorkflow WHERE PermissionProductTypeId = ppt.PermissionProductTypeId 
				AND WorkflowId = dfi.DashFolderItemID)

-- Inserting Reports
DECLARE @ReportProductTypeMapID INT
IF NOT EXISTS(SELECT 1 FROM sPermissionProductTypeMap WHERE PermissionFolderTypeId = @BIFolderType AND IntProductTypeId = @ReportProductType)
BEGIN
	INSERT INTO sPermissionProductTypeMap (PermissionFolderTypeId, IntProductTypeId)
	VALUES (@BIFolderType, @ReportProductType)
END
SELECT @ReportProductTypeMapID = PermissionProductTypeMapId FROM sPermissionProductTypeMap 
WHERE PermissionFolderTypeId = @BIFolderType AND IntProductTypeId = @ReportProductType

INSERT INTO sPermissionProductType (PermissionFolderId, PermissionProductTypeMapId, PermissionProductTypeNotLocked, GroupId, 
CUser, CDate, MUser, MDate, Active, PermissionProductTypeName)
SELECT PermissionFolderId, @ReportProductTypeMapID, 1, GroupId, 'System', CURRENT_TIMESTAMP, 'System', CURRENT_TIMESTAMP, 1, 'Report'
FROM sPermissionFolder pf
WHERE pf.PermissionFolderTypeId = @BIFolderType
AND NOT EXISTS(SELECT 1 FROM sPermissionProductType ppt 
	WHERE ppt.PermissionFolderId = pf.PermissionFolderId AND ppt.PermissionProductTypeMapId = @ReportProductTypeMapID)

INSERT INTO sPermissionWorkflow (PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, GroupId, WorkflowId,
PermissionRoleId, PermissionView, PermissionCreate, PermissionRemove, PermissionModify, PermissionDelete, PermissionPrint,
CUser, CDate, MUser, MDate, PermissionWorkflowName, ParentWorkflowID, Active)
SELECT pf.PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, pf.GroupId, rfi.ReportFolderItemID,
				0, 0, 0, 0, 0, 0, 0,
				'System', CURRENT_TIMESTAMP, 'System', CURRENT_TIMESTAMP, rfi.ReportItemName, NULL, 1
FROM rReportFolderItem rfi 
CROSS JOIN sPermissionProductType ppt
INNER JOIN sPermissionFolder pf ON ppt.PermissionFolderId = pf.PermissionFolderId
WHERE pf.PermissionFolderTypeId = @BIFolderType AND PermissionProductTypeMapId = @ReportProductTypeMapID 
AND NOT EXISTS(SELECT 1 FROM sPermissionWorkflow WHERE PermissionProductTypeId = ppt.PermissionProductTypeId 
				AND WorkflowId = rfi.ReportFolderItemID)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09996', GetUTCDate())
GO
