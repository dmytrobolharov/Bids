IF OBJECT_ID(N'[dbo].[vwx_PlanningMaterial_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_PlanningMaterial_SEL]
GO
CREATE VIEW [dbo].[vwx_PlanningMaterial_SEL]
AS
SELECT     TOP (100) PERCENT dbo.pPlanningMaterial.PlanningMaterialID, dbo.pPlanningMaterial.PlanningID, dbo.pPlanningMaterial.CUser, dbo.pPlanningMaterial.CDate, dbo.pPlanningMaterial.MUser, 
                      dbo.pPlanningMaterial.MDate, dbo.pPlanningMaterial.MaterialID, dbo.pPlanningMaterial.Sort, dbo.pMaterial.MaterialType, dbo.pComponentType.ComponentDescription AS MaterialTypeName, 
                      '<a custom="' + dbo.pMaterial.MaterialNo + '" href=''../Material/Material_Frame.aspx?MTID=' + CAST(dbo.pMaterial.MaterialID AS NVARCHAR(50)) 
                      + ''' target=''_blank''>' + dbo.pMaterial.MaterialNo + '</a>' AS MaterialNo, dbo.pMaterial.MaterialCode, dbo.pMaterial.MultiDimension, dbo.pMaterial.Notes, dbo.pMaterial.B, 
                      dbo.pMaterial.MaterialImageID, dbo.pMaterial.MaterialImageVersion, dbo.pMaterial.Active, dbo.pPlanningMaterial.PlanningMaterialDrop, dbo.pPlanningMaterial.PlanningMaterialDropUser, 
                      dbo.pPlanningMaterial.PlanningMaterialDropDate, '../System/Control/ImageStream.ashx?S=25&IID=' + CAST(ISNULL(dbo.pMaterial.MaterialImageID, '00000000-0000-0000-0000-000000000000') 
                      AS NVARCHAR(50)) + '&V=' + CAST(ISNULL(dbo.pMaterial.MaterialImageVersion, '0') AS NVARCHAR(50)) AS MaterialImageUrl, '<img src=''' +
                          (SELECT     TOP (1) AppSettingValue
                            FROM          dbo.sAppSetting
                            WHERE      (AppSettingKey = 'ImageServer')) + '/ImageStream.ashx?S=25&IID=' + CAST(ISNULL(dbo.pMaterial.MaterialImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) 
                      + '&V=' + CAST(ISNULL(dbo.pMaterial.MaterialImageVersion, '0') AS NVARCHAR(50)) + '''  />' AS MaterialImagePath, dbo.pPlanningMaterial.SeasonYearID, 
                      dbo.pComponentType.ComponentDescription AS Expr1, dbo.pActive.Custom AS ActiveLabel, dbo.pMaterial.DueDate,
                          (SELECT     COUNT(*) AS Expr1
                            FROM          dbo.pPlanningItem AS pli INNER JOIN
                                                   dbo.pStyleBOM AS sb ON pli.StyleBOMDimensionID = sb.StyleBOMDimensionId INNER JOIN
                                                   dbo.pStyleSeasonYear AS ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID INNER JOIN
                                                   dbo.pPlanningMaterial AS pm ON pli.PlanningID = pm.PlanningID AND ssy.SeasonYearID = pm.SeasonYearID AND sb.MaterialID = pm.MaterialID
                            WHERE      (pm.PlanningMaterialID = dbo.pPlanningMaterial.PlanningMaterialID) AND (pli.PlanningItemDrop = 'No')) AS MaterialUsedInBOMCount, dbo.pMaterial.A, dbo.pMaterial.MaterialName, 
                      dbo.pMaterial.C, dbo.pMaterial.D, dbo.pMaterial.F, dbo.pMaterial.E, dbo.pMaterial.G, dbo.pMaterial.H, dbo.pMaterial.I, dbo.pMaterial.K, dbo.pMaterial.J, dbo.pMaterial.L, dbo.pMaterial.M, 
                      dbo.pMaterial.N, dbo.pMaterial.O, dbo.pMaterial.P, dbo.pMaterial.Q, dbo.pMaterial.R, dbo.pMaterial.S, dbo.pMaterial.T, dbo.pMaterial.V, dbo.pMaterial.U, dbo.pMaterial.W, dbo.pMaterial.X, 
                      dbo.pMaterial.Y, dbo.pMaterial.Z, dbo.pMaterial.VendorPrice, dbo.pMaterial.VendorProductionMin, dbo.pMaterial.VendorProductionLeadTime, dbo.pMaterial.UOM, dbo.pMaterial.VolumePrice
FROM         dbo.pPlanningMaterial INNER JOIN
                      dbo.pMaterial ON dbo.pPlanningMaterial.MaterialID = dbo.pMaterial.MaterialID INNER JOIN
                      dbo.pComponentType ON dbo.pMaterial.MaterialType = dbo.pComponentType.ComponentTypeID LEFT OUTER JOIN
                      dbo.pActive ON dbo.pMaterial.Active = dbo.pActive.CustomKey
ORDER BY dbo.pPlanningMaterial.Sort, dbo.pComponentType.ComponentOrder, MaterialNo

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09994', GetUTCDate())
GO