IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_ProductPermissionsOnFolder_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Group_ProductPermissionsOnFolder_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_Group_ProductPermissionsOnFolder_SELECT]
	@GroupID uniqueidentifier,
	@FolderID uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--select * from sPermissionProductType as product where product.PermissionFolderId = @FolderID and product.GroupId = @GroupID
	SELECT product.*, map.GuidProductTypeId, map.IntProductTypeId, map.StrProductTypeId, map.PermissionFolderTypeId
	FROM sPermissionProductType product
	INNER JOIN sPermissionProductTypeMap map ON product.PermissionProductTypeMapId = map.PermissionProductTypeMapId
	WHERE product.GroupId = @GroupID
	AND product.PermissionFolderId = @FolderID	
	ORDER BY product.PermissionProductTypeName
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08218', GetDate())
GO
