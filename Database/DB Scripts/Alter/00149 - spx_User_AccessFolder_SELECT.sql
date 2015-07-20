
ALTER PROCEDURE [dbo].[spx_User_AccessFolder_SELECT]  (
@nDeskFolderId int  , 
@TeamID uniqueidentifier 
)
AS
IF  @nDeskFolderId  = 2  
	SELECT @nDeskFolderId AS DeskFolderID, b.StyleTypeDescription as TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify, a.AccessRemove, a.AccessDelete, a.AccessPrint, a.AccessCreate 
	FROM  sAccessStyleFolder a INNER JOIN pStyleType b ON A.StyleTypeID = b.StyleTypeID
	WHERE a.TeamId = @TeamID
	ORDER BY StyleTypeOrder

ELSE IF @nDeskFolderId  = 3  
	SELECT @nDeskFolderId AS DeskFolderID, 'Line Folder' as  TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify, 0 as AccessRemove, a.AccessDelete, a.AccessPrint , a.AccessCreate
	FROM  sAccessLineFolder  a 
	WHERE a.TeamId = @TeamID

ELSE  IF @nDeskFolderId  = 4
	SELECT @nDeskFolderId AS DeskFolderID, b.StyleTypeDescription as TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify, 0 as AccessRemove, a.AccessDelete, a.AccessPrint, a.AccessCreate 
	FROM  sAccessQuotationFolder a INNER JOIN pStyleType b ON A.StyleTypeID = b.StyleTypeID
	WHERE a.TeamId = @TeamID
	ORDER BY StyleTypeOrder

ELSE  IF @nDeskFolderId  = 5
	SELECT @nDeskFolderId AS DeskFolderID, b.SampleWorkflow as TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify, a.AccessRemove, a.AccessDelete, a.AccessPrint, a.AccessCreate 
	FROM  sAccessSampleFolder a INNER JOIN pSampleWorkflow b ON a.SampleTypeID = b.SampleWorkflowID
	WHERE a.TeamId = @TeamID
	ORDER BY b.SampleWorkflowSort

ELSE  IF @nDeskFolderId  = 6
	SELECT @nDeskFolderId AS DeskFolderID, b.ImageType  as TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify,  0 as AccessRemove, a.AccessDelete, a.AccessPrint, a.AccessCreate 
	FROM  sAccessImageFolder a INNER JOIN pImageType b ON a.ImageTypeId = b.ImageTypeId 
	WHERE a.TeamId = @TeamID
	AND b.Active = 1
	ORDER BY b.ImageOrder

ELSE  IF @nDeskFolderId  = 7
/*
	SELECT @nDeskFolderId AS DeskFolderID, 'Color Folder' as  TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify,  0 as AccessRemove, a.AccessDelete, a.AccessPrint, a.AccessCreate 
	FROM  sAccessColorFolder  a 
	WHERE a.TeamId = @TeamID
*/
	SELECT @nDeskFolderId AS DeskFolderID, b.ColorTypeDescription as TypeDescription, a.AccessRoleID, a.AccessView, a.AccessModify, 
	a.AccessDelete, a.AccessDelete, a.AccessPrint, a.AccessCreate, 0 as AccessRemove
	FROM  sAccessColorFolder  a 
	INNER JOIN pColorType b ON a.ColorTypeID =  b.ColorTypeID
	WHERE a.TeamID = @TeamID
	ORDER BY b.Sort


ELSE  IF @nDeskFolderId  = 8
	SELECT @nDeskFolderId AS DeskFolderID, b.ComponentDescription  as TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify, 0 as AccessRemove,  a.AccessDelete, a.AccessPrint, a.AccessCreate 
	FROM  sAccessMaterialFolder  a INNER JOIN pComponentType  b ON a.ComponentTypeID  = b.ComponentTypeId 
	WHERE a.TeamId = @TeamID
	ORDER BY b.ComponentOrder

ELSE  IF @nDeskFolderId  = 9
	SELECT @nDeskFolderId AS DeskFolderID, b.ComplianceType as TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify, 0 as AccessRemove,  a.AccessDelete, a.AccessPrint, a.AccessCreate 
	FROM  sAccessComplianceFolder a INNER JOIN pComplianceType  b ON a.ComplianceTypeId  = b.ComplianceTypeId 
	WHERE a.TeamId = @TeamID
	ORDER BY b.ComplianceOrder, b.ComplianceType

ELSE  IF @nDeskFolderId  = 10
	SELECT @nDeskFolderId AS DeskFolderID, b.ControlPanelName as TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify, 0 as AccessRemove,  a.AccessDelete, a.AccessPrint, a.AccessCreate 
	FROM  sAccessControlPanel  a INNER JOIN pControlPanel  b ON a.ControlPanelId  = b.ControlPanelId
	WHERE a.TeamId = @TeamID
	ORDER BY b.ControlPanelOrder

ELSE  IF @nDeskFolderId  = 11
	SELECT @nDeskFolderId AS DeskFolderID, 'Share Folder' as  TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify,  0 as AccessRemove, a.AccessDelete, a.AccessPrint, a.AccessCreate 
	FROM  sAccessShareFolder a 
	WHERE a.TeamId = @TeamID

ELSE  IF @nDeskFolderId  = 12
	SELECT @nDeskFolderId AS DeskFolderID, b.StyleTypeDescription as TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify, 0 as AccessRemove,  a.AccessDelete, a.AccessPrint, a.AccessCreate 
	FROM  sAccessCosting  a INNER JOIN pStyleType b ON a.StyleTypeID = b.StyleTypeID
	WHERE a.TeamId = @TeamID
	ORDER BY StyleTypeOrder

ELSE  IF @nDeskFolderId  = 15
	SELECT @nDeskFolderId AS DeskFolderID, b.QuickBRTypeName as TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify, 0 as AccessRemove,  a.AccessDelete, a.AccessPrint, a.AccessCreate 
	FROM  sAccessQuickBatchReplaceFolder  a INNER JOIN pQuickBatchReplaceType  b ON a.QuickBRTypeId  = b.QuickBRTypeId
	WHERE a.TeamId = @TeamID

ELSE  IF @nDeskFolderId = 16
	SELECT @nDeskFolderId AS DeskFolderID, b.BatchQueueTypeDescription as TypeDescription, a.AccessRoleId, a.AccessView, a.AccessModify, 0 as AccessRemove, a.AccessDelete, a.AccessPrint, a.AccessCreate 
	FROM  sAccessBatchQueue a INNER JOIN bBatchQueueType b ON a.BatchQueueTypeID = b.BatchQueueTypeID
	WHERE a.TeamId = @TeamID
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '149', GetDate())
GO
