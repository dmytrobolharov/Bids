IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_MaterialCoreItem_SELECT]'))
DROP VIEW [dbo].[vwx_MaterialCoreItem_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_MaterialCoreItem_SELECT]
AS
SELECT     dbo.pMaterial.MaterialID, dbo.pMaterial.MaterialImageID, dbo.pMaterial.MaterialImageVersion, dbo.pMaterial.MaterialNo, dbo.pMaterial.MaterialName, 
                      dbo.pMaterial.MaterialCode, dbo.pMaterial.MaterialType, dbo.pMaterialCoreItem.MaterialCoreItemID, dbo.pMaterialCoreItem.MaterialCoreID, dbo.pMaterial.UOM, 
                      dbo.pMaterialCoreItem.Qty, dbo.pMaterialCoreItem.MaterialPrice, dbo.pMaterialCoreItem.Ext, dbo.pMaterialCoreItem.MaterialSize, dbo.pMaterialCoreItem.Placement, 
                      dbo.pMaterialCoreItem.CUser, dbo.pMaterialCoreItem.CDate, dbo.pMaterialCoreItem.MUser, dbo.pMaterialCoreItem.MDate, dbo.pMaterialCoreItem.Artwork, 
                      dbo.pMaterialCoreItem.License, dbo.pMaterialCoreItem.Colorway, 
                      '<img src="../System/Control/ImageStream.ashx?S=50&V=' + CAST(dbo.pMaterial.MaterialImageVersion AS NVARCHAR(5)) 
                      + '&IID=' + CAST(dbo.pMaterial.MaterialImageID AS NVARCHAR(40)) + '" />' AS ImagePath, dbo.pMaterial.Active
FROM         dbo.pMaterial WITH (NOLOCK) INNER JOIN
                      dbo.pMaterialCoreItem WITH (NOLOCK) ON dbo.pMaterial.MaterialID = dbo.pMaterialCoreItem.MaterialID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05819', GetDate())
GO
