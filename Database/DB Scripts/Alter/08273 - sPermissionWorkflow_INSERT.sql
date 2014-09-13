DECLARE @User NVARCHAR(40) = 'System'
DECLARE @PlanningDevTrackerWorkflowID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000002'
DECLARE @PlanningFolderTypeID INT = 22

DECLARE @PlanningItems TABLE(
	PaletteID UNIQUEIDENTIFIER,
	PaletteName NVARCHAR(200)
)
	
INSERT INTO @PlanningItems
VALUES ('00000000-0000-0000-0000-000000000020', 'Merchandise Tracker'),
	('00000000-0000-0000-0000-000000000021', 'Financial Tracker'),
	('00000000-0000-0000-0000-000000000022', 'Style')	
	
DELETE FROM sPermissionWorkflow 
WHERE WorkflowId IN (SELECT PaletteID FROM @PlanningItems)
	AND PermissionProductTypeId IN (
		SELECT PermissionProductTypeId 
		FROM sPermissionProductType ppt
		INNER JOIN sPermissionFolder pf ON ppt.PermissionFolderId = pf.PermissionFolderId
		WHERE pf.PermissionFolderTypeId = @PlanningFolderTypeID)
		
INSERT INTO sPermissionWorkflow ( 
	PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, GroupId, 
	WorkflowId, PermissionRoleId, PermissionView, PermissionCreate,	PermissionRemove, PermissionModify, 
	PermissionDelete, PermissionPrint, CUser, CDate, MUser, MDate, PermissionWorkflowName, ParentWorkflowID) 
SELECT 
	pf.PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, pf.GroupId, PaletteID, 
	0, 0, 0, 0, 0, 0, 0, @User, CURRENT_TIMESTAMP, @User, CURRENT_TIMESTAMP, PaletteName, @PlanningDevTrackerWorkflowID 
FROM @PlanningItems, sPermissionProductType ppt 
	INNER JOIN sPermissionFolder pf ON ppt.PermissionFolderId = pf.PermissionFolderId 
WHERE pf.PermissionFolderTypeId = @PlanningFolderTypeID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08273', GetDate())
GO
