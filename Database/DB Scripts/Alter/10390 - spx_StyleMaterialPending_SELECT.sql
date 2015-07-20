IF OBJECT_ID(N'[dbo].[spx_StyleMaterialPending_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleMaterialPending_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleMaterialPending_SELECT]
(
@StyleId uniqueidentifier,
@StyleSet int
)
AS

SELECT pStyleMaterialTemp.StyleMaterialID, pComponentType.ComponentTypeID, pComponentType.ComponentDescription, 
      pStyleMaterialTemp.MainMaterial, pStyleMaterialTemp.Development, pStyleMaterialTemp.MiscColor, pStyleMaterialTemp.StyleSet, pStyleMaterialTemp.StyleID, 
      pStyleMaterialTemp.UOM, pStyleMaterialTemp.Qty, pStyleMaterialTemp.MaterialPrice, pStyleMaterialTemp.Ext, pStyleMaterialTemp.MaterialSize, 
      pStyleMaterialTemp.MaterialID, pStyleMaterialTemp.MaterialPlacement, pStyleMaterialTemp.MaterialPlacementCode, pStyleMaterialTemp.MaterialPlacementDetail, 
      pStyleMaterialTemp.MaterialImageID, pStyleMaterialTemp.MaterialImageVersion, pStyleMaterialTemp.NoColorMatch, pStyleMaterialTemp.SupplierID, 
      pStyleMaterialTemp.ComponentTypeID, pStyleMaterialTemp.MaterialType, pStyleMaterialTemp.MaterialNo, pStyleMaterialTemp.MaterialName, pStyleMaterialTemp.A, 
      pStyleMaterialTemp.B, pStyleMaterialTemp.C, pStyleMaterialTemp.D, pStyleMaterialTemp.E, pStyleMaterialTemp.F, pStyleMaterialTemp.G, pStyleMaterialTemp.H, 
      pStyleMaterialTemp.I, pStyleMaterialTemp.J, pStyleMaterialTemp.K, pStyleMaterialTemp.L, pStyleMaterialTemp.M, pStyleMaterialTemp.N, pStyleMaterialTemp.O, 
      pStyleMaterialTemp.P, pStyleMaterialTemp.Q, pStyleMaterialTemp.R, pStyleMaterialTemp.S, pStyleMaterialTemp.T, pStyleMaterialTemp.U, pStyleMaterialTemp.V, 
      pStyleMaterialTemp.W, pStyleMaterialTemp.X, pStyleMaterialTemp.Y, pStyleMaterialTemp.Z, pStyleMaterialTemp.Source, pStyleMaterialTemp.Notes, 
      pStyleMaterialTemp.Placement, pStyleMaterialTemp.VendorPrice, pStyleMaterialTemp.VolumePrice, pStyleMaterialTemp.VolumePriceMinimum, 
      pStyleMaterialTemp.VendorProductionMin, pStyleMaterialTemp.VendorProductionLeadTime, pStyleMaterialTemp.DetailYesNo, pStyleMaterialTemp.ImageType, 
      pStyleMaterialTemp.height, pStyleMaterialTemp.width, pStyleMaterialTemp.CDate, pStyleMaterialTemp.CUser, pStyleMaterialTemp.MDate, 
      pStyleMaterialTemp.MUser, pStyleMaterialTemp.MChange, pStyleMaterialTemp.SChange, pStyleMaterialTemp.DChange, pStyleMaterialTemp.CChange, 
      pStyleMaterialTemp.Action, pStyleMaterialTemp.ColorPlacement, pStyleMaterialTemp.Artwork, pStyleMaterialTemp.License, pStyleMaterialTemp.Colorway, 
      pStyleMaterialTemp.MaterialTrack, pStyleMaterialTemp.MaterialLinked, pStyleMaterialTemp.MaterialDimension, 
      pStyleMaterialTemp.MaterialLining, MaterialSizeID, pStyleMaterialTemp.MaterialPackLabelGroupID, pStyleMaterialTemp.TradePartnerID, 
      pStyleMaterialTemp.TradePartnerVendorID, pStyleMaterialTemp.MaterialBOM,  
      pComponentType.ComponentOrder, '' AS GroupName, 0 AS MaterialDel ,
	  '<table width="100%" ><tr><td align="center">' +
	  dbo.fnx_GetStreamingImageHTML(pStyleMaterialTemp.MaterialImageID, pStyleMaterialTemp.MaterialImageVersion, 50, '') +
	  '</td></tr></table>' AS MaterialImage
FROM  pStyleMaterialTemp 
INNER JOIN pComponentType ON pStyleMaterialTemp.MaterialType = pComponentType.ComponentTypeID
WHERE pStyleMaterialTemp.StyleId = @StyleId AND pStyleMaterialTemp.StyleSet = @StyleSet
ORDER BY pStyleMaterialTemp.MainMaterial DESC, pComponentType.ComponentOrder

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10390', GetUTCDate())
GO
