IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_MaterialCoreItem_SEL]') AND type = N'V' )
	DROP VIEW [dbo].[vwx_BatchQ_MaterialCoreItem_SEL]
GO

CREATE VIEW [dbo].[vwx_BatchQ_MaterialCoreItem_SEL]
AS
SELECT  dbo.pMaterialCoreItem.MaterialCoreItemID, dbo.pMaterialCoreItem.MaterialCoreID,
		dbo.pMaterial.MaterialID, dbo.pMaterial.MaterialNo, dbo.pMaterial.MaterialName, dbo.pMaterial.MaterialType,  dbo.pMaterial.A, 
                      dbo.pMaterial.B, dbo.pMaterial.C, dbo.pMaterial.D, dbo.pMaterial.E, dbo.pMaterial.F, dbo.pMaterial.G, dbo.pMaterial.H, dbo.pMaterial.I, dbo.pMaterial.J, 
                      dbo.pMaterial.K, dbo.pMaterial.L, dbo.pMaterial.M, dbo.pMaterial.N, dbo.pMaterial.O, dbo.pMaterial.P, dbo.pMaterial.Q, dbo.pMaterial.R, dbo.pMaterial.S, 
                      dbo.pMaterial.T, dbo.pMaterial.U, dbo.pMaterial.V, dbo.pMaterial.W, dbo.pMaterial.X, dbo.pMaterial.Y, dbo.pMaterial.Z, 
                      dbo.pMaterialCoreItem.UOM, 
                      dbo.pMaterialCoreItem.Qty, dbo.pMaterialCoreItem.MaterialPrice, dbo.pMaterialCoreItem.Ext, dbo.pMaterialCoreItem.MaterialSize, dbo.pMaterialCoreItem.Placement, 
                      dbo.pMaterialCoreItem.Artwork, dbo.pMaterialCoreItem.License, dbo.pMaterialCoreItem.Colorway, dbo.pMaterial.MaterialCode, dbo.pMaterial.MaterialCodeNo
FROM         dbo.pMaterial INNER JOIN
                      dbo.pMaterialCoreItem ON dbo.pMaterial.MaterialID = dbo.pMaterialCoreItem.MaterialID
GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01582'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01582', GetDate())
END	

GO
