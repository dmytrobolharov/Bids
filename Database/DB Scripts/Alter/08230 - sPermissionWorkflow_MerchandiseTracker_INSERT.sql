DECLARE @User NVARCHAR(40) = 'System'
DECLARE @LineLineListPlanningWorkflowID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000001'
DECLARE @LineListFolderTypeID INT = 3
DECLARE @LinePaletteID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000024'
DECLARE @LinePaletteName NVARCHAR(200) = 'Merchandise Tracker'

INSERT INTO sPermissionWorkflow ( PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, GroupId, 
	WorkflowId, PermissionRoleId, PermissionView, PermissionCreate,	PermissionRemove, PermissionModify, 
	PermissionDelete, PermissionPrint, CUser, CDate, MUser, MDate, PermissionWorkflowName, ParentWorkflowID) 
SELECT 
	pf.PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, pf.GroupId, @LinePaletteID, 
	0, 0, 0, 0, 0, 0, 0, @User, CURRENT_TIMESTAMP, @User, CURRENT_TIMESTAMP, @LinePaletteName, @LineLineListPlanningWorkflowID 
FROM sPermissionProductType ppt 
	INNER JOIN sPermissionFolder pf ON ppt.PermissionFolderId = pf.PermissionFolderId 
WHERE pf.PermissionFolderTypeId = @LineListFolderTypeID
AND NOT EXISTS(SELECT * FROM sPermissionWorkflow WHERE PermissionProductTypeID = ppt.PermissionProductTypeID AND WorkflowID = @LinePaletteID)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08230', GetDate())
GO