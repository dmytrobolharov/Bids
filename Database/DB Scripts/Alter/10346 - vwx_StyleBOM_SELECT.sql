IF OBJECT_ID(N'[dbo].[vwx_StyleBOM_SELECT]') IS NOT NULL
 DROP VIEW [dbo].[vwx_StyleBOM_SELECT]
GO

CREATE VIEW [dbo].[vwx_StyleBOM_SELECT]
AS
SELECT DISTINCT sb.AutoColor, sb.Artwork, sb.License, sb.Colorway, tpv.VendorName, sb.StyleMaterialID, 
       sb.StyleMaterialMasterID, sb.CopyStyleMaterialID, sb.MainMaterial, sb.Development, sb.MiscColor, 
	   sb.StyleSet, sb.WorkflowId,sb.WorkflowItemId,sb.StyleBOMDimensionId, sb.StyleID, sb.UOM, 
	   sb.MaterialColorId, sb.Qty, sb.MaterialPrice, sb.Ext, ms.MaterialSize, sb.MaterialID, sb.MaterialPlacement, 
       sb.MaterialPlacementCode, sb.MaterialPlacementDetail, sb.MaterialImageID, sb.MaterialImageVersion, 
	   sb.NoColorMatch, sb.SupplierID, sb.ComponentTypeID, sb.MaterialType, sb.MaterialNo, sb.MaterialName, 
       sb.Dim1TypeSel as DimManage, sb.Dim1TypeSel, sb.Dim2TypeSel, sb.Dim3TypeSel,
       sb.A, sb.B, sb.C, sb.D, sb.E, sb.F, sb.G, sb.I, sb.H, sb.J, sb.K, sb.L, sb.M, sb.N, sb.O, sb.P, sb.Q, sb.R, 
       sb.S, sb.T, sb.U, sb.V, sb.W, sb.X, sb.Y, sb.Z, sb.Source, sb.Notes, sb.Placement, sb.VendorPrice, 
	   sb.VolumePrice, sb.VolumePriceMinimum, sb.VendorProductionMin, sb.VendorProductionLeadTime, sb.DetailYesNo, 
       sb.ImageType, sb.height, sb.width, sb.CDate, sb.CUser, sb.MDate, sb.MUser, sb.MChange, sb.SChange, sb.DChange, 
       sb.CChange, sb.Action, sb.ColorPlacement, sb.MaterialSort, sb.MaterialTrack, sb.MaterialLinked, 
	   sb.MaterialDimension, sb.MaterialSizeA0, sb.MaterialSizeA1, sb.MaterialSizeA2, sb.MaterialSizeA3, 
	   sb.MaterialSizeA4, sb.MaterialSizeA5, sb.MaterialSizeA6, sb.MaterialSizeA7, sb.MaterialSizeA8, 
       sb.MaterialSizeA9, sb.MaterialSizeA10, sb.MaterialSizeA11, sb.MaterialSizeA12, sb.MaterialSizeA13, 
	   sb.MaterialSizeA14, sb.MaterialSizeA15, sb.MaterialSizeA16, sb.MaterialSizeA17, sb.MaterialSizeA18, 
       sb.MaterialSizeA19, sb.MaterialSizeB0, sb.MaterialSizeB1, sb.MaterialSizeB2, sb.MaterialSizeB3, 
	   sb.MaterialSizeB4, sb.MaterialSizeB5, sb.MaterialSizeB6, sb.MaterialSizeB7, sb.MaterialSizeB8, 
	   sb.MaterialSizeB9, sb.MaterialSizeB10, sb.MaterialSizeB11, sb.MaterialSizeB12, sb.MaterialSizeB13, 
       sb.MaterialSizeB14, sb.MaterialSizeB15, sb.MaterialSizeB16, sb.MaterialSizeB18, sb.MaterialSizeB17, 
	   sb.MaterialSizeB19, sb.MaterialLining, sb.MaterialSizeID, sb.MaterialPackLabelGroupID, sb.MaterialBOM, 
       tpv.TradePartnerID, m.MultiDimension, ct.ComponentOrder, ct.ComponentPackLabel,
       (SELECT COUNT(*) FROM dbo.pMaterialComment mc WHERE mc.MaterialID = sb.MaterialID) AS NoComments, 
	   m.MaterialColorRequired, m.FactorySourced, m.MaterialCode, m.Active,  
       dbo.fnx_GetStreamingImageHTML(sb.MaterialImageID, sb.MaterialImageVersion, 25, '') AS MaterialImage
FROM dbo.uTradePartnerVendor tpv
RIGHT OUTER JOIN dbo.pStyleBOM sb 
 INNER JOIN dbo.pMaterial m ON m.MaterialID = sb.MaterialID 
 INNER JOIN dbo.pComponentType ct ON sb.MaterialType = ct.ComponentTypeID 
 ON tpv.TradePartnerVendorID = sb.TradePartnerVendorID 
LEFT JOIN dbo.pMaterialSize ms ON sb.MaterialID = ms.MaterialID AND sb.MaterialSizeID = ms.MaterialSizeID


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10346', GetUTCDate())
GO
