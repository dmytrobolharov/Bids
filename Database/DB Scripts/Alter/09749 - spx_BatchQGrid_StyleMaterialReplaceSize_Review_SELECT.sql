/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_StyleMaterialReplaceSize_Review_SELECT]    Script Date: 24.02.2015 15:45:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_StyleMaterialReplaceSize_Review_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQGrid_StyleMaterialReplaceSize_Review_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_StyleMaterialReplaceSize_Review_SELECT]    Script Date: 24.02.2015 15:45:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_BatchQGrid_StyleMaterialReplaceSize_Review_SELECT](
	@BatchQueueJobId UNIQUEIDENTIFIER,
	@MaterialID UNIQUEIDENTIFIER,
	@MaterialReplaceWithID UNIQUEIDENTIFIER
)
AS 
BEGIN

CREATE TABLE #ms(
	StyleMaterialSizeID  UNIQUEIDENTIFIER,
	BatchQueueJobID UNIQUEIDENTIFIER,
	MaterialSizeOldID UNIQUEIDENTIFIER,
	MaterialSizeNewID UNIQUEIDENTIFIER,
	MaterialSize NVARCHAR(200) COLLATE database_default	
)


-- Delete from pBatchQueueStyleMaterialSizeTmp
DELETE pBatchQueueStyleMaterialSizeTmp
FROM pBatchQueueStyleMaterialSizeTmp a
	LEFT OUTER JOIN dbo.pMaterialSize b ON a.MaterialSizeOldID  =  b.MaterialSizeID
WHERE b.MaterialID = @MaterialID
	AND a.BatchQueueJobID = @BatchQueueJobID 
	AND b.MaterialSize IS NULL



INSERT INTO #ms ( StyleMaterialSizeID, BatchQueueJobID, MaterialSizeOldID, MaterialSizeNewID, MaterialSize)
SELECT NEWID() AS StyleMaterialSizeID, @BatchQueueJobId AS BatchQueueJobId,
	a.MaterialSizeID AS MaterialSizeOldID, NULL AS MaterialSizeNewID,  a.MaterialSize
FROM pMaterialSize a
	LEFT OUTER JOIN  pBatchQueueStyleMaterialSizeTmp b ON a.MaterialSizeID = b.MaterialSizeOldID
		AND b.BatchQueueJobID = @BatchQueueJobID
WHERE A.MaterialID = @MaterialID
	AND MaterialSizeOldID IS NULL 
	
	
UPDATE #ms
SET MaterialSizeNewID = b.MaterialSizeID
FROM #ms a
	INNER JOIN pMaterialSize b ON a.MaterialSize = b.MaterialSize
WHERE b.MaterialID = @MaterialReplaceWithID


INSERT INTO dbo.pBatchQueueStyleMaterialSizeTmp ( StyleMaterialSizeID, BatchQueueJobID, MaterialSizeOldID, MaterialSizeNewID)
SELECT  StyleMaterialSizeID, BatchQueueJobID, MaterialSizeOldID, MaterialSizeNewID FROM #ms


SELECT a.StyleMaterialSizeID, a.MaterialSizeOldID AS MaterialSizeID, a.MaterialSizeNewID, @MaterialReplaceWithID AS MaterialID,
	b.MaterialSize
FROM pBatchQueueStyleMaterialSizeTmp a 
	INNER JOIN dbo.pMaterialSize b WITH(NOLOCK) ON a.MaterialSizeOldID = b.MaterialSizeID
WHERE BatchQueueJobID = @BatchQueueJobID


DROP TABLE #ms

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09749', GetDate())
GO
