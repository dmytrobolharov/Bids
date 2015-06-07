/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_MaterialReplace_BOM_Review_SELECT]    Script Date: 24.02.2015 15:27:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BatchQGrid_MaterialReplace_BOM_Review_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BatchQGrid_MaterialReplace_BOM_Review_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BatchQGrid_MaterialReplace_BOM_Review_SELECT]    Script Date: 24.02.2015 15:27:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_BatchQGrid_MaterialReplace_BOM_Review_SELECT](
	@BatchQueuePagePkName nVARCHAR(200),
	@BatchQueuePageID UNIQUEIDENTIFIER,
	@BatchQueueJobId UNIQUEIDENTIFIER,
	@BatchQueueJobItemId UNIQUEIDENTIFIER,
	@BatchQueueJobTable nVARCHAR(400),
	@BatchQueueId UNIQUEIDENTIFIER,
	@BatchQueueGridSql NVARCHAR(MAX),
	@CUser NVARCHAR(200),
	@CDate DATETIME	,
	@ReturnSQLString INT = 0
)
AS 


DECLARE @MaterialID  UNIQUEIDENTIFIER

--** Get MaterialID to replace with 
SELECT @MaterialID = rec.BatchQueuePagePki 
FROM pBatchQueueJobItem job
INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID
INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
WHERE job.BatchQueueJobID = @BatchQueueJobId AND job.BatchQueueJobSeq = 4


IF @MaterialID IS NOT NULL 
BEGIN 

	--** Get BOM pages
	CREATE TABLE #BOMDimension(
		StyleBOMDimensionID UNIQUEIDENTIFIER
	)

	INSERT INTO #BOMDimension (StyleBOMDimensionID)
	SELECT rec.BatchQueuePagePki 
	FROM pBatchQueueJobItem job
	INNER JOIN pBatchQueuePage pg ON pg.BatchQueuePageID = job.BatchQueuePageID
	INNER JOIN pBatchQueueJobItemRecord rec ON rec.BatchQueuePageID = pg.BatchQueuePageID AND rec.BatchQueueJobItemID = job.BatchQueueJobItemID
	WHERE job.BatchQueueJobID = @BatchQueueJobId AND job.BatchQueueJobSeq = 3

	SELECT a.* FROM vwx_BatchQPage_DimensionalBOM_SEL a WITH(NOLOCK)
	INNER JOIN #BOMDimension b WITH(NOLOCK) ON a.StyleBOMDimensionID = b.StyleBOMDimensionID 
	
	DROP TABLE #BOMDimension
	
END
ELSE 
	SELECT * FROM vwx_BatchQPage_DimensionalBOM_SEL
	WHERE 1 = 2 





GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09732', GetDate())
GO
