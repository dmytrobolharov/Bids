/****** Object:  View [dbo].[vwx_Permissions_ProductTypes]    Script Date: 06/05/2014 14:07:15 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Permissions_ProductTypes]'))
DROP VIEW [dbo].[vwx_Permissions_ProductTypes]
GO

/****** Object:  View [dbo].[vwx_Permissions_ProductTypes]    Script Date: 06/05/2014 14:07:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_Permissions_ProductTypes]
AS
SELECT     folders.PermissionFolderTypeId, ptm.IntProductTypeId, ptm.GuidProductTypeId, ptm.StrProductTypeId, pt.PermissionProductTypeName, u.TeamID, 
                      MAX(workflow.PermissionRoleId) AS AccessRoleID, MAX(workflow.PermissionView) AS AccessView, MAX(workflow.PermissionModify) AS AccessModify, 
                      MAX(workflow.PermissionCreate) AS AccessCreate, MAX(workflow.PermissionPrint) AS AccessPrint, MAX(workflow.PermissionRemove) AS AccessRemove, 
                      MAX(workflow.PermissionDelete) AS AccessDelete
FROM         dbo.sPermissionWorkflow AS workflow INNER JOIN
                      dbo.sPermissionFolder AS folders ON workflow.PermissionFolderId = folders.PermissionFolderId INNER JOIN
                      dbo.sPermissionProductTypeMap AS ptm ON ptm.PermissionFolderTypeId = folders.PermissionFolderTypeId INNER JOIN
                      dbo.sPermissionProductType AS pt ON pt.PermissionProductTypeId = workflow.PermissionProductTypeId AND 
                      ptm.PermissionProductTypeMapId = pt.PermissionProductTypeMapId INNER JOIN
                      dbo.uUserGroup AS ugr ON workflow.GroupId = ugr.GroupID INNER JOIN
                      dbo.Users AS u ON ugr.TeamID = u.TeamID
WHERE     (pt.PermissionProductTypeNotLocked = 1) AND (folders.PermissionFolderNotLocked = 1)
GROUP BY folders.PermissionFolderTypeId, ptm.IntProductTypeId, ptm.GuidProductTypeId, ptm.StrProductTypeId, pt.PermissionProductTypeName, u.TeamID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07898', GetDate())
GO
