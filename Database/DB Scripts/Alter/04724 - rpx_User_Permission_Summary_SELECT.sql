IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_User_Permission_Summary_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_User_Permission_Summary_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[rpx_User_Permission_Summary_SELECT]
	@TeamID uniqueidentifier
AS
BEGIN
	SELECT
		1 AS GID
		, 'Style Folder' AS GName
		, b.StyleTypeDescription AS TypeDescription
		, b.StyleTypeOrder AS SortOrder
		, a.AccessRoleId AS AccessRoleId
		, a.AccessView AS AccessView
		, a.AccessModify AS AccessModify
		, a.AccessRemove AS AccessRemove
		, a.AccessDelete AS AccessDelete
		, a.AccessPrint AS AccessPrint
		, a.AccessCreate AS AccessCreate
	FROM
		sAccessStyleFolder a
		INNER JOIN pStyleType b ON A.StyleTypeID = b.StyleTypeID
	WHERE
		a.TeamId = @TeamID

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
		sAccessLineFolder  a
	WHERE
		a.TeamId = @TeamID

	UNION

	SELECT
		3 AS GID
		, 'Quotation Folder' AS GName
		, b.StyleTypeDescription AS TypeDescription
		, b.StyleTypeOrder AS SortOrder
		, a.AccessRoleId AS AccessRoleId
		, a.AccessView AS AccessView
		, a.AccessModify AS AccessModify
		, NULL AS AccessRemove
		, a.AccessDelete AS AccessDelete
		, a.AccessPrint AS AccessPrint
		, a.AccessCreate AS AccessCreate
	FROM
		sAccessQuotationFolder a
		INNER JOIN pStyleType b ON A.StyleTypeID = b.StyleTypeID
	WHERE
		a.TeamId = @TeamID
		
	UNION

	SELECT
		4 AS GID
		, 'Sample Folder' AS GName
		, b.SampleWorkflow AS TypeDescription
		, b.SampleWorkflowSort AS SortOrder
		, a.AccessRoleId AS AccessRoleId
		, a.AccessView AS AccessView
		, a.AccessModify AS AccessModify
		, a.AccessRemove AS AccessRemove
		, a.AccessDelete AS AccessDelete
		, a.AccessPrint AS AccessPrint
		, a.AccessCreate AS AccessCreate
	FROM
		sAccessSampleFolder a
		INNER JOIN pSampleWorkflow b ON a.SampleTypeID = b.SampleWorkflowID
	WHERE
		a.TeamId = @TeamID
		
	UNION

	SELECT
		5 AS GID
		, 'Image Folder' AS GName
		, b.ImageType  AS TypeDescription
		, b.ImageOrder AS SortOrder
		, a.AccessRoleId AS AccessRoleId
		, a.AccessView AS AccessView
		, a.AccessModify AS AccessModify
		, NULL AS AccessRemove
		, a.AccessDelete AS AccessDelete
		, a.AccessPrint AS AccessPrint
		, a.AccessCreate AS AccessCreate
	FROM
		sAccessImageFolder a
		INNER JOIN pImageType b ON a.ImageTypeId = b.ImageTypeId 
	WHERE
		a.TeamId = @TeamID

	UNION

	SELECT
		6 AS GID
		, 'Color Folder' AS GName
		, b.ColorTypeDescription AS TypeDescription
		, b.Sort AS SortOrder
		, a.AccessRoleID AS AccessRoleID
		, a.AccessView AS AccessView
		, a.AccessModify AS AccessModify
		, NULL AS AccessRemove
		, a.AccessDelete AS AccessDelete
		, a.AccessPrint AS AccessPrint
		, a.AccessCreate AS AccessCreate
	FROM
		sAccessColorFolder  a 
		INNER JOIN pColorType b ON a.ColorTypeID =  b.ColorTypeID
	WHERE
		a.TeamID = @TeamID

	UNION
		
	SELECT
		7 AS GID
		, 'Material Folder' AS GName
		, b.ComponentDescription  AS TypeDescription
		, b.ComponentOrder AS SortOrder
		, a.AccessRoleId AS AccessRoleId
		, a.AccessView AS AccessView
		, a.AccessModify AS AccessModify
		, NULL AS AccessRemove
		, a.AccessDelete AS AccessDelete
		, a.AccessPrint AS AccessPrint
		, a.AccessCreate AS AccessCreate
	FROM
		sAccessMaterialFolder a
		INNER JOIN pComponentType  b ON a.ComponentTypeID  = b.ComponentTypeId 
	WHERE
		a.TeamId = @TeamID

	UNION

	SELECT
		8 AS GID
		, 'Compliance Folder' AS GName
		, b.ComplianceType AS TypeDescription
		, b.ComplianceOrder AS SortOrder
		, a.AccessRoleId AS AccessRoleId
		, a.AccessView AS AccessView
		, a.AccessModify AS AccessModify
		, NULL AS AccessRemove
		, a.AccessDelete AS AccessDelete
		, a.AccessPrint AS AccessPrint
		, a.AccessCreate AS AccessCreate
	FROM
		sAccessComplianceFolder a
		INNER JOIN pComplianceType  b ON a.ComplianceTypeId  = b.ComplianceTypeId 
	WHERE
		a.TeamId = @TeamID

	UNION

	SELECT
		9 AS GID
		, 'Control Panel' AS GName
		, b.ControlPanelName AS TypeDescription
		, b.ControlPanelOrder AS SortOrder
		, a.AccessRoleId AS AccessRoleId
		, a.AccessView AS AccessView
		, a.AccessModify AS AccessModify
		, NULL AS AccessRemove
		, a.AccessDelete AS AccessDelete
		, a.AccessPrint AS AccessPrint
		, a.AccessCreate AS AccessCreate
	FROM
		sAccessControlPanel a
		INNER JOIN pControlPanel  b ON a.ControlPanelId  = b.ControlPanelId
	WHERE
		a.TeamId = @TeamID
		AND b.IsDataValidation = 0

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
		sAccessShareFolder a 
	WHERE
		a.TeamId = @TeamID

	UNION

	SELECT
		11 AS GID
		, 'Costing' AS GName
		, b.StyleTypeDescription AS TypeDescription
		, b.StyleTypeOrder AS SortOrder
		, a.AccessRoleId AS AccessRoleId
		, a.AccessView AS AccessView
		, a.AccessModify AS AccessModify
		, NULL AS AccessRemove
		, a.AccessDelete AS AccessDelete
		, a.AccessPrint AS AccessPrint
		, a.AccessCreate AS AccessCreate
	FROM
		sAccessCosting a
		INNER JOIN pStyleType b ON a.StyleTypeID = b.StyleTypeID
	WHERE
		a.TeamId = @TeamID
		
	UNION

	SELECT
		12 AS GID
		, 'Line Plan - ' + g.LinePlanTemplateName + ' - ' + h.Custom AS GName
		, d.LinePlanTabName AS TypeDescription
		, d.LinePlanTabSort AS SortOrder
		, max(a.AccessRoleId) AS AccessRoleId
		, max(a.AccessView) AS AccessView
		, max(a.accessModify) AS AccessModify
		, max(a.AccessRemove) AS AccessRemove
		, max(a.AccessDelete) AS AccessDelete
		, max(a.AccessPrint) AS AccessPrint
		, max(a.AccessCreate) AS AccessCreate
	FROM
		sAccessGroupLinePlanTab a
		INNER JOIN sAccessGroupLinePlanFolder b ON b.AccessLinePlanId =  a.AccessLinePlanId
		INNER JOIN dbo.pLinePlanFolderTab c ON c.LinePlanFolderTabID =  a.LinePlanFolderTabID
		INNER JOIN dbo.pLinePlanTab d ON d.LinePlanTabID =  c.LinePlanTabID
		INNER JOIN dbo.uUserGroup e ON e.GroupID =  b.GroupID 
		INNER JOIN dbo.uGroup f ON f.GroupID = b.GroupID
		INNER JOIN dbo.pLinePlanTemplate g ON g.LinePlanTemplateID = a.LinePlanTemplateID
		INNER JOIN iCustom1 h on b.CustomID = h.CustomID
	WHERE
		e.TeamID = @TeamID
		
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
		, a.AccessRoleId AS AccessRoleId
		, a.AccessView AS AccessView
		, a.AccessModify AS AccessModify
		, NULL AS AccessRemove
		, a.AccessDelete AS AccessDelete
		, a.AccessPrint AS AccessPrint
		, a.AccessCreate AS AccessCreate
	FROM
		sAccessBodyFolder a 
		INNER JOIN pBodyType b ON a.BodyTypeId = b.BodyTypeID
	WHERE
		a.TeamId = @TeamID

	UNION

	SELECT
		14 AS GID
		, 'Flash Edit' AS GName
		, b.FlashEditItemName AS TypeDescription
		, 0 AS SortOrder
		, a.AccessRoleId AS AccessRoleId
		, a.AccessView AS AccessView
		, a.AccessModify AS AccessModify
		, NULL AS AccessRemove
		, a.AccessDelete AS AccessDelete
		, a.AccessPrint AS AccessPrint
		, a.AccessCreate AS AccessCreate
	FROM
		sAccessFlashEditFolder a
		INNER JOIN pFlashEditFolderItem b ON a.FlashEditFolderItemId  = b.FlashEditFolderItemId
	WHERE
		a.TeamId = @TeamID

	UNION

	SELECT
		15 AS GID
		, 'BI Folder - ' + a.BITypeDesc AS GName
		, b.Description AS TypeDescription
		, 0 AS SortOrder
		, a.AccessRoleId AS AccessRoleId
		, a.AccessView AS AccessView
		, a.AccessModify AS AccessModify
		, NULL AS AccessRemove
		, a.AccessDelete AS AccessDelete
		, a.AccessPrint AS AccessPrint
		, a.AccessCreate AS AccessCreate
	FROM
		sAccessBIFolder a
		INNER JOIN sAccessBIItemsFolder b ON a.BITypeId = b.BITypeId
	WHERE
		b.TeamId = @TeamID

	UNION

	SELECT
		16 AS GID
		, 'BatchQ Folder' AS GName
		, b.BatchQueueTypeName AS TypeDescription
		, 0 AS SortOrder
		, a.AccessRoleId AS AccessRoleId
		, a.AccessView AS AccessView
		, a.AccessModify AS AccessModify
		, NULL AS AccessRemove
		, a.AccessDelete AS AccessDelete
		, a.AccessPrint AS AccessPrint
		, a.AccessCreate AS AccessCreate
	FROM
		sAccessBatchQFolder a 
		INNER JOIN pBatchQueueType b ON a.BatchQTypeId = b.BatchQueueTypeID
	WHERE
		a.TeamId = @TeamID

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
		sAccessSourcingFolder  a 
	WHERE
		a.TeamId = @TeamID
		
	ORDER BY
		GID
		, SortOrder
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04724', GetDate())
GO
