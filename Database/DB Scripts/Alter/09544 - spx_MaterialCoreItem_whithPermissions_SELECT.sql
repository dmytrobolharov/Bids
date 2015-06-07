IF OBJECT_ID(N'[dbo].[spx_MaterialCoreItem_whithPermissions_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_MaterialCoreItem_whithPermissions_SELECT]
GO
CREATE PROCEDURE [dbo].[spx_MaterialCoreItem_whithPermissions_SELECT](
@MaterialCoreID uniqueidentifier,
@TeamID uniqueidentifier
)
AS SELECT     
dbo.pMaterial.MaterialID, dbo.pMaterial.MaterialImageID, dbo.pMaterial.MaterialImageVersion, dbo.pMaterial.MaterialNo, dbo.pMaterial.MaterialName, 
dbo.pMaterial.MaterialCode,
dbo.pMaterial.MaterialType, dbo.pMaterialCoreItem.MaterialCoreItemID, dbo.pMaterialCoreItem.MaterialCoreID, dbo.pMaterial.UOM, 
dbo.pMaterialCoreItem.Qty, dbo.pMaterialCoreItem.MaterialPrice, dbo.pMaterialCoreItem.Ext, dbo.pMaterialCoreItem.MaterialSize, 
dbo.pMaterialCoreItem.Placement, dbo.pMaterialCoreItem.CUser, dbo.pMaterialCoreItem.CDate, dbo.pMaterialCoreItem.MUser, 
dbo.pMaterialCoreItem.MDate, dbo.pMaterialCoreItem.Artwork, dbo.pMaterialCoreItem.License, dbo.pMaterialCoreItem.Colorway,

'<img src="../System/Control/ImageStream.ashx?S=50&V='  +  CAST(dbo.pMaterial.MaterialImageVersion  AS NVARCHAR(5))+  
'&IID=' + CAST ( dbo.pMaterial.MaterialImageID AS NVARCHAR(40)) + '" />'
as ImagePath 
FROM         dbo.pMaterial WITH (NOLOCK) INNER JOIN
                      dbo.pMaterialCoreItem WITH (NOLOCK) ON dbo.pMaterial.MaterialID = dbo.pMaterialCoreItem.MaterialID
WHERE     (dbo.pMaterialCoreItem.MaterialCoreID = @MaterialCoreID) AND MaterialType IN (SELECT ProductTypeID FROM fnx_Permissions_GetIntProductTypePermissions(@TeamID, 8) WHERE PermissionRoleId =3 OR PermissionView = 1)
ORDER BY dbo.pMaterial.MaterialName, dbo.pMaterial.MaterialType
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09544', GetDate())
GO