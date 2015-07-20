IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_User_AccessFolder_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_User_AccessFolder_SELECT]
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_User_AccessFolder_SELECT]
(
	@nDeskFolderId INT, 
	@TeamID UNIQUEIDENTIFIER,
	@TemplateID UNIQUEIDENTIFIER,
	@TemplateItemValue UNIQUEIDENTIFIER
)
AS
BEGIN
	IF  @nDeskFolderId  = 2  
		SELECT @nDeskFolderId AS DeskFolderID, b.StyleTypeDescription AS TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify, a.AccessRemove, a.AccessDelete, a.AccessPrint, a.AccessCreate 
		FROM  sAccessStyleFolder a INNER JOIN pStyleType b ON A.StyleTypeID = b.StyleTypeID
		WHERE a.TeamId = @TeamID
		ORDER BY StyleTypeOrder

	ELSE IF @nDeskFolderId  = 3  
		SELECT @nDeskFolderId AS DeskFolderID, 'Line Folder' AS  TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify, 0 AS AccessRemove, a.AccessDelete, a.AccessPrint , a.AccessCreate
		FROM  sAccessLineFolder  a 
		WHERE a.TeamId = @TeamID

	ELSE  IF @nDeskFolderId  = 4
		SELECT @nDeskFolderId AS DeskFolderID, b.StyleTypeDescription AS TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify, 0 AS AccessRemove, a.AccessDelete, a.AccessPrint, a.AccessCreate 
		FROM  sAccessQuotationFolder a INNER JOIN pStyleType b ON A.StyleTypeID = b.StyleTypeID
		WHERE a.TeamId = @TeamID
		ORDER BY StyleTypeOrder

	ELSE  IF @nDeskFolderId  = 5
		SELECT @nDeskFolderId AS DeskFolderID, b.SampleWorkflow AS TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify, a.AccessRemove, a.AccessDelete, a.AccessPrint, a.AccessCreate 
		FROM  sAccessSampleFolder a INNER JOIN pSampleWorkflow b ON a.SampleTypeID = b.SampleWorkflowID
		WHERE a.TeamId = @TeamID
		ORDER BY b.SampleWorkflowSort

	ELSE  IF @nDeskFolderId  = 6
		SELECT @nDeskFolderId AS DeskFolderID, b.ImageType  AS TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify,  0 AS AccessRemove, a.AccessDelete, a.AccessPrint, a.AccessCreate 
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
		SELECT @nDeskFolderId AS DeskFolderID, b.ColorTypeDescription AS TypeDescription, a.AccessRoleID, a.AccessView, a.AccessModify, 
		a.AccessDelete, a.AccessDelete, a.AccessPrint, a.AccessCreate, 0 AS AccessRemove
		FROM  sAccessColorFolder  a 
		INNER JOIN pColorType b ON a.ColorTypeID =  b.ColorTypeID
		WHERE a.TeamID = @TeamID
		ORDER BY b.Sort


	ELSE  IF @nDeskFolderId  = 8
		SELECT @nDeskFolderId AS DeskFolderID, b.ComponentDescription  AS TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify, 0 AS AccessRemove,  a.AccessDelete, a.AccessPrint, a.AccessCreate 
		FROM  sAccessMaterialFolder  a INNER JOIN pComponentType  b ON a.ComponentTypeID  = b.ComponentTypeId 
		WHERE a.TeamId = @TeamID
		ORDER BY b.ComponentOrder

	ELSE  IF @nDeskFolderId  = 9
		SELECT @nDeskFolderId AS DeskFolderID, b.ComplianceType AS TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify, 0 AS AccessRemove,  a.AccessDelete, a.AccessPrint, a.AccessCreate 
		FROM  sAccessComplianceFolder a INNER JOIN pComplianceType  b ON a.ComplianceTypeId  = b.ComplianceTypeId 
		WHERE a.TeamId = @TeamID
		ORDER BY b.ComplianceOrder, b.ComplianceType

	ELSE  IF @nDeskFolderId  = 10
		SELECT @nDeskFolderId AS DeskFolderID, b.ControlPanelName AS TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify, 0 AS AccessRemove,  a.AccessDelete, a.AccessPrint, a.AccessCreate 
		FROM  sAccessControlPanel  a INNER JOIN pControlPanel  b ON a.ControlPanelId  = b.ControlPanelId
		WHERE a.TeamId = @TeamID
		AND b.IsDataValidation = 0
		ORDER BY b.ControlPanelOrder

	ELSE  IF @nDeskFolderId  = 11
		SELECT @nDeskFolderId AS DeskFolderID, 'Share Folder' AS  TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify,  0 AS AccessRemove, a.AccessDelete, a.AccessPrint, a.AccessCreate 
		FROM  sAccessShareFolder a 
		WHERE a.TeamId = @TeamID

	ELSE  IF @nDeskFolderId  = 12
		SELECT @nDeskFolderId AS DeskFolderID, b.StyleTypeDescription AS TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify, 0 AS AccessRemove,  a.AccessDelete, a.AccessPrint, a.AccessCreate 
		FROM  sAccessCosting  a INNER JOIN pStyleType b ON a.StyleTypeID = b.StyleTypeID
		WHERE a.TeamId = @TeamID
		ORDER BY StyleTypeOrder

	ELSE  IF @nDeskFolderId  = 13  -- LinePlan
	BEGIN 

		SELECT  d.LinePlanTabName AS TypeDescription,a.LinePlanTemplateID, d.LinePlanTabSort,
			MAX(a.AccessRoleId) AS AccessRoleId, MAX(a.AccessView) AS AccessView, 
			MAX(a.AccessCreate) AS AccessCreate , MAX(a.accessModify) AS accessModify, 
			MAX(a.AccessDelete) AS AccessDelete , MAX(a.AccessPrint) AS AccessPrint, MAX(a.AccessRemove) AS AccessRemove
		FROM sAccessGroupLinePlanTab a
			INNER JOIN sAccessGroupLinePlanFolder b ON b.AccessLinePlanId =  a.AccessLinePlanId
			INNER JOIN dbo.pLinePlanFolderTab c ON c.LinePlanFolderTabID =  a.LinePlanFolderTabID
			INNER JOIN dbo.pLinePlanTab d ON d.LinePlanTabID =  c.LinePlanTabID
			INNER JOIN dbo.uUserGroup e ON e.GroupID =  b.GroupID 
				AND e.TeamID = @TeamID
		WHERE  b.CustomID = @TemplateItemValue  
		AND a.LinePlanTemplateID = @TemplateID 
		GROUP BY d.LinePlanTabName,a.LinePlanTemplateID, d.LinePlanTabSort
		ORDER BY d.LinePlanTabSort

	END

	ELSE  IF @nDeskFolderId = 14
		SELECT @nDeskFolderId AS DeskFolderID, b.BodyTypeDescription as TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify, 0 as AccessRemove,  a.AccessDelete, a.AccessPrint, a.AccessCreate 
		FROM  sAccessBodyFolder a 
		INNER JOIN pBodyType b ON a.BodyTypeId = b.BodyTypeID
		WHERE a.TeamId = @TeamID
		ORDER BY b.BodyTypeDescription

	ELSE  IF @nDeskFolderId = 15
		SELECT @nDeskFolderId AS DeskFolderID, b.FlashEditItemName as TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify, 0 as AccessRemove,  a.AccessDelete, a.AccessPrint, a.AccessCreate 
		FROM  sAccessFlashEditFolder  a INNER JOIN pFlashEditFolderItem  b ON a.FlashEditFolderItemId  = b.FlashEditFolderItemId
		WHERE a.TeamId = @TeamID
		ORDER BY b.FlashEditItemName

	ELSE  IF @nDeskFolderId = 16
		SELECT @nDeskFolderId AS DeskFolderID, b.BatchQueueTypeDescription as TypeDescription, a.AccessRoleId, a.AccessView, a.AccessModify, 0 as AccessRemove, a.AccessDelete, a.AccessPrint, a.AccessCreate 
		FROM  sAccessBatchQueue a INNER JOIN bBatchQueueType b ON a.BatchQueueTypeID = b.BatchQueueTypeID
		WHERE a.TeamId = @TeamID
		ORDER BY b.BatchQueueTypeDescription

	ELSE  IF @nDeskFolderId = 18
		SELECT @nDeskFolderId AS DeskFolderID, b.BatchQueueTypeName as TypeDescription, a.AccessRoleId, a.AccessView, a.AccessModify, 0 as AccessRemove, a.AccessDelete, a.AccessPrint, a.AccessCreate 
		FROM  sAccessBatchQFolder a 
		INNER JOIN pBatchQueueType b ON a.BatchQTypeId = b.BatchQueueTypeID
		WHERE a.TeamId = @TeamID
		ORDER BY b.BatchQueueTypeName
	ELSE IF @nDeskFolderId  = 19  
		SELECT @nDeskFolderId AS DeskFolderID, 'Sourcing Folder' AS  TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify, 0 AS AccessRemove, a.AccessDelete, a.AccessPrint , a.AccessCreate
		FROM  sAccessSourcingFolder  a 
		WHERE a.TeamId = @TeamID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04056', GetDate())

GO
