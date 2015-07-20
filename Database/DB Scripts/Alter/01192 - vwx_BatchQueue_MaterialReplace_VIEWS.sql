IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = N'vwx_BatchQueue_MaterialReplace_SEL')
    DROP VIEW vwx_BatchQueue_MaterialReplace_SEL
GO


CREATE VIEW [dbo].[vwx_BatchQueue_MaterialReplace_SEL]
AS
SELECT     MaterialFind.MaterialNo + ' - ' + MaterialFind.MaterialName AS MaterialFind, 
                      pMaterialReplace.MaterialNo + ' -  ' + pMaterialReplace.MaterialName AS MaterialReplace, dbo.pSeasonYear.Season, dbo.pSeasonYear.Year, 
                      dbo.bBatchQueueMaterialReplace.TeamID, dbo.bBatchQueueMaterialReplace.BatchQueueMaterialReplaceID, dbo.bBatchQueueMaterialReplace.BatchQueueTypeID, 
                      dbo.bBatchQueueMaterialReplace.MaterialFindID, dbo.bBatchQueueMaterialReplace.MaterialReplaceID, dbo.bBatchQueueMaterialReplace.SeasonYearID, 
                      dbo.bBatchQueueMaterialReplace.CUser, dbo.bBatchQueueMaterialReplace.CDate, dbo.bBatchQueueMaterialReplace.MUser, 
                      dbo.bBatchQueueMaterialReplace.MDate
FROM         dbo.pMaterial AS MaterialFind INNER JOIN
                      dbo.bBatchQueueMaterialReplace ON MaterialFind.MaterialID = dbo.bBatchQueueMaterialReplace.MaterialFindID INNER JOIN
                      dbo.pMaterial AS pMaterialReplace ON dbo.bBatchQueueMaterialReplace.MaterialReplaceID = pMaterialReplace.MaterialID INNER JOIN
                      dbo.pSeasonYear ON dbo.bBatchQueueMaterialReplace.SeasonYearID = dbo.pSeasonYear.SeasonYearID

GO

IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = N'vwx_BatchQueue_MaterialReplace_StyleColor_SEL')
    DROP VIEW vwx_BatchQueue_MaterialReplace_StyleColor_SEL
GO

CREATE VIEW [dbo].[vwx_BatchQueue_MaterialReplace_StyleColor_SEL]
AS
SELECT pMaterialColor.MaterialColorID, pMaterialColor.MaterialID, pMaterialColor.MaterialColorImageID, pMaterialColor.MaterialColorImageVersion, 
      pMaterialColor.ColorFolderID, pMaterialColor.ColorPaletteID, pMaterialColor.ColorID, pMaterialColor.ColorCode, pMaterialColor.ColorNo, 
      pMaterialColor.ColorName, pStyleColorwayItem.StyleColorItemID, pStyleColorwayItem.StyleColorID, pStyleColorwayItem.StyleMaterialID, 
      bBatchQueueMaterialReplaceStyle.StyleID, bBatchQueueMaterialReplaceStyle.BatchQueueMaterialReplaceID, 
      bBatchQueueMaterialReplaceStyle.BatchQueueMaterialReplaceStyleID, bBatchQueueMaterialReplace.MaterialFindID, 
      bBatchQueueMaterialReplace.MaterialReplaceID, bBatchQueueMaterialReplace.SeasonYearID
FROM  pMaterialColor INNER JOIN
      pStyleColorwayItem ON pMaterialColor.MaterialColorID = pStyleColorwayItem.MaterialColorID INNER JOIN
      pStyleColorway ON pStyleColorwayItem.StyleColorID = pStyleColorway.StyleColorID INNER JOIN
      pStyleColorwaySeasonYear ON pStyleColorway.StyleColorID = pStyleColorwaySeasonYear.StyleColorwayID INNER JOIN
      pStyleSeasonYear ON pStyleColorwaySeasonYear.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID INNER JOIN
      bBatchQueueMaterialReplaceStyle ON pStyleSeasonYear.StyleID = bBatchQueueMaterialReplaceStyle.StyleID AND 
      pStyleSeasonYear.SeasonYearID = bBatchQueueMaterialReplaceStyle.SeasonYearID INNER JOIN
      bBatchQueueMaterialReplace ON 
      bBatchQueueMaterialReplaceStyle.BatchQueueMaterialReplaceID = bBatchQueueMaterialReplace.BatchQueueMaterialReplaceID


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01192', GetDate())
GO

