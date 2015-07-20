
/****** Object:  View [dbo].[vwx_BatchQueue_MaterialReplace_StyleColor_SEL]    Script Date: 01/16/2011 16:53:49 ******/
IF  EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[dbo].[vwx_BatchQueue_MaterialReplace_StyleColor_SEL]') AND OBJECTPROPERTY(id, N'IsView') = 1)
DROP VIEW [dbo].[vwx_BatchQueue_MaterialReplace_StyleColor_SEL]
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
VALUES ('DB_Version', '4.0.0000', '01016', GetDate())
GO

