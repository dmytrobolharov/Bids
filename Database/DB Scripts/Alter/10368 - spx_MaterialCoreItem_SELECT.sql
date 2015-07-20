IF OBJECT_ID(N'[dbo].[spx_MaterialCoreItem_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_MaterialCoreItem_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialCoreItem_SELECT]
(
 @MaterialCoreID UNIQUEIDENTIFIER
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
  WHERE mci.MaterialCoreID = @MaterialCoreID
  ORDER BY m.MaterialName, m.MaterialType

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10368', GetUTCDate())
GO
