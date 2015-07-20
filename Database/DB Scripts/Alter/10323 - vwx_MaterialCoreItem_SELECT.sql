IF OBJECT_ID(N'[dbo].[vwx_MaterialCoreItem_SELECT]') IS NOT NULL
 DROP VIEW [dbo].[vwx_MaterialCoreItem_SELECT]
GO

CREATE VIEW [dbo].[vwx_MaterialCoreItem_SELECT]
AS
SELECT m.MaterialID, m.MaterialImageID, m.MaterialImageVersion, m.MaterialNo, m.MaterialName, 
       m.MaterialCode, m.MaterialType, mci.MaterialCoreItemID, mci.MaterialCoreID, m.UOM, 
       mci.Qty, mci.MaterialPrice, mci.Ext, mci.MaterialSize, mci.Placement, 
       mci.CUser, mci.CDate, mci.MUser, mci.MDate, mci.Artwork, mci.License, mci.Colorway, 
       dbo.fnx_GetStreamingImageHTML(m.MaterialImageID, m.MaterialImageVersion, 50, '') AS ImagePath, 
	   m.Active
FROM dbo.pMaterial m WITH (NOLOCK) 
INNER JOIN dbo.pMaterialCoreItem mci WITH (NOLOCK) ON m.MaterialID = mci.MaterialID


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10323', GetUTCDate())
GO
