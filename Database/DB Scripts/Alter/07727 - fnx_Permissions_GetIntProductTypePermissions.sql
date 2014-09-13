/****** Object:  UserDefinedFunction [dbo].[fnx_Permissions_GetIntProductTypePermissions]    Script Date: 05/22/2014 12:01:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_Permissions_GetIntProductTypePermissions]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_Permissions_GetIntProductTypePermissions]
GO

/****** Object:  UserDefinedFunction [dbo].[fnx_Permissions_GetIntProductTypePermissions]    Script Date: 05/22/2014 12:01:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[fnx_Permissions_GetIntProductTypePermissions]
(
	@TeamID UNIQUEIDENTIFIER,
	@FolderTypeID INT
)
RETURNS 
	@ProductTypes TABLE
	(
		ProductTypeId INT,
		ProductTypeName NVARCHAR(500),
		PermissionRoleId INT,
		PermissionView INT,
		PermissionCreate INT,
		PermissionModify INT,
		PermissionRemove INT,
		PermissionDelete INT,
		PermissionPrint INT
	)
AS
BEGIN

	INSERT INTO @ProductTypes (ProductTypeID, ProductTypeName, PermissionRoleId, PermissionView, PermissionCreate, PermissionModify, 
								PermissionRemove, PermissionDelete, PermissionPrint)
	SELECT ptm.IntProductTypeId, pt.PermissionProductTypeName, 
			MAX(workflow.PermissionRoleId), MAX(workflow.PermissionView),MAX(workflow.PermissionCreate), MAX(workflow.PermissionModify),
			MAX(workflow.PermissionRemove), MAX(workflow.PermissionDelete), MAX(workflow.PermissionPrint)
	FROM sPermissionWorkflow AS workflow
	INNER JOIN sPermissionFolder AS folders ON workflow.PermissionFolderId = folders.PermissionFolderId
	INNER JOIN sPermissionProductTypeMap as ptm ON ptm.PermissionFolderTypeId = folders.PermissionFolderTypeId
	INNER JOIN sPermissionProductType AS pt ON pt.PermissionProductTypeId = workflow.PermissionProductTypeId AND ptm.PermissionProductTypeMapId = pt.PermissionProductTypeMapId
	INNER JOIN uUserGroup AS ugr ON ugr.TeamID = @TeamID
	INNER JOIN uGroup as gr ON gr.GroupID = ugr.GroupID
	WHERE workflow.GroupID = gr.GroupID AND folders.PermissionFolderTypeId = @FolderTypeID 
	AND pt.PermissionProductTypeNotLocked = 1 AND folders.PermissionFolderNotLocked = 1 
	GROUP BY ptm.IntProductTypeId, pt.PermissionProductTypeName
	
	RETURN 
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07727', GetDate())
GO
