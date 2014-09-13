/****** Object:  StoredProcedure [dbo].[spx_User_AccessFolder_SELECT]    Script Date: 06/23/2014 14:05:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_User_AccessFolder_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_User_AccessFolder_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_User_AccessFolder_SELECT]    Script Date: 06/23/2014 14:05:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
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
	IF @nDeskFolderId = 2 OR @nDeskFolderId = 4 
		OR @nDeskFolderId = 12 OR @nDeskFolderId = 20
		OR @nDeskFolderId = 5 -- Styles, Quotations, Costing, Old Sourcing and Sample Folder, ordered by Style Type Order
	BEGIN
		SELECT PermissionFolderTypeId AS DeskFolderID, 
				PermissionProductTypeName AS TypeDescription,
				st.StyleTypeOrder,
				AccessRoleID, 
				AccessView, 
				AccessModify, 
				AccessCreate, 
				AccessRemove, 
				AccessDelete, 
				AccessPrint
		FROM vwx_Permissions_ProductTypes ppt
		INNER JOIN pStyleType st ON st.StyleTypeID = ppt.IntProductTypeId
		WHERE ppt.PermissionFolderTypeId = @nDeskFolderId AND ppt.TeamID = @TeamID
		ORDER BY st.StyleTypeOrder, st.StyleTypeDescription
	END
	ELSE IF @nDeskFolderId = 6 -- Images ordered by Image Type Order
	BEGIN
		SELECT PermissionFolderTypeId AS DeskFolderID, 
				PermissionProductTypeName AS TypeDescription,
				it.ImageOrder,
				AccessRoleID, 
				AccessView, 
				AccessModify, 
				AccessCreate, 
				AccessRemove, 
				AccessDelete, 
				AccessPrint
		FROM vwx_Permissions_ProductTypes ppt
		INNER JOIN pImageType it ON it.ImageTypeID = ppt.GuidProductTypeId
		WHERE ppt.PermissionFolderTypeId = @nDeskFolderId AND ppt.TeamID = @TeamID
		ORDER BY it.ImageOrder, it.ImageType
	END
	ELSE IF @nDeskFolderId = 7 -- Colors ordered by Color Type Order
	BEGIN
		SELECT PermissionFolderTypeId AS DeskFolderID, 
				PermissionProductTypeName AS TypeDescription,
				ct.Sort,
				AccessRoleID, 
				AccessView, 
				AccessModify, 
				AccessCreate, 
				AccessRemove, 
				AccessDelete, 
				AccessPrint
		FROM vwx_Permissions_ProductTypes ppt
		INNER JOIN pColorType ct ON ct.ColorTypeID = ppt.IntProductTypeId
		WHERE ppt.PermissionFolderTypeId = @nDeskFolderId AND ppt.TeamID = @TeamID
		ORDER BY ct.Sort, ct.ColorTypeDescription
	END
	ELSE IF @nDeskFolderId = 8 -- Materials ordered by Material Type Order
	BEGIN
		SELECT PermissionFolderTypeId AS DeskFolderID, 
				PermissionProductTypeName AS TypeDescription,
				mt.ComponentOrder,
				AccessRoleID, 
				AccessView, 
				AccessModify, 
				AccessCreate, 
				AccessRemove, 
				AccessDelete, 
				AccessPrint
		FROM vwx_Permissions_ProductTypes ppt
		INNER JOIN pComponentType mt ON mt.ComponentTypeID = ppt.IntProductTypeId
		WHERE ppt.PermissionFolderTypeId = @nDeskFolderId AND ppt.TeamID = @TeamID
		ORDER BY mt.ComponentOrder, mt.ComponentDescription
	END
	ELSE IF @nDeskFolderId  = 13  -- LinePlan with old permissions
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
	ELSE  IF @nDeskFolderId = 17 -- BI Folder ordered by "workflows", which are reports
	BEGIN
		SELECT folders.PermissionFolderTypeId AS DeskFolderID,
				workflow.PermissionWorkflowName AS TypeDescription,
				pt.PermissionProductTypeName AS BITypeDesc,
				workflow.PermissionRoleId AS AccessRoleID, 
				workflow.PermissionView AS AccessView, 
				workflow.PermissionModify AS AccessModify, 
				workflow.PermissionCreate AS AccessCreate,
				workflow.PermissionPrint AS AccessPrint,
				workflow.PermissionRemove AS AccessRemove,
				workflow.PermissionDelete AS AccessDelete
		FROM    dbo.sPermissionWorkflow AS workflow INNER JOIN
				  dbo.sPermissionFolder AS folders ON workflow.PermissionFolderId = folders.PermissionFolderId INNER JOIN
				  dbo.sPermissionProductTypeMap AS ptm ON ptm.PermissionFolderTypeId = folders.PermissionFolderTypeId INNER JOIN
				  dbo.sPermissionProductType AS pt ON pt.PermissionProductTypeId = workflow.PermissionProductTypeId AND 
				  ptm.PermissionProductTypeMapId = pt.PermissionProductTypeMapId INNER JOIN
				  dbo.uUserGroup AS ugr ON workflow.GroupId = ugr.GroupID 
		WHERE     pt.PermissionProductTypeNotLocked = 1 AND folders.PermissionFolderNotLocked = 1 
					AND folders.PermissionFolderTypeId = @nDeskFolderId AND ptm.IntProductTypeId = @BIType
					AND ugr.TeamID = @TeamID
		ORDER BY TypeDescription
		
	END
	ELSE
	BEGIN
		SELECT PermissionFolderTypeId AS DeskFolderID, 
				PermissionProductTypeName AS TypeDescription,
				AccessRoleID, 
				AccessView, 
				AccessModify, 
				AccessCreate, 
				AccessRemove, 
				AccessDelete, 
				AccessPrint
		FROM vwx_Permissions_ProductTypes ppt
		WHERE ppt.PermissionFolderTypeId = @nDeskFolderId AND ppt.TeamID = @TeamID
		ORDER BY TypeDescription
		
		
	END
		
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08057', GetDate())
GO
