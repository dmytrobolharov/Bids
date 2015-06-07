IF OBJECT_ID(N'[dbo].[vwx_BatchQ_MaterialSeasonalImage_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_BatchQ_MaterialSeasonalImage_SEL]
GO

CREATE VIEW [dbo].[vwx_BatchQ_MaterialSeasonalImage_SEL]
AS
SELECT DISTINCT m.MaterialID, m.TempID, m.TempNo, m.MaterialImageID, m.MaterialImageVersion, 
       m.MaterialImageDetailID, m.MaterialImageDetailVersion, m.NoColorMatch, m.SupplierID, m.MaterialType, 
       m.MaterialNo, m.MaterialName, m.A, m.B, m.C, m.D, m.E, m.F, m.G, m.H, m.I, m.J, m.K, m.L, m.M, m.N, m.O, 
       m.P, m.Q, m.R, m.S, m.T, m.U, m.V, m.W, m.X, m.Y, m.Z, m.Source, m.VendorPrice, m.VolumePrice, m.VolumePriceMinimum, 
       m.VendorProductionMin, m.VendorProductionLeadTime, m.ImageType1, m.height, m.width, m.CDate, m.CUser, m.MDate, m.MUser,
	   m.MChange, m.DChange, m.Action, m.Status, m.Active, m.MultiDimension, m.UOM, m.MaterialCode, m.MaterialCodeNo, 
       msy.SeasonYearID, dbo.fnx_GetStreamingImageHTML(m.MaterialImageID, m.MaterialImageVersion, 50, '') AS ImagePath, 
       dbo.fnx_GetStreamingImageHTML(m.MaterialImageID, m.MaterialImageVersion, 150, '') AS DataListImagePath
FROM dbo.pMaterial m WITH (NOLOCK) 
INNER JOIN dbo.pMaterialSeasonYear msy WITH (NOLOCK) ON msy.MaterialID = m.MaterialID


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10313', GetUTCDate())
GO
