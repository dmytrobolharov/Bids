-- Filling the basic permission tables
EXEC spx_FillTablesNewPermissions
GO

-- Creating the sPermissionFolderType record
IF NOT EXISTS(SELECT * FROM sPermissionFolderType WHERE PermissionFolderTypeId = 22)
BEGIN
	INSERT INTO sPermissionFolderType(PermissionFolderTypeId, PermissionFolderTypeName, Active)
	VALUES('22', 'Planning', 1)
END

GO

-- Creating the sPermissionFolder records for each group and current folder type
INSERT INTO sPermissionFolder (PermissionFolderTypeId, GroupId, PermissionFolderNotLocked, CUser, CDate, MUser, MDate)
SELECT 22, gr.GroupID, 1, 'Administrator', CURRENT_TIMESTAMP, 'Administrator', CURRENT_TIMESTAMP
FROM uGroup gr
WHERE NOT EXISTS(SELECT * FROM sPermissionFolder WHERE GroupID = gr.GroupID AND PermissionFolderTypeId = 22)

GO

-- Creating the sPermissionProductTypeMap records
INSERT INTO sPermissionProductTypeMap(PermissionFolderTypeId, GuidProductTypeId, IntProductTypeId, StrProductTypeId)
SELECT 22, PlanningTypeID, NULL, NULL
FROM pPlanningType pt
WHERE NOT EXISTS (SELECT * FROM sPermissionProductTypeMap WHERE PermissionFolderTypeId = 22 AND GuidProductTypeId = pt.PlanningTypeID)

GO

-- Creating the sPermissionProductType records for each sPermissionFolder and each ProductTypeMap
INSERT INTO sPermissionProductType (PermissionFolderId, PermissionProductTypeMapId, PermissionProductTypeNotLocked, 
GroupId, CUser, CDate, MUser, MDate, PermissionProductTypeName)
SELECT PermissionFolderID, PermissionProductTypeMapID, 1, 
GroupID, 'Administrator', CURRENT_TIMESTAMP, 'Administrator', CURRENT_TIMESTAMP, PlanningType
FROM sPermissionFolder f
CROSS JOIN sPermissionProductTypeMap ptm
INNER JOIN pPlanningType pt ON ptm.GuidProductTypeId = pt.PlanningTypeID
WHERE f.PermissionFolderTypeId = 22 AND ptm.PermissionFolderTypeId = 22
AND NOT EXISTS(
SELECT * FROM sPermissionProductType WHERE PermissionFolderId = f.PermissionFolderId 
AND PermissionProductTypeMapId = ptm.PermissionProductTypeMapId
)

GO

-- Creating the sPermissionWorkflow records for each sPermissionProductType in current folder type
DECLARE @PlanningWorkflowList TABLE
(
  PlanningItemID UNIQUEIDENTIFIER,
  PlannintItemName NVARCHAR(200),
  PlanningItemDescription NVARCHAR(200),
  PlanningItemSort INT,
  Child INT
)
INSERT INTO @PlanningWorkflowList
EXEC spx_PlanningFolderItem_SELECT

INSERT INTO sPermissionWorkflow (PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, GroupId, WorkflowId,
PermissionRoleId, PermissionView, PermissionCreate, PermissionRemove, PermissionModify, PermissionDelete, PermissionPrint,
CUser, CDate, MUser, MDate, PermissionWorkflowName) 
SELECT pf.PermissionFolderId, ppt.PermissionProductTypeId, ppt.PermissionProductTypeMapId, pf.GroupId, pwl.PlanningItemID,
ISNULL(aplf.AccessRoleID, 0), ISNULL(aplf.AccessView, 0), ISNULL(aplf.AccessCreate, 0), ISNULL(aplf.AccessDelete, 0), ISNULL(aplf.AccessModify, 0), ISNULL(aplf.AccessDelete, 0), ISNULL(aplf.AccessPrint, 0), 
'Administrator', CURRENT_TIMESTAMP, 'Administrator', CURRENT_TIMESTAMP, pwl.PlannintItemName
FROM sPermissionProductType ppt
INNER JOIN sPermissionFolder pf ON ppt.PermissionFolderId = pf.PermissionFolderId
CROSS JOIN @PlanningWorkflowList pwl
LEFT OUTER JOIN sAccessGroupPlanningFolderItem aplf ON aplf.GroupID = pf.GroupId AND aplf.PlanningItemID = pwl.PlanningItemID
WHERE Pf.PermissionFolderTypeId = 22
AND NOT EXISTS (SELECT * FROM sPermissionWorkflow WHERE PermissionProductTypeId = ppt.PermissionProductTypeId AND WorkflowId = pwl.PlanningItemID)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07852', GetDate())
GO