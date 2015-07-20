IF OBJECT_ID(N'[dbo].[vwx_Planning_MissingMaterials_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_Planning_MissingMaterials_SEL]
GO
CREATE VIEW [dbo].[vwx_Planning_MissingMaterials_SEL]
AS
SELECT DISTINCT 
                      pli.PlanningID, ssy.SeasonYearID, ct.ComponentDescription, m.MaterialID, m.TempID, m.TempNo, m.MaterialImageID, m.MaterialImageVersion, 
                      m.MaterialImageDetailID, m.MaterialImageDetailVersion, m.NoColorMatch, m.SupplierID, m.MaterialType, m.MaterialNo, m.MaterialName, m.A, m.B, m.C, m.D, m.E, 
                      m.F, m.G, m.H, m.I, m.J, m.K, m.L, m.M, m.N, m.O, m.P, m.Q, m.R, m.S, m.T, m.U, m.V, m.W, m.X, m.Y, m.Z, m.Source, m.Notes, m.VendorPrice, m.VolumePrice, 
                      m.VolumePriceMinimum, m.VendorProductionMin, m.VendorProductionLeadTime, m.MaterialPlacement, m.DetailYesNo, m.ImageType1, m.height, m.width, m.CDate, 
                      m.CUser, m.MDate, m.MUser, m.MChange, m.DChange, m.Action, m.Status, m.Active, m.MultiDimension, m.UOM, m.MaterialCode, m.MaterialCodeNo, m.SAPCode, 
                      m.SAPControl, m.MaterialColorRequired, m.FactorySourced, m.TradePartnerID, m.TradePartnerVendorID, m.HeaderLocked, m.MaterialTemplateID, m.DutyCategoryID, 
                      m.DueDate, m.CurrencyType, m.IntroSeasonYearID, m.TACalTemplateId, m.EnableProductPages
FROM         dbo.pPlanningItem AS pli INNER JOIN
                      dbo.pStyleSeasonYear AS ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID INNER JOIN
                      dbo.pStyleBOM AS sb ON pli.StyleBOMDimensionID = sb.StyleBOMDimensionId INNER JOIN
                      dbo.pMaterial AS m ON sb.MaterialID = m.MaterialID INNER JOIN
                      dbo.pComponentType AS ct ON m.MaterialType = ct.ComponentTypeID LEFT OUTER JOIN
                      dbo.pPlanningMaterial AS pm ON sb.MaterialID = pm.MaterialID AND pm.PlanningID = pli.PlanningID AND pm.SeasonYearID = ssy.SeasonYearID
WHERE     (pm.MaterialID IS NULL) AND (pli.PlanningItemDrop = 'No') AND (ct.Active = 1)
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10010', GetUTCDate())
GO