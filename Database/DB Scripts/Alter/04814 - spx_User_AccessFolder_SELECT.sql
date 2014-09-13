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
	@TemplateItemValue UNIQUEIDENTIFIER,
	@BIType INT = null
)
AS
BEGIN
	IF  @nDeskFolderId  = 2  
		SELECT @nDeskFolderId AS DeskFolderID, b.StyleTypeDescription AS TypeDescription, b.StyleTypeOrder, 
			max(a.AccessRoleId) as AccessRoleId, max(a.AccessView) as AccessView, max(a.AccessModify) as AccessModify, 
			max(a.AccessRemove) as AccessRemove, max(a.AccessDelete) as AccessDelete, max(a.AccessPrint) as AccessPrint, 
			max(a.AccessCreate) as AccessCreate
		FROM  sAccessStyleFolder a INNER JOIN pStyleType b ON A.StyleTypeID = b.StyleTypeID
		INNER JOIN uUserGroup c ON c.TeamID = a.TeamId
		INNER JOIN uGroup d ON d.GroupID = c.GroupID
		WHERE d.Active = 1
		AND a.TeamId = @TeamID
		GROUP BY b.StyleTypeDescription, b.StyleTypeOrder
		ORDER BY b.StyleTypeOrder

	ELSE IF @nDeskFolderId  = 3  
		SELECT @nDeskFolderId AS DeskFolderID, 'Line Folder' AS  TypeDescription , 
		max(a.AccessRoleId) as AccessRoleId, max(a.AccessView) as AccessView, max(a.AccessModify) as AccessModify, 0 AS AccessRemove, 
		max(a.AccessDelete) as AccessDelete, max(a.AccessPrint) as AccessPrint, max(a.AccessCreate) as AccessCreate
		FROM  sAccessLineFolder  a 
		INNER JOIN uUserGroup c ON c.TeamID = a.TeamId
		INNER JOIN uGroup d ON d.GroupID = c.GroupID
		WHERE d.Active = 1
		AND a.TeamId = @TeamID

	ELSE  IF @nDeskFolderId  = 4
		SELECT @nDeskFolderId AS DeskFolderID, b.StyleTypeDescription AS TypeDescription, b.StyleTypeOrder, 
		max(a.AccessRoleId) as AccessRoleId, max(a.AccessView) as AccessView, max(a.AccessModify) as AccessModify, 0 AS AccessRemove, 
		max(a.AccessDelete) as AccessDelete, max(a.AccessPrint) as AccessPrint, max(a.AccessCreate) as AccessCreate
		FROM  sAccessQuotationFolder a INNER JOIN pStyleType b ON A.StyleTypeID = b.StyleTypeID
		INNER JOIN uUserGroup c ON c.TeamID = a.TeamId
		INNER JOIN uGroup d ON d.GroupID = c.GroupID
		WHERE d.Active = 1
		AND a.TeamId = @TeamID
		GROUP BY b.StyleTypeDescription, b.StyleTypeOrder
		ORDER BY StyleTypeOrder

	ELSE  IF @nDeskFolderId  = 5
		SELECT @nDeskFolderId AS DeskFolderID, b.SampleWorkflow AS TypeDescription, b.SampleWorkflowSort, 
		max(a.AccessRoleId) as AccessRoleId, max(a.AccessView) as AccessView, max(a.AccessModify) as AccessModify, 
		max(a.AccessRemove) as AccessRemove, max(a.AccessDelete) as AccessDelete, max(a.AccessPrint) as AccessPrint, max(a.AccessCreate) as AccessCreate
		FROM  sAccessSampleFolder a INNER JOIN pSampleWorkflow b ON a.SampleTypeID = b.SampleWorkflowID
		INNER JOIN uUserGroup c ON c.TeamID = a.TeamId
		INNER JOIN uGroup d ON d.GroupID = c.GroupID
		WHERE d.Active = 1
		AND a.TeamId = @TeamID
		GROUP BY b.SampleWorkflow, b.SampleWorkflowSort
		ORDER BY b.SampleWorkflowSort

	ELSE  IF @nDeskFolderId  = 6
		SELECT @nDeskFolderId AS DeskFolderID, b.ImageType  AS TypeDescription, b.ImageOrder, 
		max(a.AccessRoleId) as AccessRoleId, max(a.AccessView) as AccessView, max(a.AccessModify) as AccessModify,  0 AS AccessRemove, 
		max(a.AccessDelete) as AccessDelete, max(a.AccessPrint) as AccessPrint, max(a.AccessCreate) as AccessCreate
		FROM  sAccessImageFolder a INNER JOIN pImageType b ON a.ImageTypeId = b.ImageTypeId 
		INNER JOIN uUserGroup c ON c.TeamID = a.TeamId
		INNER JOIN uGroup d ON d.GroupID = c.GroupID
		WHERE d.Active = 1
		AND a.TeamId = @TeamID
		AND b.Active = 1
		GROUP BY b.ImageType, b.ImageOrder
		ORDER BY b.ImageOrder

	ELSE  IF @nDeskFolderId  = 7
	/*
		SELECT @nDeskFolderId AS DeskFolderID, 'Color Folder' as  TypeDescription , a.AccessRoleId , a.AccessView, a.AccessModify,  0 as AccessRemove, a.AccessDelete, a.AccessPrint, a.AccessCreate 
		FROM  sAccessColorFolder  a 
		WHERE a.TeamId = @TeamID
	*/
		SELECT @nDeskFolderId AS DeskFolderID, b.ColorTypeDescription AS TypeDescription, b.Sort, 
		max(a.AccessRoleID) as AccessRoleID, max(a.AccessView) as AccessView, max(a.AccessModify) as AccessModify, 
		max(a.AccessDelete) as AccessDelete, max(a.AccessPrint) as AccessPrint, max(a.AccessCreate) as AccessCreate, 0 AS AccessRemove
		FROM  sAccessColorFolder  a 
		INNER JOIN pColorType b ON a.ColorTypeID =  b.ColorTypeID
		INNER JOIN uUserGroup c ON c.TeamID = a.TeamId
		INNER JOIN uGroup d ON d.GroupID = c.GroupID
		WHERE d.Active = 1
		AND a.TeamID = @TeamID
		GROUP BY b.ColorTypeDescription, b.Sort
		ORDER BY b.Sort

	ELSE  IF @nDeskFolderId  = 8
		SELECT @nDeskFolderId AS DeskFolderID, b.ComponentDescription  AS TypeDescription, b.ComponentOrder, 
		max(a.AccessRoleId) as AccessRoleId, max(a.AccessView) as AccessView, max(a.AccessModify) as AccessModify, 0 AS AccessRemove, 
		max(a.AccessDelete) as AccessDelete, max(a.AccessPrint) as AccessPrint, max(a.AccessCreate) as AccessCreate
		FROM  sAccessMaterialFolder  a INNER JOIN pComponentType  b ON a.ComponentTypeID  = b.ComponentTypeId 
		INNER JOIN uUserGroup c ON c.TeamID = a.TeamId
		INNER JOIN uGroup d ON d.GroupID = c.GroupID
		WHERE d.Active = 1
		AND a.TeamId = @TeamID
		GROUP BY b.ComponentDescription, b.ComponentOrder
		ORDER BY b.ComponentOrder

	ELSE  IF @nDeskFolderId  = 9
		SELECT @nDeskFolderId AS DeskFolderID, b.ComplianceType AS TypeDescription, b.ComplianceOrder, 
		max(a.AccessRoleId) as AccessRoleId, max(a.AccessView) as AccessView, max(a.AccessModify) as AccessModify, 0 AS AccessRemove, 
		max(a.AccessDelete) as AccessDelete, max(a.AccessPrint) as AccessPrint, max(a.AccessCreate) as AccessCreate
		FROM  sAccessComplianceFolder a INNER JOIN pComplianceType  b ON a.ComplianceTypeId  = b.ComplianceTypeId 
		INNER JOIN uUserGroup c ON c.TeamID = a.TeamId
		INNER JOIN uGroup d ON d.GroupID = c.GroupID
		WHERE d.Active = 1
		AND a.TeamId = @TeamID
		GROUP BY b.ComplianceType, b.ComplianceOrder
		ORDER BY b.ComplianceOrder, b.ComplianceType

	ELSE  IF @nDeskFolderId  = 10
		SELECT @nDeskFolderId AS DeskFolderID, b.ControlPanelName AS TypeDescription, b.ControlPanelOrder, 
		max(a.AccessRoleId) as AccessRoleId, max(a.AccessView) as AccessView, max(a.AccessModify) as AccessModify, 0 AS AccessRemove, 
		max(a.AccessDelete) as AccessDelete, max(a.AccessPrint) as AccessPrint, max(a.AccessCreate) as AccessCreate
		FROM  sAccessControlPanel  a INNER JOIN pControlPanel  b ON a.ControlPanelId  = b.ControlPanelId
		INNER JOIN uUserGroup c ON c.TeamID = a.TeamId
		INNER JOIN uGroup d ON d.GroupID = c.GroupID
		WHERE d.Active = 1
		AND a.TeamId = @TeamID
		AND b.IsDataValidation = 0
		GROUP BY b.ControlPanelName, b.ControlPanelOrder
		ORDER BY b.ControlPanelOrder

	ELSE  IF @nDeskFolderId  = 11
		SELECT @nDeskFolderId AS DeskFolderID, 'Share Folder' AS  TypeDescription, 
		max(a.AccessRoleId) as AccessRoleId, max(a.AccessView) as AccessView, max(a.AccessModify) as AccessModify, 0 AS AccessRemove, 
		max(a.AccessDelete) as AccessDelete, max(a.AccessPrint) as AccessPrint, max(a.AccessCreate) as AccessCreate
		FROM  sAccessShareFolder a 
		INNER JOIN uUserGroup c ON c.TeamID = a.TeamId
		INNER JOIN uGroup d ON d.GroupID = c.GroupID
		WHERE d.Active = 1
		AND a.TeamId = @TeamID

	ELSE  IF @nDeskFolderId  = 12
		SELECT @nDeskFolderId AS DeskFolderID, b.StyleTypeDescription AS TypeDescription, b.StyleTypeOrder, 
		max(a.AccessRoleId) as AccessRoleId, max(a.AccessView) as AccessView, max(a.AccessModify) as AccessModify, 0 AS AccessRemove, 
		max(a.AccessDelete) as AccessDelete, max(a.AccessPrint) as AccessPrint, max(a.AccessCreate) as AccessCreate
		FROM  sAccessCosting  a INNER JOIN pStyleType b ON a.StyleTypeID = b.StyleTypeID
		INNER JOIN uUserGroup c ON c.TeamID = a.TeamId
		INNER JOIN uGroup d ON d.GroupID = c.GroupID
		WHERE d.Active = 1
		AND a.TeamId = @TeamID
		GROUP BY b.StyleTypeDescription, b.StyleTypeOrder
		ORDER BY b.StyleTypeOrder

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
			INNER JOIN dbo.uGroup f ON f.GroupID = b.GroupID
		WHERE  b.CustomID = @TemplateItemValue  
		AND a.LinePlanTemplateID = @TemplateID
		AND f.Active = 1
		GROUP BY d.LinePlanTabName,a.LinePlanTemplateID, d.LinePlanTabSort
		ORDER BY d.LinePlanTabSort

	END

	ELSE  IF @nDeskFolderId = 14
		SELECT @nDeskFolderId AS DeskFolderID, b.BodyTypeDescription as TypeDescription, 
		max(a.AccessRoleId) as AccessRoleId, max(a.AccessView) as AccessView, max(a.AccessModify) as AccessModify, 0 as AccessRemove, 
		max(a.AccessDelete) as AccessDelete, max(a.AccessPrint) as AccessPrint, max(a.AccessCreate) as AccessCreate
		FROM  sAccessBodyFolder a 
		INNER JOIN pBodyType b ON a.BodyTypeId = b.BodyTypeID
		INNER JOIN uUserGroup c ON c.TeamID = a.TeamId
		INNER JOIN uGroup d ON d.GroupID = c.GroupID
		WHERE d.Active = 1
		AND a.TeamId = @TeamID
		GROUP BY b.BodyTypeDescription
		ORDER BY b.BodyTypeDescription

	ELSE  IF @nDeskFolderId = 15
		SELECT @nDeskFolderId AS DeskFolderID, b.FlashEditItemName as TypeDescription , 
		max(a.AccessRoleId) as AccessRoleId, max(a.AccessView) as AccessView, max(a.AccessModify) as AccessModify, 0 as AccessRemove, 
		max(a.AccessDelete) as AccessDelete, max(a.AccessPrint) as AccessPrint, max(a.AccessCreate) as AccessCreate
		FROM  sAccessFlashEditFolder  a INNER JOIN pFlashEditFolderItem  b ON a.FlashEditFolderItemId  = b.FlashEditFolderItemId
		INNER JOIN uUserGroup c ON c.TeamID = a.TeamId
		INNER JOIN uGroup d ON d.GroupID = c.GroupID
		WHERE d.Active = 1
		AND a.TeamId = @TeamID
		GROUP BY b.FlashEditItemName
		ORDER BY b.FlashEditItemName

	ELSE  IF @nDeskFolderId = 16
		SELECT @nDeskFolderId AS DeskFolderID, b.BatchQueueTypeDescription as TypeDescription, 
		max(a.AccessRoleId) as AccessRoleId, max(a.AccessView) as AccessView, max(a.AccessModify) as AccessModify, 0 as AccessRemove, 
		max(a.AccessDelete) as AccessDelete, max(a.AccessPrint) as AccessPrint, max(a.AccessCreate) as AccessCreate
		FROM  sAccessBatchQueue a INNER JOIN bBatchQueueType b ON a.BatchQueueTypeID = b.BatchQueueTypeID
		INNER JOIN uUserGroup c ON c.TeamID = a.TeamId
		INNER JOIN uGroup d ON d.GroupID = c.GroupID
		WHERE d.Active = 1
		AND a.TeamId = @TeamID
		GROUP BY b.BatchQueueTypeDescription
		ORDER BY b.BatchQueueTypeDescription

	ELSE  IF @nDeskFolderId = 17
		SELECT
			@nDeskFolderId AS DeskFolderID
			, a.Description AS TypeDescription
			, d.BITypeDesc
			, max(a.AccessRoleId) AS AccessRoleId
			, 0 AS AccessView
			, 0 AS AccessModify
			, 0 AS AccessRemove
			, 0 AS AccessDelete
			, 0 AS AccessPrint
			, 0 AS AccessCreate
		FROM
			sAccessBIItems a
			INNER JOIN uGroup b ON b.GroupID = a.GroupID
			INNER JOIN uUserGroup c ON c.GroupID = b.GroupID
			LEFT OUTER JOIN sAccessBIFolder d ON d.BITypeId = a.BITypeId
		WHERE
			b.Active = 1
			AND c.TeamId = @TeamID
			AND (a.ItemID IN (select ReportFolderItemID from rReportFolderItem) OR a.ItemID IN (select DashFolderItemID from rDashFolderItem))
			AND a.BITypeId = @BIType
		GROUP BY
			 d.BITypeDesc
			 , a.Description
		ORDER BY
			d.BITypeDesc
			, TypeDescription

	ELSE  IF @nDeskFolderId = 18
		SELECT @nDeskFolderId AS DeskFolderID, b.BatchQueueTypeName as TypeDescription, 
		max(a.AccessRoleId) as AccessRoleId, max(a.AccessView) as AccessView, max(a.AccessModify) as AccessModify, 0 as AccessRemove, 
		max(a.AccessDelete) as AccessDelete, max(a.AccessPrint) as AccessPrint, max(a.AccessCreate) as AccessCreate
		FROM  sAccessBatchQFolder a 
		INNER JOIN pBatchQueueType b ON a.BatchQTypeId = b.BatchQueueTypeID
		INNER JOIN uUserGroup c ON c.TeamID = a.TeamId
		INNER JOIN uGroup d ON d.GroupID = c.GroupID
		WHERE d.Active = 1
		AND a.TeamId = @TeamID
		GROUP BY b.BatchQueueTypeName
		ORDER BY b.BatchQueueTypeName

	ELSE IF @nDeskFolderId  = 19  
		SELECT @nDeskFolderId AS DeskFolderID, 'Sourcing Folder' AS  TypeDescription, 
		max(a.AccessRoleId) as AccessRoleId, max(a.AccessView) as AccessView, max(a.AccessModify) as AccessModify, 0 AS AccessRemove, 
		max(a.AccessDelete) as AccessDelete, max(a.AccessPrint) as AccessPrint, max(a.AccessCreate) as AccessCreate
		FROM  sAccessSourcingFolder  a 
		INNER JOIN uUserGroup c ON c.TeamID = a.TeamId
		INNER JOIN uGroup d ON d.GroupID = c.GroupID
		WHERE d.Active = 1
		AND a.TeamId = @TeamID
		
END


GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04814', GetDate())
GO