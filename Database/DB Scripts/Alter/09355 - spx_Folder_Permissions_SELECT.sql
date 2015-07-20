IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Folder_Permissions_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Folder_Permissions_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Folder_Permissions_SELECT]
	@GroupID UNIQUEIDENTIFIER
	, @FolderID UNIQUEIDENTIFIER
AS
BEGIN
	SELECT workFlow.*
		, product.PermissionProductTypeName AS TypeName
	FROM sPermissionWorkflow AS workFlow
		INNER JOIN sPermissionProductType AS product ON workFlow.PermissionProductTypeId = product.PermissionProductTypeId
	WHERE workFlow.GroupID = @GroupID
		AND product.PermissionFolderId = @FolderID
		AND product.Active = 1
		AND workflow.Active = 1
	ORDER BY TypeName
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09355', GetDate())
GO
