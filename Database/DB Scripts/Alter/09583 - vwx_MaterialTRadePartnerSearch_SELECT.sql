IF OBJECT_ID(N'[dbo].[vwx_MaterialTRadePartnerSearch_SELECT]') IS NOT NULL
 DROP VIEW [dbo].[vwx_MaterialTRadePartnerSearch_SELECT]
GO
CREATE VIEW [dbo].[vwx_MaterialTRadePartnerSearch_SELECT]
AS
SELECT     dbo.pMaterial.MaterialID, dbo.pMaterial.TempID, dbo.pMaterial.TempNo, dbo.pMaterial.MaterialImageID, dbo.pMaterial.MaterialImageVersion, dbo.pMaterial.MaterialImageDetailID, 
                      dbo.pMaterial.MaterialImageDetailVersion, dbo.pMaterial.NoColorMatch, dbo.pMaterial.SupplierID, dbo.pMaterial.MaterialType, dbo.pMaterial.MaterialNo, dbo.pMaterial.MaterialName, 
                      dbo.pMaterial.A, dbo.pMaterial.B, dbo.pMaterial.C, dbo.pMaterial.D, dbo.pMaterial.E, dbo.pMaterial.F, dbo.pMaterial.G, dbo.pMaterial.H, dbo.pMaterial.I, dbo.pMaterial.J, dbo.pMaterial.K, 
                      dbo.pMaterial.L, dbo.pMaterial.M, dbo.pMaterial.N, dbo.pMaterial.O, dbo.pMaterial.P, dbo.pMaterial.Q, dbo.pMaterial.R, dbo.pMaterial.S, dbo.pMaterial.T, dbo.pMaterial.U, dbo.pMaterial.V, 
                      dbo.pMaterial.W, dbo.pMaterial.X, dbo.pMaterial.Y, dbo.pMaterial.Z, dbo.pMaterial.Source, dbo.pMaterial.Notes, dbo.pMaterial.VendorPrice, dbo.pMaterial.VolumePrice, 
                      dbo.pMaterial.VolumePriceMinimum, dbo.pMaterial.VendorProductionMin, dbo.pMaterial.VendorProductionLeadTime, dbo.pMaterial.MaterialPlacement, dbo.pMaterial.DetailYesNo, 
                      dbo.pMaterial.ImageType1, dbo.pMaterial.height, dbo.pMaterial.width, dbo.pMaterial.CDate, dbo.pMaterial.CUser, dbo.pMaterial.MDate, dbo.pMaterial.MUser, dbo.pMaterial.MChange, 
                      dbo.pMaterial.DChange, dbo.pMaterial.Action, dbo.pMaterial.Status, dbo.pMaterial.Active, dbo.pMaterial.MultiDimension, dbo.pMaterial.UOM, dbo.pMaterial.MaterialCode, 
                      dbo.pMaterial.MaterialCodeNo, dbo.pMaterial.SAPCode, dbo.pMaterial.SAPControl, dbo.pMaterial.MaterialColorRequired, dbo.pMaterial.FactorySourced, 
                      dbo.pMaterialTradePartner.MaterialTradePartnerId, dbo.pMaterialTradePartner.TradepartnerId, dbo.pMaterialTradePartner.TradepartnerVendorId, dbo.pComponentType.ComponentDescription
FROM         dbo.pMaterial LEFT OUTER JOIN
                      dbo.pMaterialTradePartner ON dbo.pMaterial.MaterialID = dbo.pMaterialTradePartner.MaterialId INNER JOIN
                      dbo.pComponentType ON dbo.pMaterial.MaterialType = dbo.pComponentType.ComponentTypeID
                      
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09583', GetDate())
GO