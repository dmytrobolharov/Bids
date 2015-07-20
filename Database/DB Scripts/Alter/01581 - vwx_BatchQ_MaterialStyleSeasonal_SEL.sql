IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_MaterialStyleSeasonal_SEL]') AND type = N'V' )
	DROP VIEW [dbo].[vwx_BatchQ_MaterialStyleSeasonal_SEL]
GO


CREATE VIEW [dbo].[vwx_BatchQ_MaterialStyleSeasonal_SEL]
AS
SELECT DISTINCT 
  pMaterial.MaterialID, pMaterial.TempID, pMaterial.TempNo, pMaterial.MaterialImageID, pMaterial.MaterialImageVersion, 
  pMaterial.MaterialImageDetailID, pMaterial.MaterialImageDetailVersion, pMaterial.NoColorMatch, pMaterial.SupplierID, pMaterial.MaterialType, 
  pMaterial.MaterialNo, pMaterial.MaterialName, pMaterial.A, pMaterial.B, pMaterial.C, pMaterial.D, pMaterial.E, pMaterial.F, 
  pMaterial.G, pMaterial.H, pMaterial.I, pMaterial.J, pMaterial.K, pMaterial.L, pMaterial.M, pMaterial.N, pMaterial.O, 
  pMaterial.P, pMaterial.Q, pMaterial.R, pMaterial.S, pMaterial.T, pMaterial.U, pMaterial.V, pMaterial.W, pMaterial.X, 
  pMaterial.Y, pMaterial.Z, pMaterial.Source, pMaterial.VendorPrice, pMaterial.VolumePrice, pMaterial.VolumePriceMinimum, 
  pMaterial.VendorProductionMin, pMaterial.VendorProductionLeadTime, pMaterial.ImageType1, pMaterial.height, pMaterial.width, 
  pMaterial.CDate, pMaterial.CUser, pMaterial.MDate, pMaterial.MUser, pMaterial.MChange, pMaterial.DChange, pMaterial.Action, 
  pMaterial.Status, pMaterial.Active, pMaterial.MultiDimension, pMaterial.UOM, pMaterial.MaterialCode, pMaterial.MaterialCodeNo, 
  pMaterialColorSeasonYear.SeasonYearID
FROM pMaterial INNER JOIN
  pMaterialColorSeasonYear ON pMaterial.MaterialID = pMaterialColorSeasonYear.MaterialID
AND EXISTS (SELECT MaterialID FROM pStyleMaterials WHERE MaterialID = pMaterial.MaterialID)
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01581'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01581', GetDate())
END	

GO
