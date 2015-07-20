IF OBJECT_ID(N'[dbo].[vwx_BatchQ_MaterialCoreItem_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_BatchQ_MaterialCoreItem_SEL]
GO

CREATE VIEW [dbo].[vwx_BatchQ_MaterialCoreItem_SEL]
AS
SELECT mci.MaterialCoreItemID, mci.MaterialCoreID, m.MaterialID, m.MaterialNo, m.MaterialName, m.MaterialType, 
       m.A, m.B, m.C, m.D, m.E, m.F, m.G, m.H, m.I, m.J, m.K, m.L, m.M, m.N, m.O, m.P, m.Q, m.R, m.S, m.T, 
	   m.U, m.V, m.W, m.X, m.Y, m.Z, mci.UOM, mci.Qty, mci.MaterialPrice, mci.Ext, mci.MaterialSize, mci.Placement, 
	   mci.Artwork, mci.License, mci.Colorway, m.MaterialCode, m.MaterialCodeNo, 
	   dbo.fnx_GetStreamingImageHTML(m.MaterialImageID, m.MaterialImageVersion, 50, '') AS ImagePath, 
	   dbo.fnx_GetStreamingImageHTML(m.MaterialImageID, m.MaterialImageVersion, 150, '') AS DataListImagePath
FROM dbo.pMaterial m
INNER JOIN dbo.pMaterialCoreItem mci ON m.MaterialID = mci.MaterialID


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10312', GetUTCDate())
GO
