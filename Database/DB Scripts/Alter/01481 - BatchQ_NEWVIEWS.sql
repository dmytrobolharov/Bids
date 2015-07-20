

/****** Object:  View [dbo].[vwx_BatchQ_MaterialSeasonal_SEL]    Script Date: 05/31/2011 10:59:25 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_MaterialSeasonal_SEL]'))
DROP VIEW [dbo].[vwx_BatchQ_MaterialSeasonal_SEL]
GO

/****** Object:  View [dbo].[vwx_BatchQ_MaterialSelected_SEL]    Script Date: 05/31/2011 10:59:25 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_MaterialSelected_SEL]'))
DROP VIEW [dbo].[vwx_BatchQ_MaterialSelected_SEL]
GO

/****** Object:  View [dbo].[vwx_BatchQJob_SEL]    Script Date: 05/31/2011 10:59:25 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQJob_SEL]'))
DROP VIEW [dbo].[vwx_BatchQJob_SEL]
GO

/****** Object:  View [dbo].[vwx_BatchQPage_SEL]    Script Date: 05/31/2011 10:59:25 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQPage_SEL]'))
DROP VIEW [dbo].[vwx_BatchQPage_SEL]
GO

/****** Object:  View [dbo].[vwx_BatchQ_MaterialSeasonal_SEL]    Script Date: 05/31/2011 10:59:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_BatchQ_MaterialSeasonal_SEL]
AS
SELECT     dbo.pMaterial.MaterialID, dbo.pMaterial.TempID, dbo.pMaterial.TempNo, dbo.pMaterial.MaterialImageID, dbo.pMaterial.MaterialImageVersion, 
                      dbo.pMaterial.MaterialImageDetailID, dbo.pMaterial.MaterialImageDetailVersion, dbo.pMaterial.NoColorMatch, dbo.pMaterial.SupplierID, dbo.pMaterial.MaterialType, 
                      dbo.pMaterial.MaterialNo, dbo.pMaterial.MaterialName, dbo.pMaterial.A, dbo.pMaterial.B, dbo.pMaterial.C, dbo.pMaterial.D, dbo.pMaterial.E, dbo.pMaterial.F, 
                      dbo.pMaterial.G, dbo.pMaterial.H, dbo.pMaterial.I, dbo.pMaterial.J, dbo.pMaterial.K, dbo.pMaterial.L, dbo.pMaterial.M, dbo.pMaterial.N, dbo.pMaterial.O, 
                      dbo.pMaterial.P, dbo.pMaterial.Q, dbo.pMaterial.R, dbo.pMaterial.S, dbo.pMaterial.T, dbo.pMaterial.U, dbo.pMaterial.V, dbo.pMaterial.W, dbo.pMaterial.X, 
                      dbo.pMaterial.Y, dbo.pMaterial.Z, dbo.pMaterial.Source, dbo.pMaterial.VendorPrice, dbo.pMaterial.VolumePrice, dbo.pMaterial.VolumePriceMinimum, 
                      dbo.pMaterial.VendorProductionMin, dbo.pMaterial.VendorProductionLeadTime, dbo.pMaterial.ImageType1, dbo.pMaterial.height, dbo.pMaterial.width, 
                      dbo.pMaterial.CDate, dbo.pMaterial.CUser, dbo.pMaterial.MDate, dbo.pMaterial.MUser, dbo.pMaterial.MChange, dbo.pMaterial.DChange, dbo.pMaterial.Action, 
                      dbo.pMaterial.Status, dbo.pMaterial.Active, dbo.pMaterial.MultiDimension, dbo.pMaterial.UOM, dbo.pMaterial.MaterialCode, dbo.pMaterial.MaterialCodeNo, 
                      dbo.pMaterialSeasonYear.SeasonYearID
FROM         dbo.pMaterial INNER JOIN
                      dbo.pMaterialSeasonYear ON dbo.pMaterial.MaterialID = dbo.pMaterialSeasonYear.MaterialID

GO

/****** Object:  View [dbo].[vwx_BatchQ_MaterialSelected_SEL]    Script Date: 05/31/2011 10:59:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vwx_BatchQ_MaterialSelected_SEL]
AS
SELECT     MaterialID, TempID, TempNo, MaterialImageID, MaterialImageVersion, MaterialImageDetailID, MaterialImageDetailVersion, NoColorMatch, SupplierID, MaterialType, 
                      MaterialNo, MaterialName, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, Source, VendorPrice, VolumePrice, VolumePriceMinimum, 
                      VendorProductionMin, VendorProductionLeadTime, ImageType1, height, width, CDate, CUser, MDate, MUser, MChange, DChange, Action, Status, Active, 
                      MultiDimension, UOM, MaterialCode, MaterialCodeNo
FROM         dbo.pMaterial
GO

/****** Object:  View [dbo].[vwx_BatchQJob_SEL]    Script Date: 05/31/2011 10:59:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_BatchQJob_SEL]
AS
SELECT     TOP (100) PERCENT dbo.pBatchQueueJob.BatchQueueJobID, dbo.pBatchQueueJob.BatchQueueID, dbo.pBatchQueueJob.BatchQueueJobDate, 
                      dbo.pBatchQueueJob.BatchQueueJobTeamID, dbo.pBatchQueueJob.BatchQueueJobStatusID, dbo.pBatchQueueJob.BatchQueueJobCompleted, 
                      dbo.pBatchQueue.BatchQueueTypeID, dbo.pBatchQueue.BatchQueueName, dbo.pBatchQueue.BatchQueueDesc, dbo.pBatchQueue.BatchQueueUrl, 
                      dbo.pBatchQueue.BatchQueueIcon, dbo.pBatchQueuePage.BatchQueuePageID, dbo.pBatchQueuePage.BatchQueuePageTypeID, 
                      dbo.pBatchQueuePage.BatchQueuePageOrder, dbo.pBatchQueuePageType.BatchQueuePageUrl
FROM         dbo.pBatchQueueJob INNER JOIN
                      dbo.pBatchQueue ON dbo.pBatchQueueJob.BatchQueueID = dbo.pBatchQueue.BatchQueueID INNER JOIN
                      dbo.pBatchQueuePage ON dbo.pBatchQueue.BatchQueueID = dbo.pBatchQueuePage.BatchQueueID INNER JOIN
                      dbo.pBatchQueuePageType ON dbo.pBatchQueuePage.BatchQueuePageTypeID = dbo.pBatchQueuePageType.BatchQueuePageTypeID
WHERE     (dbo.pBatchQueuePage.BatchQueuePageOrder = '0000')
ORDER BY dbo.pBatchQueueJob.BatchQueueJobDate DESC

GO

/****** Object:  View [dbo].[vwx_BatchQPage_SEL]    Script Date: 05/31/2011 10:59:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_BatchQPage_SEL]
AS
SELECT     TOP (100) PERCENT dbo.pBatchQueuePage.BatchQueuePageID, dbo.pBatchQueuePage.BatchQueuePageTypeID, dbo.pBatchQueuePage.BatchQueuePageOrder, 
                      dbo.pBatchQueuePageType.BatchQueuePageUrl, dbo.pBatchQueuePageType.BatchQueuePageTypeName, dbo.pBatchQueuePageType.BatchQueuePageTypeDesc, 
                      dbo.pBatchQueuePage.BatchQueueID
FROM         dbo.pBatchQueuePage INNER JOIN
                      dbo.pBatchQueuePageType ON dbo.pBatchQueuePage.BatchQueuePageTypeID = dbo.pBatchQueuePageType.BatchQueuePageTypeID
ORDER BY dbo.pBatchQueuePage.BatchQueuePageOrder

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01481', GetDate())
GO
