IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Group_Permission_Summary_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Group_Permission_Summary_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[rpx_Group_Permission_Summary_SELECT]
	@GroupID uniqueidentifier
AS
BEGIN
	SELECT
		1 AS GID
		, 'Style Folder' AS GName
		, b.StyleTypeDescription AS TypeDescription
		, b.StyleTypeOrder AS SortOrder
		, max(a.AccessRoleId) AS AccessRoleId
		, max(a.AccessView) AS AccessView
		, max(a.AccessModify) AS AccessModify
		, max(a.AccessRemove) AS AccessRemove
		, max(a.AccessDelete) AS AccessDelete
		, max(a.AccessPrint) AS AccessPrint
		, max(a.AccessCreate) AS AccessCreate
	FROM
		sAccessGroupStyleFolder a
		INNER JOIN pStyleType b ON A.StyleTypeID = b.StyleTypeID
		INNER JOIN cDeskGroupFolderAccess d ON a.GroupID = d.GroupID AND d.DeskFolderId = 2
	WHERE
		a.GroupID = @GroupID
		AND d.DeskAccessId = 1
	GROUP BY
		b.StyleTypeDescription
		, b.StyleTypeOrder

	UNION

	SELECT
		2 AS GID
		, 'Line List Folder' AS GName
		, 'Line Folder' AS  TypeDescription
		, 0 AS SortOrder
		, a.AccessRoleId AS AccessRoleId
		, a.AccessView AS AccessView
		, a.AccessModify AS AccessModify
		, NULL AS AccessRemove
		, a.AccessDelete AS AccessDelete
		, a.AccessPrint AS AccessPrint
		, a.AccessCreate AS AccessCreate
	FROM
		sAccessGroupLineFolder  a
		INNER JOIN cDeskGroupFolderAccess d ON a.GroupID = d.GroupID AND d.DeskFolderId = 3
	WHERE
		a.GroupId = @GroupId
		AND d.DeskAccessId = 1 
		
	UNION

	SELECT
		3 AS GID
		, 'Quotation Folder' AS GName
		, b.StyleTypeDescription AS TypeDescription
		, b.StyleTypeOrder AS SortOrder
		, max(a.AccessRoleId) AS AccessRoleId
		, max(a.AccessView) AS AccessView
		, max(a.AccessModify) AS AccessModify
		, NULL AS AccessRemove
		, max(a.AccessDelete) AS AccessDelete
		, max(a.AccessPrint) AS AccessPrint
		, max(a.AccessCreate) AS AccessCreate
	FROM
		sAccessGroupQuotationFolder a
		INNER JOIN pStyleType b ON A.StyleTypeID = b.StyleTypeID
		INNER JOIN cDeskGroupFolderAccess d ON a.GroupID = d.GroupID AND d.DeskFolderId = 4
	WHERE
		a.GroupId = @GroupId
		AND d.DeskAccessId = 1 
	GROUP BY
		b.StyleTypeDescription
		, b.StyleTypeOrder
		
	UNION

	SELECT
		4 AS GID
		, 'Sample Folder' AS GName
		, b.SampleWorkflow AS TypeDescription
		, b.SampleWorkflowSort AS SortOrder
		, max(a.AccessRoleId) AS AccessRoleId
		, max(a.AccessView) AS AccessView
		, max(a.AccessModify) AS AccessModify
		, max(a.AccessRemove) AS AccessRemove
		, max(a.AccessDelete) AS AccessDelete
		, max(a.AccessPrint) AS AccessPrint
		, max(a.AccessCreate) AS AccessCreate
	FROM
		sAccessGroupSampleFolder a
		INNER JOIN pSampleWorkflow b ON a.SampleTypeID = b.SampleWorkflowID
		INNER JOIN cDeskGroupFolderAccess d ON a.GroupID = d.GroupID AND d.DeskFolderId = 5
	WHERE
		a.GroupId = @GroupId
		AND d.DeskAccessId = 1 
	GROUP BY
		b.SampleWorkflow
		, b.SampleWorkflowSort

	UNION

	SELECT
		5 AS GID
		, 'Image Folder' AS GName
		, b.ImageType  AS TypeDescription
		, b.ImageOrder AS SortOrder
		, max(a.AccessRoleId) AS AccessRoleId
		, max(a.AccessView) AS AccessView
		, max(a.AccessModify) AS AccessModify
		, NULL AS AccessRemove
		, max(a.AccessDelete) AS AccessDelete
		, max(a.AccessPrint) AS AccessPrint
		, max(a.AccessCreate) AS AccessCreate
	FROM
		sAccessGroupImageFolder a
		INNER JOIN pImageType b ON a.ImageTypeId = b.ImageTypeId 
		INNER JOIN cDeskGroupFolderAccess d ON a.GroupID = d.GroupID AND d.DeskFolderId = 6
	WHERE
		a.GroupId = @GroupId
		AND d.DeskAccessId = 1 
	GROUP BY
		b.ImageType
		, b.ImageOrder

	UNION

	SELECT
		6 AS GID
		, 'Color Folder' AS GName
		, b.ColorTypeDescription AS TypeDescription
		, b.Sort AS SortOrder
		, max(a.AccessRoleID) AS AccessRoleID
		, max(a.AccessView) AS AccessView
		, max(a.AccessModify) AS AccessModify
		, NULL AS AccessRemove
		, max(a.AccessDelete) AS AccessDelete
		, max(a.AccessPrint) AS AccessPrint
		, max(a.AccessCreate) AS AccessCreate
	FROM
		sAccessGroupColorFolder  a 
		INNER JOIN pColorType b ON a.ColorTypeID =  b.ColorTypeID
		INNER JOIN cDeskGroupFolderAccess d ON a.GroupID = d.GroupID AND d.DeskFolderId = 7
	WHERE
		a.GroupId = @GroupId
		AND d.DeskAccessId = 1 
	GROUP BY
		b.ColorTypeDescription, b.Sort

	UNION
		
	SELECT
		7 AS GID
		, 'Material Folder' AS GName
		, b.ComponentDescription  AS TypeDescription
		, b.ComponentOrder AS SortOrder
		, max(a.AccessRoleId) AS AccessRoleId
		, max(a.AccessView) AS AccessView
		, max(a.AccessModify) AS AccessModify
		, NULL AS AccessRemove
		, max(a.AccessDelete) AS AccessDelete
		, max(a.AccessPrint) AS AccessPrint
		, max(a.AccessCreate) AS AccessCreate
	FROM
		sAccessGroupMaterialFolder a
		INNER JOIN pComponentType  b ON a.ComponentTypeID  = b.ComponentTypeId 
		INNER JOIN cDeskGroupFolderAccess d ON a.GroupID = d.GroupID AND d.DeskFolderId = 8
	WHERE
		a.GroupId = @GroupId
		AND d.DeskAccessId = 1 
	GROUP BY
		b.ComponentDescription
		, b.ComponentOrder

	UNION

	SELECT
		8 AS GID
		, 'Compliance Folder' AS GName
		, b.ComplianceType AS TypeDescription
		, b.ComplianceOrder AS SortOrder
		, max(a.AccessRoleId) AS AccessRoleId
		, max(a.AccessView) AS AccessView
		, max(a.AccessModify) AS AccessModify
		, NULL AS AccessRemove
		, max(a.AccessDelete) AS AccessDelete
		, max(a.AccessPrint) AS AccessPrint
		, max(a.AccessCreate) AS AccessCreate
	FROM
		sAccessGroupComplianceFolder a
		INNER JOIN pComplianceType  b ON a.ComplianceTypeId  = b.ComplianceTypeId 
		INNER JOIN cDeskGroupFolderAccess d ON a.GroupID = d.GroupID AND d.DeskFolderId = 9
	WHERE
		a.GroupId = @GroupId
		AND d.DeskAccessId = 1 
	GROUP BY
		b.ComplianceType
		, b.ComplianceOrder

	UNION

	SELECT
		9 AS GID
		, 'Control Panel' AS GName
		, b.ControlPanelName AS TypeDescription
		, b.ControlPanelOrder AS SortOrder
		, max(a.AccessRoleId) AS AccessRoleId
		, max(a.AccessView) AS AccessView
		, max(a.AccessModify) AS AccessModify
		, NULL AS AccessRemove
		, max(a.AccessDelete) AS AccessDelete
		, max(a.AccessPrint) AS AccessPrint
		, max(a.AccessCreate) AS AccessCreate
	FROM
		sAccessGroupControlPanel a
		INNER JOIN pControlPanel  b ON a.ControlPanelId  = b.ControlPanelId
		INNER JOIN cDeskGroupFolderAccess d ON a.GroupID = d.GroupID AND d.DeskFolderId = 10
	WHERE
		a.GroupId = @GroupId
		AND b.IsDataValidation = 0
		AND d.DeskAccessId = 1 
	GROUP BY
		b.ControlPanelName
		, b.ControlPanelOrder

	UNION

	SELECT
		10 AS GID
		, 'Shared Folder' AS GName
		, 'Share Folder' AS  TypeDescription
		, 0 AS SortOrder
		, a.AccessRoleId AS AccessRoleId
		, a.AccessView AS AccessView
		, a.AccessModify AS AccessModify
		, NULL AS AccessRemove
		, a.AccessDelete AS AccessDelete
		, a.AccessPrint AS AccessPrint
		, a.AccessCreate AS AccessCreate
	FROM
		sAccessGroupShareFolder a 
		INNER JOIN cDeskGroupFolderAccess d ON a.GroupID = d.GroupID AND d.DeskFolderId = 11
	WHERE
		a.GroupId = @GroupId
		AND d.DeskAccessId = 1 

	UNION

	SELECT
		11 AS GID
		, 'Costing' AS GName
		, b.StyleTypeDescription AS TypeDescription
		, b.StyleTypeOrder AS SortOrder
		, max(a.AccessRoleId) AS AccessRoleId
		, max(a.AccessView) AS AccessView
		, max(a.AccessModify) AS AccessModify
		, NULL AS AccessRemove
		, max(a.AccessDelete) AS AccessDelete
		, max(a.AccessPrint) AS AccessPrint
		, max(a.AccessCreate) AS AccessCreate
	FROM
		sAccessGroupCosting a
		INNER JOIN pStyleType b ON a.StyleTypeID = b.StyleTypeID
		INNER JOIN cDeskGroupFolderAccess d ON a.GroupID = d.GroupID AND d.DeskFolderId = 12
	WHERE
		a.GroupId = @GroupId
		AND d.DeskAccessId = 1 
	GROUP BY
		b.StyleTypeDescription
		, b.StyleTypeOrder
		
	UNION

	SELECT
		12 AS GID
		, 'Line Plan - ' + g.LinePlanTemplateName + ' - ' + h.Custom AS GName
		, d.LinePlanTabName AS TypeDescription
		, d.LinePlanTabSort AS SortOrder
		, MAX(a.AccessRoleId) AS AccessRoleId
		, MAX(a.AccessView) AS AccessView
		, MAX(a.accessModify) AS AccessModify
		, MAX(a.AccessRemove) AS AccessRemove
		, MAX(a.AccessDelete) AS AccessDelete
		, MAX(a.AccessPrint) AS AccessPrint
		, MAX(a.AccessCreate) AS AccessCreate
	FROM
		sAccessGroupLinePlanTab a
		INNER JOIN sAccessGroupLinePlanFolder b ON b.AccessLinePlanId =  a.AccessLinePlanId
		INNER JOIN dbo.pLinePlanFolderTab c ON c.LinePlanFolderTabID =  a.LinePlanFolderTabID
		INNER JOIN dbo.pLinePlanTab d ON d.LinePlanTabID =  c.LinePlanTabID
		INNER JOIN dbo.pLinePlanTemplate g ON g.LinePlanTemplateID = a.LinePlanTemplateID
		INNER JOIN iCustom1 h on b.CustomID = h.CustomID
		INNER JOIN cDeskGroupFolderAccess x ON b.GroupID = x.GroupID AND x.DeskFolderId = 13
	WHERE
		b.GroupID = @GroupId
		AND x.DeskAccessId = 1 
	GROUP BY
		d.LinePlanTabName
		, g.LinePlanTemplateName
		, h.Custom
		, d.LinePlanTabSort

	UNION

	SELECT
		13 AS GID
		, 'Body' AS GName
		, b.BodyTypeDescription AS TypeDescription
		, 0 AS SortOrder
		, max(a.AccessRoleId) AS AccessRoleId
		, max(a.AccessView) AS AccessView
		, max(a.AccessModify) AS AccessModify
		, NULL AS AccessRemove
		, max(a.AccessDelete) AS AccessDelete
		, max(a.AccessPrint) AS AccessPrint
		, max(a.AccessCreate) AS AccessCreate
	FROM
		sAccessGroupBodyFolder a 
		INNER JOIN pBodyType b ON a.BodyTypeId = b.BodyTypeID
		INNER JOIN cDeskGroupFolderAccess d ON a.GroupID = d.GroupID AND d.DeskFolderId = 14
	WHERE
		a.GroupId = @GroupId
		AND d.DeskAccessId = 1 
	GROUP BY
		b.BodyTypeDescription

	UNION

	SELECT
		14 AS GID
		, 'Flash Edit' AS GName
		, b.FlashEditItemName AS TypeDescription
		, 0 AS SortOrder
		, max(a.AccessRoleId) AS AccessRoleId
		, max(a.AccessView) AS AccessView
		, max(a.AccessModify) AS AccessModify
		, NULL AS AccessRemove
		, max(a.AccessDelete) AS AccessDelete
		, max(a.AccessPrint) AS AccessPrint
		, max(a.AccessCreate) AS AccessCreate
	FROM
		sAccessGroupFlashEditFolder a
		INNER JOIN pFlashEditFolderItem b ON a.FlashEditFolderItemId  = b.FlashEditFolderItemId
		INNER JOIN cDeskGroupFolderAccess d ON a.GroupID = d.GroupID AND d.DeskFolderId = 15
	WHERE
		a.GroupId = @GroupId
		AND d.DeskAccessId = 1 
	GROUP BY
		b.FlashEditItemName

	UNION

	SELECT
		15 AS GID
		, 'BI Folder - ' + a.BITypeDesc AS GName
		, b.Description AS TypeDescription
		, 0 AS SortOrder
		, max(a.AccessRoleId) AS AccessRoleId
		, max(a.AccessView) AS AccessView
		, max(a.AccessModify) AS AccessModify
		, NULL AS AccessRemove
		, max(a.AccessDelete) AS AccessDelete
		, max(a.AccessPrint) AS AccessPrint
		, max(a.AccessCreate) AS AccessCreate
	FROM
		sAccessBIFolder a
		INNER JOIN sAccessBIItemsFolder b ON a.BITypeId = b.BITypeId
		INNER JOIN cDeskGroupFolderAccess d ON a.GroupID = d.GroupID AND d.DeskFolderId = 17
	WHERE
		a.GroupID = @GroupId
		AND d.DeskAccessId = 1 
	GROUP BY
		a.BITypeDesc
		, b.Description

	UNION

	SELECT
		16 AS GID
		, 'BatchQ Folder' AS GName
		, b.BatchQueueTypeName AS TypeDescription
		, 0 AS SortOrder
		, max(a.AccessRoleId) AS AccessRoleId
		, max(a.AccessView) AS AccessView
		, max(a.AccessModify) AS AccessModify
		, NULL AS AccessRemove
		, max(a.AccessDelete) AS AccessDelete
		, max(a.AccessPrint) AS AccessPrint
		, max(a.AccessCreate) AS AccessCreate
	FROM
		sAccessBatchQFolder a 
		INNER JOIN pBatchQueueType b ON a.BatchQTypeId = b.BatchQueueTypeID
		INNER JOIN cDeskGroupFolderAccess d ON a.GroupID = d.GroupID AND d.DeskFolderId = 18
	WHERE
		a.GroupId = @GroupId
		AND d.DeskAccessId = 1 
	GROUP BY
		b.BatchQueueTypeName

	UNION

	SELECT
		17 AS GID
		, 'Sourcing Folder' AS GName
		, 'Sourcing Folder' AS TypeDescription
		, 0 AS SortOrder
		, a.AccessRoleId AS AccessRoleId
		, a.AccessView AS AccessView
		, a.AccessModify AS AccessModify
		, NULL AS AccessRemove
		, a.AccessDelete AS AccessDelete
		, a.AccessPrint AS AccessPrint
		, a.AccessCreate AS AccessCreate
	FROM
		sAccessGroupSourcingFolder  a 
		INNER JOIN cDeskGroupFolderAccess d ON a.GroupID = d.GroupID AND d.DeskFolderId = 19
	WHERE
		a.GroupId = @GroupId
		AND d.DeskAccessId = 1 
		
	ORDER BY
		GID
		, SortOrder
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04723', GetDate())
GO
