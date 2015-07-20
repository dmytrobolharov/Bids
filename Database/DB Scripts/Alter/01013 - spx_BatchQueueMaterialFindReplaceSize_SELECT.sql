
/****** Object:  StoredProcedure [dbo].[spx_BatchQueueMaterialFindReplaceSize_SELECT]    Script Date: 01/16/2011 22:24:04 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[spx_BatchQueueMaterialFindReplaceSize_SELECT]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[spx_BatchQueueMaterialFindReplaceSize_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_BatchQueueMaterialFindReplaceSize_SELECT]
( 
	@BatchQueueMaterialReplaceID uniqueidentifier,
	@MaterialID uniqueidentifier
) 
AS


SELECT DISTINCT dbo.bBatchQueueMaterialReplaceStyle.BatchQueueMaterialReplaceID, dbo.bBatchQueueMaterialReplace.MaterialFindID, 
      dbo.bBatchQueueMaterialReplace.MaterialReplaceID, dbo.bBatchQueueMaterialReplace.SeasonYearID, dbo.pMaterialSize.MaterialSize, 
      dbo.pStyleMaterials.MaterialSizeID, dbo.pStyleMaterials.MaterialSizeID AS MaterialReplaceSizeID
FROM  dbo.bBatchQueueMaterialReplace INNER JOIN
      dbo.bBatchQueueMaterialReplaceStyle ON 
      dbo.bBatchQueueMaterialReplace.BatchQueueMaterialReplaceID = dbo.bBatchQueueMaterialReplaceStyle.BatchQueueMaterialReplaceID INNER JOIN
      dbo.pStyleMaterials ON dbo.bBatchQueueMaterialReplaceStyle.StyleID = dbo.pStyleMaterials.StyleID AND 
      dbo.bBatchQueueMaterialReplace.MaterialFindID = dbo.pStyleMaterials.MaterialID INNER JOIN
      dbo.pMaterialSize ON dbo.pStyleMaterials.MaterialSizeID = dbo.pMaterialSize.MaterialSizeID
WHERE bBatchQueueMaterialReplace.MaterialFindID = @MaterialID AND bBatchQueueMaterialReplace.BatchQueueMaterialReplaceID = @BatchQueueMaterialReplaceID

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01013', GetDate())
GO

