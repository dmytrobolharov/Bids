IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_StyleBOM_SELECT]'))
DROP VIEW [dbo].[vwx_StyleBOM_SELECT]
GO



CREATE VIEW [dbo].[vwx_StyleBOM_SELECT]
AS
SELECT DISTINCT 
                      dbo.pStyleBOM.AutoColor, dbo.pStyleBOM.Artwork, dbo.pStyleBOM.License, dbo.pStyleBOM.Colorway, dbo.uTradePartnerVendor.VendorName, 
                      dbo.pStyleBOM.StyleMaterialID, dbo.pStyleBOM.StyleMaterialMasterID, dbo.pStyleBOM.CopyStyleMaterialID, 
                      dbo.pStyleBOM.MainMaterial, dbo.pStyleBOM.Development, dbo.pStyleBOM.MiscColor, dbo.pStyleBOM.StyleSet, 
                      dbo.pStyleBOM.WorkflowId,dbo.pStyleBOM.WorkflowItemId,dbo.pStyleBOM.StyleBOMDimensionId,                      
                      dbo.pStyleBOM.StyleID, dbo.pStyleBOM.UOM, dbo.pStyleBOM.MaterialColorId, dbo.pStyleBOM.Qty, dbo.pStyleBOM.MaterialPrice, dbo.pStyleBOM.Ext, 
                      dbo.pMaterialSize.MaterialSize, dbo.pStyleBOM.MaterialID, dbo.pStyleBOM.MaterialPlacement, 
                      dbo.pStyleBOM.MaterialPlacementCode, dbo.pStyleBOM.MaterialPlacementDetail, dbo.pStyleBOM.MaterialImageID, 
                      dbo.pStyleBOM.MaterialImageVersion, dbo.pStyleBOM.NoColorMatch, dbo.pStyleBOM.SupplierID, 
                      dbo.pStyleBOM.ComponentTypeID, dbo.pStyleBOM.MaterialType, dbo.pStyleBOM.MaterialNo, dbo.pStyleBOM.MaterialName, 
                      dbo.pStyleBOM.Dim1TypeSel as DimManage, dbo.pStyleBOM.Dim1TypeSel, dbo.pStyleBOM.Dim2TypeSel, dbo.pStyleBOM.Dim3TypeSel,
                      dbo.pStyleBOM.A, dbo.pStyleBOM.B, dbo.pStyleBOM.C, dbo.pStyleBOM.D, dbo.pStyleBOM.E, dbo.pStyleBOM.F, 
                      dbo.pStyleBOM.G, dbo.pStyleBOM.I, dbo.pStyleBOM.H, dbo.pStyleBOM.J, dbo.pStyleBOM.K, dbo.pStyleBOM.L, 
                      dbo.pStyleBOM.M, dbo.pStyleBOM.N, dbo.pStyleBOM.O, dbo.pStyleBOM.P, dbo.pStyleBOM.Q, dbo.pStyleBOM.R, 
                      dbo.pStyleBOM.S, dbo.pStyleBOM.T, dbo.pStyleBOM.U, dbo.pStyleBOM.V, dbo.pStyleBOM.W, dbo.pStyleBOM.X, 
                      dbo.pStyleBOM.Y, dbo.pStyleBOM.Z, dbo.pStyleBOM.Source, dbo.pStyleBOM.Notes, dbo.pStyleBOM.Placement, 
                      dbo.pStyleBOM.VendorPrice, dbo.pStyleBOM.VolumePrice, dbo.pStyleBOM.VolumePriceMinimum, 
                      dbo.pStyleBOM.VendorProductionMin, dbo.pStyleBOM.VendorProductionLeadTime, dbo.pStyleBOM.DetailYesNo, 
                      dbo.pStyleBOM.ImageType, dbo.pStyleBOM.height, dbo.pStyleBOM.width, dbo.pStyleBOM.CDate, dbo.pStyleBOM.CUser, 
                      dbo.pStyleBOM.MDate, dbo.pStyleBOM.MUser, dbo.pStyleBOM.MChange, dbo.pStyleBOM.SChange, dbo.pStyleBOM.DChange, 
                      dbo.pStyleBOM.CChange, dbo.pStyleBOM.Action, dbo.pStyleBOM.ColorPlacement, dbo.pStyleBOM.MaterialSort, 
                      dbo.pStyleBOM.MaterialTrack, dbo.pStyleBOM.MaterialLinked, dbo.pStyleBOM.MaterialDimension, dbo.pStyleBOM.MaterialSizeA0, 
                      dbo.pStyleBOM.MaterialSizeA1, dbo.pStyleBOM.MaterialSizeA2, dbo.pStyleBOM.MaterialSizeA3, dbo.pStyleBOM.MaterialSizeA4, 
                      dbo.pStyleBOM.MaterialSizeA5, dbo.pStyleBOM.MaterialSizeA6, dbo.pStyleBOM.MaterialSizeA7, dbo.pStyleBOM.MaterialSizeA8, 
                      dbo.pStyleBOM.MaterialSizeA9, dbo.pStyleBOM.MaterialSizeA10, dbo.pStyleBOM.MaterialSizeA11, dbo.pStyleBOM.MaterialSizeA12, 
                      dbo.pStyleBOM.MaterialSizeA13, dbo.pStyleBOM.MaterialSizeA14, dbo.pStyleBOM.MaterialSizeA15, 
                      dbo.pStyleBOM.MaterialSizeA16, dbo.pStyleBOM.MaterialSizeA17, dbo.pStyleBOM.MaterialSizeA18, 
                      dbo.pStyleBOM.MaterialSizeA19, dbo.pStyleBOM.MaterialSizeB0, dbo.pStyleBOM.MaterialSizeB1, dbo.pStyleBOM.MaterialSizeB2, 
                      dbo.pStyleBOM.MaterialSizeB3, dbo.pStyleBOM.MaterialSizeB4, dbo.pStyleBOM.MaterialSizeB5, dbo.pStyleBOM.MaterialSizeB6, 
                      dbo.pStyleBOM.MaterialSizeB7, dbo.pStyleBOM.MaterialSizeB8, dbo.pStyleBOM.MaterialSizeB9, dbo.pStyleBOM.MaterialSizeB10, 
                      dbo.pStyleBOM.MaterialSizeB11, dbo.pStyleBOM.MaterialSizeB12, dbo.pStyleBOM.MaterialSizeB13, 
                      dbo.pStyleBOM.MaterialSizeB14, dbo.pStyleBOM.MaterialSizeB15, dbo.pStyleBOM.MaterialSizeB16, 
                      dbo.pStyleBOM.MaterialSizeB18, dbo.pStyleBOM.MaterialSizeB17, dbo.pStyleBOM.MaterialSizeB19, dbo.pStyleBOM.MaterialLining,
                       dbo.pStyleBOM.MaterialSizeID, dbo.pStyleBOM.MaterialPackLabelGroupID, dbo.pStyleBOM.MaterialBOM, 
                      dbo.uTradePartnerVendor.TradePartnerID, dbo.pMaterial.MultiDimension, dbo.pComponentType.ComponentOrder, dbo.pComponentType.ComponentPackLabel,
                          (SELECT     COUNT(*) AS NoComments
                            FROM          dbo.pMaterialComment
                            WHERE      (MaterialID = dbo.pStyleBOM.MaterialID)) AS NoComments, dbo.pMaterial.MaterialColorRequired, dbo.pMaterial.FactorySourced, 
                      dbo.pMaterial.MaterialCode, dbo.pMaterial.Active
FROM         dbo.uTradePartnerVendor RIGHT OUTER JOIN
                      dbo.pStyleBOM INNER JOIN
                      dbo.pMaterial ON dbo.pMaterial.MaterialID = dbo.pStyleBOM.MaterialID INNER JOIN
                      dbo.pComponentType ON dbo.pStyleBOM.MaterialType = dbo.pComponentType.ComponentTypeID ON 
                      dbo.uTradePartnerVendor.TradePartnerVendorID = dbo.pStyleBOM.TradePartnerVendorID LEFT JOIN
                      dbo.pMaterialSize ON pStyleBOM.MaterialID = pMaterialSize.MaterialID AND pStyleBOM.MaterialSizeID = pMaterialSize.MaterialSizeID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '07487', GetDate())
GO
