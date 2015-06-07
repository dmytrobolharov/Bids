IF OBJECT_ID(N'[dbo].[spx_StyleMaterialSummary_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleMaterialSummary_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleMaterialSummary_SELECT]
(
@StyleId uniqueidentifier,
@StyleSet int
)
AS

SELECT    pStyleMaterials.StyleMaterialID, pComponentType.ComponentTypeID, pComponentType.ComponentDescription, 
      ISNULL(pStyleMaterials.MainMaterial,0) AS MainMaterial, pStyleMaterials.Development, pStyleMaterials.MiscColor, pStyleMaterials.StyleSet, 
      pStyleMaterials.StyleID, pStyleMaterials.UOM,UOM.UOM as "UOMValue", pStyleMaterials.Qty, pStyleMaterials.MaterialPrice, pStyleMaterials.Ext, 
      pStyleMaterials.MaterialSize, pStyleMaterials.MaterialID, pStyleMaterials.MaterialPlacement, 
      pStyleMaterials.MaterialPlacementCode, pStyleMaterials.MaterialPlacementDetail, pStyleMaterials.MaterialImageID, 
      pStyleMaterials.MaterialImageVersion, pStyleMaterials.NoColorMatch, pStyleMaterials.SupplierID, 
      pStyleMaterials.ComponentTypeID AS Expr1, pStyleMaterials.MaterialType, pStyleMaterials.MaterialNo, 
      pStyleMaterials.MaterialName, pStyleMaterials.A, pStyleMaterials.B, pStyleMaterials.C, pStyleMaterials.D, 
      pStyleMaterials.E, pStyleMaterials.F, pStyleMaterials.G, pStyleMaterials.H, pStyleMaterials.I, pStyleMaterials.J, 
      pStyleMaterials.K, pStyleMaterials.L, pStyleMaterials.M, pStyleMaterials.N, pStyleMaterials.O, pStyleMaterials.P, 
      pStyleMaterials.Q, pStyleMaterials.R, pStyleMaterials.S, pStyleMaterials.T, pStyleMaterials.U, pStyleMaterials.V, 
      pStyleMaterials.W, pStyleMaterials.X, pStyleMaterials.Y, pStyleMaterials.Z, pStyleMaterials.Source, pStyleMaterials.Notes, 
      pStyleMaterials.Placement, pStyleMaterials.VendorPrice, pStyleMaterials.VolumePrice, pStyleMaterials.VolumePriceMinimum, 
      pStyleMaterials.VendorProductionMin, pStyleMaterials.VendorProductionLeadTime, pStyleMaterials.DetailYesNo, 
      pStyleMaterials.ImageType, pStyleMaterials.height, pStyleMaterials.width, pStyleMaterials.CDate, pStyleMaterials.CUser, 
      pStyleMaterials.MDate, pStyleMaterials.MUser, pStyleMaterials.MChange, pStyleMaterials.SChange, pStyleMaterials.DChange, 
      pStyleMaterials.CChange, pStyleMaterials.Action, pStyleMaterials.ColorPlacement, pStyleMaterials.Artwork, 
      pStyleMaterials.License, pStyleMaterials.Colorway, pStyleMaterials.MaterialSort, pStyleMaterials.MaterialTrack, 
      pStyleMaterials.MaterialLinked, pStyleMaterials.MaterialDimension, pStyleMaterials.MaterialLining, pStyleMaterials.MaterialSizeID, 
      pStyleMaterials.MaterialPackLabelGroupID, pStyleMaterials.TradePartnerID, pStyleMaterials.TradePartnerVendorID, 
      pStyleMaterials.MaterialBOM, pComponentType.ComponentOrder, '' AS GroupName, 0 AS MaterialDel, 
	  --pMaterialTradePartner.MaterialTradePartnerCustom1,
	  dbo.fnx_GetStreamingImageHTML(pStyleMaterials.MaterialImageID, pStyleMaterials.MaterialImageVersion, 50, '') AS MaterialImage, 
	  pStyleHeader.HeaderLocked
FROM  pStyleMaterials 
	INNER JOIN pMaterial ON pStyleMaterials.MaterialID = pMaterial.MaterialID
	INNER JOIN  pComponentType ON pStyleMaterials.MaterialType = pComponentType.ComponentTypeID 
	INNER JOIN pStyleHeader ON pStyleHeader.StyleID = pStyleMaterials.StyleID
	LEFT OUTER JOIN UOM ON UOM.UOMValue = pStyleMaterials.UOM
	--LEFT OUTER JOIN pMaterialTradePartner ON ( pStyleMaterials.TradePartnerVendorID = pMaterialTradePartner.TradePartnerVendorID AND pStyleMaterials.MaterialID = pMaterialTradePartner.MaterialID)
WHERE pStyleMaterials.StyleId = @StyleId AND pStyleMaterials.StyleSet = @StyleSet
ORDER BY pStyleMaterials.MainMaterial DESC, pComponentType.ComponentOrder, 
pStyleMaterials.MaterialSort, pStyleMaterials.MaterialNo, pStyleMaterials.MaterialName, pStyleMaterials.StyleMaterialId



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10391', GetUTCDate())
GO
