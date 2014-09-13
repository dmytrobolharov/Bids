IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_MaterialSeasonalImage_SEL]'))
DROP VIEW [dbo].[vwx_BatchQ_MaterialSeasonalImage_SEL]
GO

CREATE VIEW [dbo].[vwx_BatchQ_MaterialSeasonalImage_SEL]
AS
SELECT DISTINCT 
                      dbo.pMaterial.MaterialID, dbo.pMaterial.TempID, dbo.pMaterial.TempNo, dbo.pMaterial.MaterialImageID, dbo.pMaterial.MaterialImageVersion, 
                      dbo.pMaterial.MaterialImageDetailID, dbo.pMaterial.MaterialImageDetailVersion, dbo.pMaterial.NoColorMatch, dbo.pMaterial.SupplierID, dbo.pMaterial.MaterialType, 
                      dbo.pMaterial.MaterialNo, dbo.pMaterial.MaterialName, dbo.pMaterial.A, dbo.pMaterial.B, dbo.pMaterial.C, dbo.pMaterial.D, dbo.pMaterial.E, dbo.pMaterial.F, 
                      dbo.pMaterial.G, dbo.pMaterial.H, dbo.pMaterial.I, dbo.pMaterial.J, dbo.pMaterial.K, dbo.pMaterial.L, dbo.pMaterial.M, dbo.pMaterial.N, dbo.pMaterial.O, 
                      dbo.pMaterial.P, dbo.pMaterial.Q, dbo.pMaterial.R, dbo.pMaterial.S, dbo.pMaterial.T, dbo.pMaterial.U, dbo.pMaterial.V, dbo.pMaterial.W, dbo.pMaterial.X, 
                      dbo.pMaterial.Y, dbo.pMaterial.Z, dbo.pMaterial.Source, dbo.pMaterial.VendorPrice, dbo.pMaterial.VolumePrice, dbo.pMaterial.VolumePriceMinimum, 
                      dbo.pMaterial.VendorProductionMin, dbo.pMaterial.VendorProductionLeadTime, dbo.pMaterial.ImageType1, dbo.pMaterial.height, dbo.pMaterial.width, 
                      dbo.pMaterial.CDate, dbo.pMaterial.CUser, dbo.pMaterial.MDate, dbo.pMaterial.MUser, dbo.pMaterial.MChange, dbo.pMaterial.DChange, dbo.pMaterial.Action, 
                      dbo.pMaterial.Status, dbo.pMaterial.Active, dbo.pMaterial.MultiDimension, dbo.pMaterial.UOM, dbo.pMaterial.MaterialCode, dbo.pMaterial.MaterialCodeNo, 
                      dbo.pMaterialSeasonYear.SeasonYearID, '<img src="../System/Control/ImageStream.ashx?S=050&V=' + CAST(dbo.pMaterial.MaterialImageVersion AS NVARCHAR(10)) 
                      + '&IID=' + CAST(ISNULL(dbo.pMaterial.MaterialImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(40)) + '" />' AS ImagePath, 
                      '../System/Control/ImageStream.ashx?S=150&V=' + CAST(dbo.pMaterial.MaterialImageVersion AS NVARCHAR(10)) 
                      + '&IID=' + CAST(ISNULL(dbo.pMaterial.MaterialImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(40)) AS DataListImagePath
FROM         dbo.pMaterial WITH (NOLOCK) INNER JOIN
                      dbo.pMaterialSeasonYear WITH (NOLOCK) ON dbo.pMaterialSeasonYear.MaterialID = dbo.pMaterial.MaterialID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06958', GetDate())
GO
