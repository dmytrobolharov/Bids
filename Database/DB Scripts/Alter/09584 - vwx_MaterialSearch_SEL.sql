IF OBJECT_ID(N'[dbo].[vwx_MaterialSearch_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_MaterialSearch_SEL]
GO
CREATE VIEW [dbo].[vwx_MaterialSearch_SEL]
AS
SELECT     a.MaterialID, a.TempID, a.TempNo, a.MaterialImageID, a.MaterialImageVersion, a.MaterialImageDetailID, a.MaterialImageDetailVersion, a.NoColorMatch, a.SupplierID, a.MaterialType, a.MaterialNo, 
                      a.MaterialName, a.A, a.B, a.C, a.D, a.E, a.F, a.G, a.H, a.I, a.J, a.K, a.L, a.M, a.N, a.O, a.P, a.Q, a.R, a.S, a.T, a.U, a.V, a.W, a.X, a.Y, a.Z, a.Source, a.Notes, a.VendorPrice, a.VolumePrice, 
                      a.VolumePriceMinimum, a.VendorProductionMin, a.VendorProductionLeadTime, a.MaterialPlacement, a.DetailYesNo, a.ImageType1, a.height, a.width, a.Action, a.Status, a.Active, a.MultiDimension, 
                      a.UOM, a.MaterialCode, a.MaterialCodeNo, a.SAPCode, a.SAPControl, a.MaterialColorRequired, a.FactorySourced, b.TradepartnerId, b.TradepartnerVendorId, b.MaterialTradePartnerCustom1, 
                      b.MaterialTradePartnerCustom2, b.MaterialTradePartnerCustom3, b.MaterialTradePartnerCustom4, b.MaterialTradePartnerCustom5, b.MaterialTradePartnerCustom6, b.MaterialTradePartnerCustom7, 
                      b.MaterialTradePartnerCustom8, b.MaterialTradePartnerCustom9, b.MaterialTradePartnerCustom10, b.MaterialTradePartnerCustom11, b.MaterialTradePartnerCustom12, 
                      b.MaterialTradePartnerCustom13, b.MaterialTradePartnerCustom14, b.MaterialTradePartnerCustom15, b.MaterialTradePartnerCustom16, b.MaterialTradePartnerCustom17, 
                      b.MaterialTradePartnerCustom18, b.MaterialTradePartnerCustom19, b.MaterialTradePartnerCustom20, b.MaterialTradePartnerCustom21, b.MaterialTradePartnerCustom22, 
                      b.MaterialTradePartnerCustom23, b.MaterialTradePartnerCustom24, b.MaterialTradePartnerCustom25, b.SeasonYearID, f.Season, f.Year, a.MUser, a.MDate, a.CDate, a.CUser, a.MChange, 
                      '<img src="../System/Control/ImageStream.ashx?S=050&V=' + CAST(a.MaterialImageVersion AS NVARCHAR(10)) + '&IID=' + CAST(a.MaterialImageID AS NVARCHAR(40)) + '" />' AS ImagePath, 
                      a.IntroSeasonYearID, dbo.pComponentType.ComponentDescription, a.TACalTemplateId, a.EnableProductPages, a.CurrencyType, a.DueDate, a.DutyCategoryID, a.MaterialTemplateID, 
                      a.HeaderLocked, a.DChange
FROM         dbo.pMaterial AS a WITH (NOLOCK) LEFT OUTER JOIN
                      dbo.pMaterialTradePartner AS b WITH (NOLOCK) ON a.MaterialID = b.MaterialId LEFT OUTER JOIN
                      dbo.pSeasonYear AS f WITH (NOLOCK) ON f.SeasonYearID = b.SeasonYearID INNER JOIN
                      dbo.pComponentType ON a.MaterialType = dbo.pComponentType.ComponentTypeID
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09584', GetDate())
GO