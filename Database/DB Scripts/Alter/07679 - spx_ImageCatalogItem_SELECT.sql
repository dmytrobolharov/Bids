/****** Object:  StoredProcedure [dbo].[spx_ImageCatalogItem_SELECT]    Script Date: 05/13/2014 16:44:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ImageCatalogItem_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ImageCatalogItem_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_ImageCatalogItem_SELECT]    Script Date: 05/13/2014 16:44:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_ImageCatalogItem_SELECT]( 
@ImageCatalogID uniqueidentifier, 
@TeamID UNIQUEIDENTIFIER =  NULL 
)

AS 

IF @TeamID   IS NULL 
BEGIN 
	SELECT     pImageCatalogItem.ImageCatalogItemID, pImageCatalogItem.ImageCatalogID, pImageCatalogItem.ImageID, 
	                      pImageCatalogItem.ImageVersion, pImage.ImageNo, pImage.ImageDescription, pImageCatalogItem.CUser, 
	                      pImageCatalogItem.CDate, pImageCatalogItem.MUser, pImageCatalogItem.MDate, pImage.ImageFile, 
	                      pImageCatalogItem.ImageSort
	FROM         pImageCatalogItem WITH (NOLOCK) INNER JOIN
	                      pImage WITH (NOLOCK) ON pImageCatalogItem.ImageID = pImage.ImageID
	WHERE     (pImageCatalogItem.ImageCatalogID = @ImageCatalogID)
	ORDER BY pImageCatalogItem.ImageSort, pImage.ImageNo
END 
ELSE 
BEGIN 
	SELECT     pImageCatalogItem.ImageCatalogItemID, pImageCatalogItem.ImageCatalogID, pImageCatalogItem.ImageID, 
	                      pImageCatalogItem.ImageVersion, pImage.ImageNo, pImage.ImageDescription, pImageCatalogItem.CUser, 
	                      pImageCatalogItem.CDate, pImageCatalogItem.MUser, pImageCatalogItem.MDate, pImage.ImageFile, 
	                      pImageCatalogItem.ImageSort
	FROM         pImageCatalogItem WITH (NOLOCK) INNER JOIN
	             pImage WITH (NOLOCK) ON pImageCatalogItem.ImageID = pImage.ImageID INNER JOIN
	             pImageType it ON pImage.ImageSubFolder1 = it.ImageType INNER JOIN
	             fnx_Permissions_GetGuidProductTypePermissions(@TeamID, 6) perms ON perms.ProductTypeId = it.ImageTypeID
	WHERE     pImageCatalogItem.ImageCatalogID = @ImageCatalogID
	AND perms.PermissionRoleId = 3 OR perms.PermissionView = 1 
	ORDER BY pImageCatalogItem.ImageSort, pImage.ImageNo
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07679', GetDate())
GO
