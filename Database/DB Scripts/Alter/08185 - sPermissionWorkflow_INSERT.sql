DECLARE @User NVARCHAR(40) = 'System'
DECLARE @LineLineListPlanningWorkflowID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000001'
DECLARE @LineListFolderTypeID INT = 3

CREATE TABLE #tmpLineListPlanningItems (
	LinePaletteID UNIQUEIDENTIFIER,
	LinePaletteName NVARCHAR(200)
)
	
INSERT INTO #tmpLineListPlanningItems
VALUES ('00000000-0000-0000-0000-000000000020', 'Financial Plan'),
	('00000000-0000-0000-0000-000000000021', 'Historical List'),
	('00000000-0000-0000-0000-000000000022', 'SKU Plan'),
	('00000000-0000-0000-0000-000000000023', 'Notifications')	
	
DELETE FROM sPermissionWorkflow WHERE WorkflowId IN (SELECT LinePaletteID FROM #tmpLineListPlanningItems)
	AND PermissionProductTypeId IN (SELECT PermissionProductTypeId FROM sPermissionProductType ppt
	INNER JOIN sPermissionFolder pf ON ppt.PermissionFolderId = pf.PermissionFolderId
	WHERE pf.PermissionFolderTypeId = @LineListFolderTypeID)
		
INSERT INTO sPermissionWorkflow ( PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, GroupId, 
	WorkflowId, PermissionRoleId, PermissionView, PermissionCreate,	PermissionRemove, PermissionModify, 
	PermissionDelete, PermissionPrint, CUser, CDate, MUser, MDate, PermissionWorkflowName, ParentWorkflowID) 
SELECT 
	pf.PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, pf.GroupId, LinePaletteID, 
	0, 0, 0, 0, 0, 0, 0, @User, CURRENT_TIMESTAMP, @User, CURRENT_TIMESTAMP, LinePaletteName, @LineLineListPlanningWorkflowID 
FROM #tmpLineListPlanningItems, sPermissionProductType ppt 
	INNER JOIN sPermissionFolder pf ON ppt.PermissionFolderId = pf.PermissionFolderId 
WHERE pf.PermissionFolderTypeId = @LineListFolderTypeID

DROP TABLE #tmpLineListPlanningItems

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08185', GetDate())
GO