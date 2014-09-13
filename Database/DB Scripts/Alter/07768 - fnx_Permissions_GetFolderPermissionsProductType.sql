/****** Object:  UserDefinedFunction [dbo].[fnx_Permissions_GetFolderPermissionsProductType]    Script Date: 05/28/2014 11:48:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_Permissions_GetFolderPermissionsProductType]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_Permissions_GetFolderPermissionsProductType]
GO

/****** Object:  UserDefinedFunction [dbo].[fnx_Permissions_GetFolderPermissionsProductType]    Script Date: 05/28/2014 11:48:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [dbo].[fnx_Permissions_GetFolderPermissionsProductType]
(
	@GroupId UNIQUEIDENTIFIER,
	@FolderId UNIQUEIDENTIFIER
)
RETURNS 
	@ProductTypes TABLE
	(
		ProductTypeId UNIQUEIDENTIFIER,
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

	INSERT INTO @ProductTypes (ProductTypeId, ProductTypeName, PermissionRoleId, PermissionView, PermissionCreate, PermissionModify, 
								PermissionRemove, PermissionDelete, PermissionPrint)
	SELECT pt.PermissionProductTypeId, pt.PermissionProductTypeName, 
			MAX(workflow.PermissionRoleId), MAX(workflow.PermissionView),MAX(workflow.PermissionCreate), MAX(workflow.PermissionModify),
			MAX(workflow.PermissionRemove), MAX(workflow.PermissionDelete), MAX(workflow.PermissionPrint)
	FROM sPermissionWorkflow AS workflow
	INNER JOIN sPermissionFolder AS folders ON workflow.PermissionFolderId = folders.PermissionFolderId	
	INNER JOIN sPermissionProductType AS pt ON pt.PermissionProductTypeId = workflow.PermissionProductTypeId
	WHERE workflow.GroupID = @GroupId AND folders.PermissionFolderId = @FolderId	
	AND pt.PermissionProductTypeNotLocked = 1 AND folders.PermissionFolderNotLocked = 1 
	GROUP BY pt.PermissionProductTypeId, pt.PermissionProductTypeName
	
	RETURN 
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '07768', GetDate())
GO
