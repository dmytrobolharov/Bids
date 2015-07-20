IF OBJECT_ID(N'[dbo].[vwx_StyleMaterial_SubComponent_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_StyleMaterial_SubComponent_SEL]
GO

CREATE VIEW [dbo].[vwx_StyleMaterial_SubComponent_SEL]
AS
SELECT a.MaterialLinkID, b.MaterialID, b.TempID, b.TempNo, b.MaterialImageID, b.MaterialImageVersion, b.MaterialImageDetailID, 
       b.MaterialImageDetailVersion, b.NoColorMatch, b.SupplierID, b.MaterialType, b.MaterialNo, b.MaterialName, b.A, b.B, b.C, b.D, b.E, b.F, b.G, b.H, b.I, 
       b.J, b.K, b.L, b.M, b.N, b.O, b.P, b.Q, b.R, b.S, b.T, b.U, b.V, b.W, b.X, b.Y, b.Z, b.Source, b.Notes, b.VendorPrice, b.VolumePrice, b.VolumePriceMinimum,
       b.VendorProductionMin, b.VendorProductionLeadTime, b.MaterialPlacement, b.DetailYesNo, b.ImageType1, b.height, b.width, b.CDate, b.CUser, 
       b.MDate, b.MUser, b.MChange, b.DChange, b.Action, b.Status, b.Active, b.MultiDimension, b.UOM, b.MaterialCode, b.MaterialCodeNo, b.SAPCode, 
       b.SAPControl, b.MaterialColorRequired, b.FactorySourced, b.TradePartnerID, b.TradePartnerVendorID, c.ComponentDescription, a.MaterialGroupID, 
       c.ComponentOrder, dbo.fnx_GetStreamingImageHTML(b.MaterialImageID, b.MaterialImageVersion, 50 ,'') AS MaterialImage
FROM dbo.pMaterialLink AS a 
INNER JOIN dbo.pMaterial AS b ON a.MaterialID = b.MaterialID 
INNER JOIN dbo.pComponentType AS c ON b.MaterialType = c.ComponentTypeID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10347', GetUTCDate())
GO
