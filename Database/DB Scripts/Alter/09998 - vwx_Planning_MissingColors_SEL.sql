IF OBJECT_ID(N'[dbo].[vwx_Planning_MissingColors_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_Planning_MissingColors_SEL]
GO
CREATE VIEW [dbo].[vwx_Planning_MissingColors_SEL]
AS
SELECT     ct.PlanningID, ct.SeasonYearID, ct.UsedInBOM, ct.UsedInBOMMaterial, cp.ColorPaletteID, ColFolder.ColorFolderID, ColType.ColorTypeID, cp.ColorCode, 
                      cp.ColorName, cp.ColorSource, cp.ColorNotes, cp.Hex, cp.R, cp.G, cp.B, cp.C, cp.M, cp.Y, cp.K, cp.H, cp.S, cp.L, cp.LAB_L, cp.LAB_A, cp.LAB_B, cp.CUser, cp.CDate, 
                      cp.MUser, cp.MDate, cp.ColorID, cp.Change, cp.Action, cp.Active, cp.Sort, cp.ColorImage, cp.ColorImageType, cp.CopyColorPaletteID, cp.SystemServerStorageID, 
                      cp.ColorPaletteCustom1, cp.ColorPaletteCustom2, cp.ColorPaletteCustom3, cp.ColorPaletteCustom4, cp.ColorPaletteCustom5, cp.ColorPaletteCustom6, 
                      cp.ColorPaletteCustom7, cp.ColorPaletteCustom8, cp.ColorPaletteCustom9, cp.ColorPaletteCustom10, cp.Status, cp.ColorLibraryID, cp.ColorClassID, cp.ImageID, 
                      cp.ImageVersion
FROM         (SELECT     ColorPaletteID, PlanningID, SeasonYearID, SUM(UsedInBOM) AS UsedInBOM, SUM(UsedInBOMMaterial) AS UsedInBOMMaterial
                       FROM          (SELECT     cp.ColorPaletteID, ssy.SeasonYearID, pli.PlanningID, 1 AS UsedInBOM, 0 AS UsedInBOMMaterial
                                               FROM          dbo.pPlanningItem AS pli INNER JOIN
                                                                      dbo.pStyleSeasonYear AS ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID INNER JOIN
                                                                      dbo.pStyleBOMDimensionItem AS sbdi INNER JOIN
                                                                      dbo.pStyleColorway AS sc ON sbdi.ItemDim1Id = sc.StyleColorID OR sbdi.ItemDim2Id = sc.StyleColorID OR 
                                                                      sbdi.ItemDim3Id = sc.StyleColorID INNER JOIN
                                                                      dbo.pColorPalette AS cp ON sc.ColorPaletteID = cp.ColorPaletteID ON pli.StyleBOMDimensionID = sbdi.StyleBOMDimensionID
                                               WHERE      (sbdi.ItemDim1Id IS NOT NULL) AND (sbdi.ItemDim1Active = 1) OR
                                                                      (sbdi.ItemDim2Id IS NOT NULL) AND (sbdi.ItemDim2Active = 1) OR
                                                                      (sbdi.ItemDim3Id IS NOT NULL) AND (sbdi.ItemDim3Active = 1)
                                               UNION
                                               SELECT     mc.ColorPaletteID, ssy.SeasonYearID, pli.PlanningID, 0 AS UsedInBOM, 1 AS UsedInBOMMaterial
                                               FROM         dbo.pPlanningItem AS pli INNER JOIN
                                                                     dbo.pStyleSeasonYear AS ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID INNER JOIN
                                                                     dbo.pStyleBOMItem AS sbi ON pli.StyleBOMDimensionID = sbi.StyleBOMDimensionID INNER JOIN
                                                                     dbo.pStyleBOMDimensionItem AS sbdi INNER JOIN
                                                                     dbo.pStyleColorway AS sc ON sc.StyleColorID IN (sbdi.ItemDim1Id, sbdi.ItemDim2Id, sbdi.ItemDim3Id) ON 
                                                                     sbi.StyleBOMDimensionID = sbdi.StyleBOMDimensionID AND (sbi.ItemDim1Id = sbdi.ItemDim1Id OR
                                                                     sbi.ItemDim2Id = sbdi.ItemDim2Id OR
                                                                     sbi.ItemDim3Id = sbdi.ItemDim3Id) INNER JOIN
                                                                     dbo.pMaterialColor AS mc ON sbi.MaterialColorId = mc.MaterialColorID
                                               WHERE     (sbdi.ItemDim1Id IS NOT NULL) AND (sbdi.ItemDim1Active = 1) OR
                                                                     (sbdi.ItemDim2Id IS NOT NULL) AND (sbdi.ItemDim2Active = 1) OR
                                                                     (sbdi.ItemDim3Id IS NOT NULL) AND (sbdi.ItemDim3Active = 1)
                                               GROUP BY mc.ColorPaletteID, pli.PlanningID, ssy.SeasonYearID) AS ct_1
                       GROUP BY ColorPaletteID, PlanningID, SeasonYearID) AS ct INNER JOIN
                      dbo.pColorPalette AS cp ON ct.ColorPaletteID = cp.ColorPaletteID INNER JOIN
                      dbo.pColorFolder AS ColFolder ON ColFolder.ColorFolderID = cp.ColorFolderID INNER JOIN
                      dbo.pColorType AS ColType ON ColType.ColorTypeID = ColFolder.ColorTypeID LEFT OUTER JOIN
                      dbo.pPlanningColor AS pc ON ct.ColorPaletteID = pc.ColorPaletteID AND ct.PlanningID = pc.PlanningID AND ct.SeasonYearID = pc.SeasonYearID
WHERE     (pc.ColorPaletteID IS NULL)

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09998', GetUTCDate())
GO