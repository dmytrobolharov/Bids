IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_MaterialSeasonalImage_SEL]'))
DROP VIEW [dbo].[vwx_BatchQ_MaterialSeasonalImage_SEL]
GO

CREATE VIEW [dbo].[vwx_BatchQ_MaterialSeasonalImage_SEL]
AS
SELECT DISTINCT 
                      MaterialID, TempID, TempNo, MaterialImageID, MaterialImageVersion, MaterialImageDetailID, MaterialImageDetailVersion, NoColorMatch, SupplierID, MaterialType, 
                      MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, Source, VendorPrice, VolumePrice, VolumePriceMinimum, 
                      VendorProductionMin, VendorProductionLeadTime, ImageType1, height, width, CDate, CUser, MDate, MUser, MChange, DChange, Action, Status, Active, 
                      MultiDimension, UOM, MaterialCode, MaterialCodeNo, '<img src="../System/Control/ImageStream.ashx?S=050&V=' + CAST(MaterialImageVersion AS NVARCHAR(10)) 
                      + '&IID=' + CAST(ISNULL(MaterialImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(40)) + '" />' AS ImagePath, 
                      '../System/Control/ImageStream.ashx?S=150&V=' + CAST(MaterialImageVersion AS NVARCHAR(10)) + '&IID=' + CAST(ISNULL(MaterialImageID, 
                      '00000000-0000-0000-0000-000000000000') AS NVARCHAR(40)) AS DataListImagePath
FROM         dbo.pMaterial WITH (NOLOCK)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06855', GetDate())
GO
