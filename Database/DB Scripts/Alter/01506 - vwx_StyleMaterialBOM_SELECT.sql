IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_StyleMaterialBOM_SELECT]'))
DROP VIEW [dbo].[vwx_StyleMaterialBOM_SELECT]
GO


CREATE VIEW [dbo].[vwx_StyleMaterialBOM_SELECT]
AS
SELECT DISTINCT 
                      dbo.pStyleMaterials.Artwork, dbo.pStyleMaterials.License, dbo.pStyleMaterials.Colorway, dbo.uTradePartnerVendor.VendorName, 
                      dbo.pStyleMaterials.StyleMaterialID, dbo.pStyleMaterials.StyleMaterialMasterID, dbo.pStyleMaterials.CopyStyleMaterialID, 
                      dbo.pStyleMaterials.MainMaterial, dbo.pStyleMaterials.Development, dbo.pStyleMaterials.MiscColor, dbo.pStyleMaterials.StyleSet, 
                      dbo.pStyleMaterials.StyleID, dbo.pStyleMaterials.UOM, dbo.pStyleMaterials.Qty, dbo.pStyleMaterials.MaterialPrice, dbo.pStyleMaterials.Ext, 
                      dbo.pStyleMaterials.MaterialSize, dbo.pStyleMaterials.MaterialID, dbo.pStyleMaterials.MaterialPlacement, 
                      dbo.pStyleMaterials.MaterialPlacementCode, dbo.pStyleMaterials.MaterialPlacementDetail, dbo.pStyleMaterials.MaterialImageID, 
                      dbo.pStyleMaterials.MaterialImageVersion, dbo.pStyleMaterials.NoColorMatch, dbo.pStyleMaterials.SupplierID, 
                      dbo.pStyleMaterials.ComponentTypeID, dbo.pStyleMaterials.MaterialType, dbo.pStyleMaterials.MaterialNo, dbo.pStyleMaterials.MaterialName, 
                      dbo.pStyleMaterials.A, dbo.pStyleMaterials.B, dbo.pStyleMaterials.C, dbo.pStyleMaterials.D, dbo.pStyleMaterials.E, dbo.pStyleMaterials.F, 
                      dbo.pStyleMaterials.G, dbo.pStyleMaterials.I, dbo.pStyleMaterials.H, dbo.pStyleMaterials.J, dbo.pStyleMaterials.K, dbo.pStyleMaterials.L, 
                      dbo.pStyleMaterials.M, dbo.pStyleMaterials.N, dbo.pStyleMaterials.O, dbo.pStyleMaterials.P, dbo.pStyleMaterials.Q, dbo.pStyleMaterials.R, 
                      dbo.pStyleMaterials.S, dbo.pStyleMaterials.T, dbo.pStyleMaterials.U, dbo.pStyleMaterials.V, dbo.pStyleMaterials.W, dbo.pStyleMaterials.X, 
                      dbo.pStyleMaterials.Y, dbo.pStyleMaterials.Z, dbo.pStyleMaterials.Source, dbo.pStyleMaterials.Notes, dbo.pStyleMaterials.Placement, 
                      dbo.pStyleMaterials.VendorPrice, dbo.pStyleMaterials.VolumePrice, dbo.pStyleMaterials.VolumePriceMinimum, 
                      dbo.pStyleMaterials.VendorProductionMin, dbo.pStyleMaterials.VendorProductionLeadTime, dbo.pStyleMaterials.DetailYesNo, 
                      dbo.pStyleMaterials.ImageType, dbo.pStyleMaterials.height, dbo.pStyleMaterials.width, dbo.pStyleMaterials.CDate, dbo.pStyleMaterials.CUser, 
                      dbo.pStyleMaterials.MDate, dbo.pStyleMaterials.MUser, dbo.pStyleMaterials.MChange, dbo.pStyleMaterials.SChange, dbo.pStyleMaterials.DChange, 
                      dbo.pStyleMaterials.CChange, dbo.pStyleMaterials.Action, dbo.pStyleMaterials.ColorPlacement, dbo.pStyleMaterials.MaterialSort, 
                      dbo.pStyleMaterials.MaterialTrack, dbo.pStyleMaterials.MaterialLinked, dbo.pStyleMaterials.MaterialDimension, dbo.pStyleMaterials.MaterialSizeA0, 
                      dbo.pStyleMaterials.MaterialSizeA1, dbo.pStyleMaterials.MaterialSizeA2, dbo.pStyleMaterials.MaterialSizeA3, dbo.pStyleMaterials.MaterialSizeA4, 
                      dbo.pStyleMaterials.MaterialSizeA5, dbo.pStyleMaterials.MaterialSizeA6, dbo.pStyleMaterials.MaterialSizeA7, dbo.pStyleMaterials.MaterialSizeA8, 
                      dbo.pStyleMaterials.MaterialSizeA9, dbo.pStyleMaterials.MaterialSizeA10, dbo.pStyleMaterials.MaterialSizeA11, dbo.pStyleMaterials.MaterialSizeA12, 
                      dbo.pStyleMaterials.MaterialSizeA13, dbo.pStyleMaterials.MaterialSizeA14, dbo.pStyleMaterials.MaterialSizeA15, 
                      dbo.pStyleMaterials.MaterialSizeA16, dbo.pStyleMaterials.MaterialSizeA17, dbo.pStyleMaterials.MaterialSizeA18, 
                      dbo.pStyleMaterials.MaterialSizeA19, dbo.pStyleMaterials.MaterialSizeB0, dbo.pStyleMaterials.MaterialSizeB1, dbo.pStyleMaterials.MaterialSizeB2, 
                      dbo.pStyleMaterials.MaterialSizeB3, dbo.pStyleMaterials.MaterialSizeB4, dbo.pStyleMaterials.MaterialSizeB5, dbo.pStyleMaterials.MaterialSizeB6, 
                      dbo.pStyleMaterials.MaterialSizeB7, dbo.pStyleMaterials.MaterialSizeB8, dbo.pStyleMaterials.MaterialSizeB9, dbo.pStyleMaterials.MaterialSizeB10, 
                      dbo.pStyleMaterials.MaterialSizeB11, dbo.pStyleMaterials.MaterialSizeB12, dbo.pStyleMaterials.MaterialSizeB13, 
                      dbo.pStyleMaterials.MaterialSizeB14, dbo.pStyleMaterials.MaterialSizeB15, dbo.pStyleMaterials.MaterialSizeB16, 
                      dbo.pStyleMaterials.MaterialSizeB18, dbo.pStyleMaterials.MaterialSizeB17, dbo.pStyleMaterials.MaterialSizeB19, dbo.pStyleMaterials.MaterialLining,
                       dbo.pStyleMaterials.MaterialSizeID, dbo.pStyleMaterials.MaterialPackLabelGroupID, dbo.pStyleMaterials.MaterialBOM, 
                      dbo.uTradePartnerVendor.TradePartnerID, dbo.pMaterial.MultiDimension, dbo.pComponentType.ComponentPackLabel,
                          (SELECT     COUNT(*) AS NoComments
                            FROM          dbo.pMaterialComment
                            WHERE      (MaterialID = dbo.pStyleMaterials.MaterialID)) AS NoComments, dbo.pMaterial.MaterialColorRequired, dbo.pMaterial.FactorySourced, 
                      dbo.pMaterial.MaterialCode
FROM         dbo.uTradePartnerVendor RIGHT OUTER JOIN
                      dbo.pStyleMaterials INNER JOIN
                      dbo.pMaterial ON dbo.pMaterial.MaterialID = dbo.pStyleMaterials.MaterialID INNER JOIN
                      dbo.pComponentType ON dbo.pStyleMaterials.MaterialType = dbo.pComponentType.ComponentTypeID ON 
                      dbo.uTradePartnerVendor.TradePartnerVendorID = dbo.pStyleMaterials.TradePartnerVendorID
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01506', GetDate())
GO