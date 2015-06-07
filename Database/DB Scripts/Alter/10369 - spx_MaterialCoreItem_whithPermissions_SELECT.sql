IF OBJECT_ID(N'[dbo].[spx_MaterialCoreItem_whithPermissions_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_MaterialCoreItem_whithPermissions_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialCoreItem_whithPermissions_SELECT]
(
 @MaterialCoreID uniqueidentifier,
 @TeamID uniqueidentifier
)
AS 
BEGIN
  
  SELECT m.MaterialID, m.MaterialImageID, m.MaterialImageVersion, m.MaterialNo, m.MaterialName, 
         m.MaterialCode, m.MaterialType, mci.MaterialCoreItemID, mci.MaterialCoreID, m.UOM, 
         mci.Qty, mci.MaterialPrice, mci.Ext, mci.MaterialSize, mci.Placement, mci.CUser, 
		 mci.CDate, mci.MUser, mci.MDate, mci.Artwork, mci.License, mci.Colorway,
		 dbo.fnx_GetStreamingImageHTML(m.MaterialImageID, m.MaterialImageVersion, 50, '') AS ImagePath 
  FROM dbo.pMaterial m WITH (NOLOCK) 
  INNER JOIN dbo.pMaterialCoreItem mci WITH (NOLOCK) ON m.MaterialID = mci.MaterialID
  WHERE mci.MaterialCoreID = @MaterialCoreID AND 
        m.MaterialType IN (SELECT ProductTypeID FROM fnx_Permissions_GetIntProductTypePermissions(@TeamID, 8) WHERE PermissionRoleId =3 OR PermissionView = 1)
  ORDER BY m.MaterialName, m.MaterialType

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10369', GetUTCDate())
GO
