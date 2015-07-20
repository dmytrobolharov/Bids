IF OBJECT_ID(N'[dbo].[spx_StyleCopyComponent_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleCopyComponent_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleCopyComponent_SELECT](
	@StyleID UNIQUEIDENTIFIER, 
	@StyleSet INT, 
	@TeamID UNIQUEIDENTIFIER
)
AS	


SELECT    pStyleMaterials.StyleMaterialID, 
      ISNULL(pStyleMaterials.MainMaterial,0) AS MainMaterial, pStyleMaterials.Development, pStyleMaterials.MiscColor, pStyleMaterials.StyleSet, 
      pStyleMaterials.StyleID, (SELECT UOM FROM UOM WHERE UOMValue = pStyleMaterials.UOM) AS UOM, pStyleMaterials.Qty, pStyleMaterials.MaterialPrice, pStyleMaterials.Ext, 
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
      pStyleMaterials.MaterialBOM, 
	  dbo.fnx_GetStreamingImageHTML(pStyleMaterials.MaterialImageID, pStyleMaterials.MaterialImageVersion, 50, '') AS MaterialImage
FROM  pStyleMaterials 
WHERE StyleID  = @StyleID 
	AND StyleSet = @StyleSet
	ORDER BY pStyleMaterials.MainMaterial DESC,  
pStyleMaterials.MaterialSort, pStyleMaterials.MaterialNo, pStyleMaterials.MaterialName, pStyleMaterials.StyleMaterialId


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10383', GetUTCDate())
GO
